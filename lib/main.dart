import 'dart:async';
import 'package:flutter/material.dart';
import 'package:registrationapp/registration_application.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Used to simulate sandboxed execution of tasks (Handling error on main)
  runZoned(() async {
    runApp(RegistrationApplication());
  });
}
