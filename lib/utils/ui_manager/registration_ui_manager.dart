import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base_architecture/utils/ui_manager.dart';

class RegistrationUIManager extends UIManager {
  RegistrationUIManager(BuildContext context) : super(context);

  @override
  Size referenceModel() {
    return Size(1080, 1920);
  }
}
