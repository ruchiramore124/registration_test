import 'package:flutter/material.dart';
import 'package:flutter_base_architecture/responsive/orientation_layout.dart';
import 'package:flutter_base_architecture/responsive/screen_type_layout.dart';
import 'package:registrationapp/presentation/base/registration_base.dart';
import 'package:registrationapp/presentation/registration_form_view_model.dart';
import 'package:registrationapp/presentation/registration_view_mobile.dart';

///This class is used to handle view of About screen
class RegistrationFormView extends RegistrationBaseview<RegistrationViewModel> {
  @override
  RegistrationFormViewState createState() => RegistrationFormViewState();
}

///This class is used to handle view state of Registration Screen
class RegistrationFormViewState
    extends RegistrationBaseState<RegistrationViewModel, RegistrationFormView> {
  RegistrationFormViewState() : super() {
    setRequiresLogin(false);
  }

  @override
  Color scaffoldColor() {
    return Colors.white;
  }

  @override
  Future<bool> willPopCallback() async {
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> onModelReady(RegistrationViewModel model) async {
    print('Registration model is ready');
    model.getDeviceInformation();
    model.getLocation();
  }

  @override
  Widget buildBody() {
    return ScreenTypeLayout(
      mobile: OrientationLayoutBuilder(
        portrait: (context) => RegistrationFormMobile(),
      ),
    );
  }

  @override
  RegistrationViewModel initViewModel() {
    return RegistrationViewModel();
  }
}
