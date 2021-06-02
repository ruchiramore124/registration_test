import 'package:flutter_base_architecture/data/local/sharedpreferences/user_stores.dart';
import 'package:flutter_base_architecture/exception/base_error_handler.dart';
import 'package:provider/single_child_widget.dart';
import 'package:registrationapp/datasource/store/registration_store.dart';
import 'package:registrationapp/domain/user_domain.dart';
import 'package:provider/provider.dart';
import 'package:registrationapp/presentation/base/registration_base.dart';

//To register our services and make use of it
List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];
/*
* SingleChildCloneableWidget base class for providers so that MultiProvider
* can regroup them into a linear list.
* */
List<SingleChildWidget> uiConsumableProviders = [
  StreamProvider<UserDomain>(
    create: (context) =>
        Provider.of<RegistrationDatastore>(context, listen: false).user,
  )
];

/*
* SingleChildCloneableWidget base class for providers so that MultiProvider
* can regroup them into a linear list.
* */
List<SingleChildWidget> independentServices = [
  Provider.value(value: RegistrationDatastore()),
  Provider.value(value: RegistrationErrorParser()),
];

/*
* SingleChildCloneableWidget base class for providers so that MultiProvider
* can regroup them into a linear list.
* A provider that builds a value based on other providers.
* */
List<SingleChildWidget> dependentServices = [
  ProxyProvider<RegistrationErrorParser, ErrorHandler<RegistrationErrorParser>>(
    update: (context, errorParser, errorHandler) =>
        ErrorHandler<RegistrationErrorParser>(errorParser),
  ),
/*
 *User module dependencies -
 */
//UserStore is dependent on RegistrationDatastore
  ProxyProvider<RegistrationDatastore, UserStore<UserDomain>>(
      update: (context, registrationDatastore, userStore) =>
          registrationDatastore),
];
