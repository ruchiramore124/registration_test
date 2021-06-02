import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:registrationapp/presentation/registration_form_view.dart';
import 'package:registrationapp/route_paths.dart';

///This class is used to generate routes for Navigation
class RegistrationRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.RegistrationView:
        return CupertinoPageRoute(builder: (_) => RegistrationFormView());
        break;
    }
  }
}
