import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/address.dart';
import 'package:uuid/uuid.dart';

class UserProvider extends ChangeNotifier {
  final UserModel _user = UserModel();
  final Uuid _uuid = const Uuid();

  UserModel get user => _user;

  void updateName({required String firstName, required String lastName}) {
    _user.firstName = firstName.trim();
    _user.lastName = lastName.trim();
    notifyListeners();
  }

  void updateBirthDate(DateTime date) {
    _user.birthDate = date;
    notifyListeners();
  }

  void addAddress({required String country, required String department, required String city, required String street}) {
    final newAddress = Address(
      id: _uuid.v4(),
      country: country.trim(),
      department: department.trim(),
      city: city.trim(),
      street: street.trim(),
    );
    _user.addresses.add(newAddress);
    notifyListeners();
  }

  void removeAddress(String id) {
    _user.addresses.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  void clearUser() {
    _user.firstName = '';
    _user.lastName = '';
    _user.birthDate = null;
    _user.addresses.clear();
    notifyListeners();
  }
}