import 'package:flutter/material.dart';

class CurrentLocation extends ChangeNotifier {
  String _city = "";
  String _state = "";
  String _country = "";
  String _locality = "";
  String _postalCode = "";
  String _addressSubAdminArea = "";

  String get city => _city;
  String get state => _state;
  String get country => _country;
  String get locality => _locality;
  String get postalCode => _postalCode;
  String get addressSubAdminArea => _addressSubAdminArea;

  void updateLocation({
    required String city,
    required String state,
    required String country,
    required String locality,
    required String postalCode,
    required String addressSubAdminArea,
  }) {
    _city = city;
    _state = state;
    _country = country;
    _locality = locality;
    _postalCode = postalCode;
    _addressSubAdminArea = addressSubAdminArea;
    notifyListeners();
  }
}
