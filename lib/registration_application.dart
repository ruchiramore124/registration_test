import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:registrationapp/di/providers.dart';
import 'package:registrationapp/route_paths.dart';
import 'package:registrationapp/router.dart';
import 'package:registrationapp/utils/registration_colors.dart';

///This class is used to create of Registration application
class RegistrationApplication extends StatefulWidget {
  @override
  _State createState() => _State();
}

///This class is used to handle Registration base for initial updates
class _State extends State<RegistrationApplication> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
        providers: providers,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              appBarTheme: AppBarTheme(
                  color: RegistrationColors.transparentBG,
                  textTheme: TextTheme(
                      headline6: TextStyle(
                          fontFamily: 'Montserrat',
                          color: RegistrationColors.blackColor)),
                  iconTheme: IconThemeData(
                    color: RegistrationColors.blackColor,
                  ))),
          initialRoute: RoutePaths.RegistrationView,
          onGenerateRoute: RegistrationRouter.generateRoute,
        ));
  }
}
