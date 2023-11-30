import 'package:flutter/material.dart';

class HumidityProvider with ChangeNotifier {
  HumidityProvider() {
    _transitionalValue = _startValue.toDouble();
    _finalValue = _startValue;
  }

  final int _startValue = 35;

  double? _transitionalValue;
  double? get transitionalValue => _transitionalValue;

  int? _finalValue;
  int? get finalValue => _finalValue;

  void updateTrasitionalValue(double updatedValue) {
    _transitionalValue = updatedValue;
    notifyListeners();
  }

  void updateFinalValue() {
    _finalValue = _transitionalValue!.round();
    notifyListeners();
  }
}
