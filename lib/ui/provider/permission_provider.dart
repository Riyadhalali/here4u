import 'package:flutter/cupertino.dart';

class PermissionsProvider extends ChangeNotifier {
  bool adminSigned = false;
  bool EmployeeSigned = false;

  void showInDrawerDoctorAddPost(bool state) {
    adminSigned = state;
    print("usertype : doctor $adminSigned");
    notifyListeners();
  }

  void showInDrawerEmployeeAddPost(bool state) {
    EmployeeSigned = state;
    print("usertype : doctor $EmployeeSigned");
    notifyListeners();
  }
}
