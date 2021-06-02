import 'dart:async';
import 'package:flutter_base_architecture/data/local/sharedpreferences/user_stores.dart';
import 'package:registrationapp/domain/user_domain.dart';

//This class extends from BASE USER store to stream Logged in user data
class RegistrationDatastore extends UserStore<UserDomain> {
  StreamController<UserDomain> _userController = StreamController<UserDomain>();

  Stream<UserDomain> get user => _userController.stream;

  AwareboxDatastore() {
    getLoggedInUserJson();
  }

  @override
  UserDomain mapUserDto(json) {
    UserDomain user = UserDomain.fromJson(json); //json;
    _userController.add(user);
    return user;
  }
}
