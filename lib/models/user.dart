import 'address.dart';

class UserModel {
  String firstName;
  String lastName;
  DateTime? birthDate;
  List<Address> addresses;

  UserModel({
    this.firstName = '',
    this.lastName = '',
    this.birthDate,
    List<Address>? addresses,
  }) : addresses = addresses ?? [];

  bool get isComplete => firstName.isNotEmpty && lastName.isNotEmpty && birthDate != null;
}