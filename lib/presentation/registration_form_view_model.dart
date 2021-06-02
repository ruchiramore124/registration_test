import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_architecture/viewmodels/base_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:registrationapp/domain/user_domain.dart';
import 'package:registrationapp/utils/sqlite_db.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:device_info/device_info.dart';

///This class is used to handle view model of Registration screen
class RegistrationViewModel extends BaseViewModel {
  RegistrationViewModel();

  // Variable declaration
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController passprtController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  FocusNode dobFocusNode = FocusNode();
  DateTime selectedDate = DateTime.now();
  final picker = ImagePicker();
  SqliteHelper _helper = SqliteHelper();
  String deviceName;
  String imagePath;
  String lat;
  String long;

  bool imageFound = false;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  File _image = File('');

  set image(File value) {
    _image = value;
    notifyListeners();
  }

  File get image => _image;

  Future getImage(ImageSource source,
      {Function(File selectedImage) selectedImageVal}) async {
    var getImage =
        await ImagePicker.pickImage(source: source, imageQuality: 50);
    _image = getImage;
    print("Image is: $image");
    imagePath = getImage.path;
    selectedImageVal(getImage);
    notifyListeners();
  }

  //birth date

  String _birthdayValue = '';

  String get birthdayValue => _birthdayValue;

  set birthdayValue(String value) {
    _birthdayValue = value;
    notifyListeners();
  }

  //get device IMEI number
  String _platformImei = 'Unknown';

  String get platformImei => _platformImei;

  set platformImei(String value) {
    _platformImei = value;
    notifyListeners();
  }

  String _uniqueId = "Unknown";

  String get uniqueId => _uniqueId;

  set uniqueId(String value) {
    _uniqueId = value;
    notifyListeners();
  }

  getDeviceInformation() async {
    try {
      platformImei =
          await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);

      if (Platform.isAndroid) {
        List<String> multiImei = await ImeiPlugin.getImeiMulti();
        print(multiImei);
        if (multiImei.length > 0) {
          uniqueId = multiImei[0];
        } else {
          uniqueId = await ImeiPlugin.getId();
        }
      } else {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

        uniqueId = iosInfo.identifierForVendor;
      }
    } on PlatformException {
      platformImei = 'Failed to get platform version.';
    }
    notifyListeners();
  }

  /*
    All validation for text filed done, for email check if is valid or not, on basis of age passport is mandatory
  */
  String checkFirstName(String text) {
    if (text != null && text.isEmpty) {
      return "Please enter first name";
    }
    return null;
  }

  String checkLastName(String text) {
    if (text != null && text.isEmpty) {
      return "Please enter last name";
    }
    return null;
  }

  String checkDob(String text) {
    if (text != null && text.isEmpty) {
      return "Please select DOB";
    }
    return null;
  }

  String checkPassportNumber(String text) {
    if (text != null && text.isEmpty) {
      if (ageCalculate()) {
        return "Please enter passport id";
      }
    }
    return null;
  }

  String checkEmailIsValid(String text) {
    if (text != null && text.isNotEmpty) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(text);
      if (emailValid) {
        return null;
      }
      return "Email is not valid";
    }
    return null;
  }

  /*
    Method show calender to get date and use date format dd/MM/yyyy to show on text field
  */
  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
      dobController.text = formattedDate;
    }
  }

/*
  Method for to calculate age for mandatory passport if age is greater or equal to 18
 */
  bool ageCalculate() {
    var today = DateTime.now();
    int yearDiff = today.year - selectedDate.year;
    int monthDiff = today.month - selectedDate.month;
    int dayDiff = today.day - selectedDate.day;

    return yearDiff > 18 || yearDiff == 18 && monthDiff >= 0 && dayDiff >= 0;
  }

  /*
Method for validate data , if is validate then inserrted into local database
*/
  validateAndSaveData(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      if (imagePath == null) {
        return;
      }
      UserDomain _userModel = UserDomain(
          imeiNumber: Platform.isAndroid ? uniqueId : "",
          udid: Platform.isIOS ? uniqueId : "",
          firstName: fNameController.text,
          lastName: lNameController.text,
          dob: dobController.text,
          passport: passprtController.text,
          device: Platform.isAndroid
              ? "Android"
              : Platform.isIOS
                  ? "iOS"
                  : "",
          email: emailController.text,
          lat: lat,
          long: long,
          imagePath: this.imagePath);
      bool isInsert = await _helper.insertData(_userModel);
      if (isInsert) {
        imagePath = null;

        fNameController.text = "";
        lNameController.text = "";
        dobController.text = "";
        passprtController.text = "";
        emailController.text = "";
        notifyListeners();
      }
    }
  }

/*
  Method to get user current location using geolocator package
*/
  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position _position = await Geolocator.getCurrentPosition();
    lat = _position.latitude.toString();
    long = _position.longitude.toString();
  }
}
