import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController phoneNumberController = TextEditingController();
  final FocusNode focusNodePhone = FocusNode();
  bool isLoading = false;

  bool get getIsLoading => isLoading;

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  bool _isRememberClick = false;

  bool get isRememberClick => _isRememberClick;

  void setRememberClick() {
    _isRememberClick = !_isRememberClick;
    notifyListeners();
  }

  bool _acceptTerms = false;

  bool get isAcceptTerms => _acceptTerms;

  void setAcceptTerms() {
    _acceptTerms = !_acceptTerms;
    notifyListeners();
  }
}
