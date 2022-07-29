import 'package:flutter/cupertino.dart';

class PermissionsProvider extends ChangeNotifier {
  bool adminSigned = false;

  void showInDrawerDoctorAddPost(bool state) {
    adminSigned = state;
    print("usertype : doctor $adminSigned");
    notifyListeners();
  }
}
