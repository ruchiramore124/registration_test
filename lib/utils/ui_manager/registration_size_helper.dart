import 'package:flutter/material.dart';
import 'package:registrationapp/utils/ui_manager/registration_ui_manager.dart';

///This class is used to handle Base size class of Registration Application
class RegistrationSizeHelper extends RegistrationUIManager {
  final BuildContext _context;

  RegistrationSizeHelper(BuildContext context)
      : _context = context,
        super(context);

  Size _sizeAppBar = Size(60, 60);

  Size get sizeproductStatus => Size(
      width(_context, _sizeAppBar.width), height(_context, _sizeAppBar.height));

  Size _sizeBackground = Size(1080, 1920);

  Size get sizeBackground => Size(width(_context, _sizeBackground.width),
      height(_context, _sizeBackground.height));

  ///set sizes to Title Header
  ///Title Header - Regular
  double _titleHeaderRegularTextSize = 56;

  double get titleHeaderRegularTextSize =>
      size(_context, _titleHeaderRegularTextSize);

  double _titleHeaderMediumTextSize = 55;

  double get titleHeaderMediumTextSize =>
      size(_context, _titleHeaderMediumTextSize);

  double _genericLeftRightPaddingSpace = 50;

  double get genericLeftRightPaddingSpace =>
      size(_context, _genericLeftRightPaddingSpace);

  double _genericTitleHeaderSize = 50;

  double get genericTitleHeaderSize => size(_context, _genericTitleHeaderSize);

  double _genericSubtitleHeaderSize = 40;

  double get genericSubtitleHeaderSize =>
      size(_context, _genericSubtitleHeaderSize);

  Size _sizeProfileIcon = Size(100, 100);

  Size get sizeProfileIcon => Size(width(_context, _sizeProfileIcon.width),
      height(_context, _sizeProfileIcon.height));

  double _cameraIconSpacing = 20.00;

  double get cameraIconSpacing => height(_context, _cameraIconSpacing);
  Size _sizeCamera = Size(49.51, 49.51);

  Size get sizeCamera => Size(
      width(_context, _sizeCamera.width), height(_context, _sizeCamera.height));

  Size _sizeTxtForm = Size(470, 120);

  Size get sizeTxtForm => Size(
      width(_context, _sizeTxtForm.width),
      height(_context, _sizeTxtForm.height));
  Size _sizeCalenderIcon = Size(50, 50);

  Size get sizeCalenderIcon => Size(width(_context, _sizeCalenderIcon.width),
      height(_context, _sizeCalenderIcon.height));

}
