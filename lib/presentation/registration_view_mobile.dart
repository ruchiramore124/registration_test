import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:registrationapp/presentation/base/registration_base.dart';
import 'package:registrationapp/presentation/registration_form_view_model.dart';
import 'package:registrationapp/utils/asset_icons/asset_icons.dart';
import 'package:registrationapp/utils/registration_colors.dart';
import 'package:registrationapp/utils/svg_loader/svg_loader.dart';
import 'package:registrationapp/utils/ui_manager/registration_size_helper.dart';
import 'package:image_picker/image_picker.dart';

import 'Widgets/TextFieldCustome.dart';

///This class is used to design view of 'Registration Form' screen
class RegistrationFormMobile
    extends RegistrationBaseModelWidget<RegistrationViewModel> {
  DateTime _date = new DateTime.now();

  @override
  Widget build(BuildContext context, RegistrationViewModel model) {
    final sizeHelper = RegistrationSizeHelper(context);
    return Stack(
      children: <Widget>[
        CustomScrollView(
          slivers: [
            //profile picture selection
            _profileImageWidget(sizeHelper, context, model),
            //display IMEI
            _deviceInfoIMEI(sizeHelper, model),
            _formLayout(model, sizeHelper, context),
            _saveButton(sizeHelper, context, model)
          ],
        ),

        //display app bar with title
        _appBarUI(sizeHelper)
      ],
    );
  }

  //Application App Bar
  Widget _appBarUI(RegistrationSizeHelper sizeHelper) {
    return Container(
      width: sizeHelper.sizeBackground.width,
      height: sizeHelper.genericLeftRightPaddingSpace * 4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: RegistrationColors.backgroundDark.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: sizeHelper.genericLeftRightPaddingSpace,
            right: sizeHelper.genericLeftRightPaddingSpace,
            top: sizeHelper.genericLeftRightPaddingSpace * 2),
        child: Text(
          'Registration Form',
          style: TextStyle(
              color: RegistrationColors.blackColor,
              fontSize: sizeHelper.genericTitleHeaderSize),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  //Set profile pic
  _profileImageWidget(RegistrationSizeHelper sizeHelper, BuildContext context,
      RegistrationViewModel model) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            EdgeInsets.only(top: sizeHelper.genericLeftRightPaddingSpace * 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            model.image == null || model.image.path.isEmpty
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.15,
                    margin: EdgeInsets.only(top: 100),
                    decoration: BoxDecoration(
                        color: Colors.grey, shape: BoxShape.circle),
                    child: _buildNoImageView(context, sizeHelper, model))
                : Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.15,
                    margin: EdgeInsets.only(top: 100),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: FileImage(model.image), fit: BoxFit.cover))),
            Container(
              decoration: BoxDecoration(
                color: RegistrationColors.whiteBG,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: RegistrationColors.grayDropShadow,
                    blurRadius: 2.0,
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(sizeHelper.cameraIconSpacing),
                child: GestureDetector(
                  onTap: () async {
                    print('Upload profile image');
                    await model.getImage(ImageSource.camera,
                        selectedImageVal: (value) {
                      model.image = value;
                    });
                  },
                  child: SVGLoader(
                    urlImage: AssetIcons.add_photo,
                    color: RegistrationColors.blackColor,
                    svgSize: sizeHelper.sizeCamera,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //build no image view with placeholder
  Widget _buildNoImageView(BuildContext context,
      RegistrationSizeHelper sizeHelper, RegistrationViewModel model) {
    return SVGLoader(
      urlImage: AssetIcons.photo_placeholder,
      color: RegistrationColors.grayDropShadow,
      svgSize: sizeHelper.sizeProfileIcon,
    );
  }

  //display device IMEI number
  _deviceInfoIMEI(
      RegistrationSizeHelper sizeHelper, RegistrationViewModel model) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
            top: sizeHelper.genericLeftRightPaddingSpace * 2,
            left: sizeHelper.genericLeftRightPaddingSpace,
            right: sizeHelper.genericLeftRightPaddingSpace),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text('IMEI : ${model.uniqueId}',
                  maxLines: 2,
                  style: TextStyle(
                      color: RegistrationColors.blackColor,
                      fontSize: sizeHelper.genericSubtitleHeaderSize),
                  textAlign: TextAlign.center),
            )
          ],
        ),
      ),
    );
  }

  _formLayout(RegistrationViewModel model, RegistrationSizeHelper sizeHelper,
      BuildContext context) {
    return SliverToBoxAdapter(
      child: _buildFormLayout(sizeHelper, context, model),
    );
  }

  _buildFormLayout(RegistrationSizeHelper sizeHelper, BuildContext context,
      RegistrationViewModel model) {
    return Column(
      children: [
        Form(
          key: model.formKey,
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              TextFieldCustome(
                hintText: "First Name",
                controller: model.fNameController,
                validator: model.checkFirstName,
              ),
              SizedBox(
                height: 5,
              ),
              TextFieldCustome(
                hintText: "Last Name",
                controller: model.lNameController,
                validator: model.checkLastName,
              ),
              SizedBox(
                height: 5,
              ),
              TextFieldCustome(
                hintText: "DOB",
                controller: model.dobController,
                readOnly: true,
                onTap: () {
                  model.selectDate(context);
                },
                suffixIcon: Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.blueAccent,
                ),
                validator: model.checkDob,
              ),
              SizedBox(
                height: 5,
              ),
              TextFieldCustome(
                hintText: "Passport number",
                controller: model.passprtController,
                validator: model.checkPassportNumber,
              ),
              SizedBox(
                height: 5,
              ),
              TextFieldCustome(
                hintText: "Email",
                controller: model.emailController,
                validator: model.checkEmailIsValid,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _saveButton(RegistrationSizeHelper sizeHelper, BuildContext context,
      RegistrationViewModel model) {
    return SliverToBoxAdapter(
      child: ElevatedButton(
        onPressed: () {
          model.validateAndSaveData(context);
        },
        child: Text("Save"),
      ),
    );
  }
}
