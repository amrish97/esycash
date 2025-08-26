import 'package:flutter/material.dart';
import 'package:newcodepluse/providers/mixin/card_mixin.dart';

enum FormStatus { empty, error, success }

class KycProvider extends ChangeNotifier with CardMixin {
  final List<String> tabs = ["Personal Details", "ID Proof", "Bank Details"];
  int selectedIndex = 0;
  final GlobalKey<FormState> personalFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> idFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> bankFormKey = GlobalKey<FormState>();

  List<FormStatus> formStatuses = [
    FormStatus.empty,
    FormStatus.empty,
    FormStatus.empty,
  ];

  void changeTab(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  bool isLoading = false;

  bool get getIsLoading => isLoading;

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  bool validateCurrentForm() {
    bool isValid = false;
    switch (selectedIndex) {
      case 0:
        isValid = personalFormKey.currentState?.validate() ?? false;
        break;
      case 1:
        isValid = idFormKey.currentState?.validate() ?? false;
        break;
      case 2:
        isValid = bankFormKey.currentState?.validate() ?? false;
        break;
    }
    formStatuses[selectedIndex] =
        isValid ? FormStatus.success : FormStatus.error;
    notifyListeners();
    return isValid;
  }
}
