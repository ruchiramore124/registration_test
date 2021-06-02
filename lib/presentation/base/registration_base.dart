import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_architecture/exception/base_error.dart';
import 'package:flutter_base_architecture/exception/base_error_parser.dart';
import 'package:flutter_base_architecture/ui/base_model_widget.dart';
import 'package:flutter_base_architecture/ui/base_statefulwidget.dart';
import 'package:flutter_base_architecture/ui/base_widget.dart';
import 'package:flutter_base_architecture/viewmodels/base_view_model.dart';
import 'package:registrationapp/domain/user_domain.dart';

///This class is used to handle base view of Registration Application
abstract class RegistrationBaseview<VM extends BaseViewModel>
    extends BaseStatefulWidget<VM> {
  RegistrationBaseview({Key key}) : super(key: key);
}

///This class is used to handle base view state of Registration Application
abstract class RegistrationBaseState<VM extends BaseViewModel,
        T extends RegistrationBaseview<VM>>
    extends BaseStatefulScreen<VM, T, RegistrationErrorParser, UserDomain> {
  /*
  * Initialize the coupon details page state
  * */
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget getLayout() {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          // statusBarColor: getStatusBarColor(),
          ),
      child: BaseWidget<VM>(
        viewModel: getViewModel(),
        onModelReady: onModelReady,
        builder: (BuildContext context, VM model, Widget child) {
          return getAwareboxBaseLayout();
        },
      ),
    );
  }

  void onModelReady(VM model) {}

  /*
  * Return the AppBar widget
  * */
  Widget getAwareboxBaseLayout() {
    return WillPopScope(
      child: Scaffold(
        // resizeToAvoidBottomPadding: resizeToAvoidBottomPadding(),
        resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
        extendBodyBehindAppBar: false,
        //true
        backgroundColor: scaffoldColor(),
        key: scaffoldKey,
        body: buildBody(),
        appBar: buildAppbar(),
        floatingActionButton: floatingActionButton(),
        bottomNavigationBar: buildBottomNavigationBar(),
      ),
      onWillPop: willPopCallback,
    );
  }

  // bool resizeToAvoidBottomPadding() {
  //   return true;
  // }

  Widget buildBottomNavigationBar() {
    return null;
  }

  bool resizeToAvoidBottomInset() {
    return true;
  }

  Future<bool> willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
    return true; // return true if the route to be popped
  }

  @override
  String onBoardingRoutePath() {
    return '';
  }

  //to handle widget for error message
  @override
  String widgetErrorMessage() {
    return 'There was an unexpected error. Please try again later';
  }

  @override
  String errorLogo() {
    return '';
  }

  //to set color to scaffold
  @override
  Color scaffoldColor() {
    return Color(0xffD71717);
  }

  @override
  Color statusBarColor() {
    return Colors.black;
  }
}

///This class is used to handle Error view of Registration Application
class RegistrationError extends BaseError {
  int statusCode;

  RegistrationError({message, type, error, this.statusCode})
      : super(message: message, type: type, error: error);
}

///This class is used to handle Error type of Registration Application
class RegistrationErrorType extends BaseErrorType {
  const RegistrationErrorType(value) : super(value);
  static const RegistrationErrorType SERVER_ERROR_MESSAGE =
      const RegistrationErrorType(6);
}

///This class is used to handle Error pasing of Registration Application
class RegistrationErrorParser extends BaseErrorParser {
  RegistrationErrorParser() : super();

  @override
  String parseError(BuildContext context, BaseError error) {
    var errorMessage = super.parseError(context, error);
    if (errorMessage != null) {
      return errorMessage;
    }

    switch (error.type) {
      case RegistrationErrorType.SERVER_ERROR_MESSAGE:
        return error.message;
      default:
        return "There was an unexpected error. Please try again later";
        break;
    }
  }
}

///This class is used to handle base Ui view of Registration Application
abstract class RegistrationBaseModelWidget<VM>
    extends BaseModelWidget<VM, RegistrationErrorParser> {}
