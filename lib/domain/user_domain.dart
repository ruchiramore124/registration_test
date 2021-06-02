import 'package:flutter_base_architecture/dto/base_dto.dart';

class UserDomain extends BaseDto {
  final String imeiNumber;
  final String udid;
  final String firstName;
  final String lastName;
  final String dob;
  final String passport;
  final String email;
  final String device;
  final String lat;
  final String long;
  final String imagePath;

  UserDomain(
      {this.imeiNumber,
      this.udid,
      this.firstName,
      this.lastName,
      this.dob,
      this.passport,
      this.email,
      this.device,
      this.lat,
      this.long,
      this.imagePath});

  @override
  Map<String, dynamic> toJson() {}

  factory UserDomain.fromJson(Map<String, dynamic> json) {
    return UserDomain();
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }
}
