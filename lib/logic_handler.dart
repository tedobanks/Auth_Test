import 'dart:async';

import 'package:auth_test/authserive.dart';
import 'package:auth_test/homepage.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import 'confirm.dart';

//after adding to the stream add to the list but use the stream builder, also check the issue of limiting to 4
class LogicHandler extends ChangeNotifier {
  final StreamController<List<int>> myStreamController =
      StreamController<List<int>>();
  // late Stream myStream = myStreamController.stream.asBroadcastStream();
  late StreamSubscription streamSubscription;

  List<int> passcode = [];
  List passcodeConfirmation = [];
  bool authEnabled = false;
  bool authAvailable = false;
  bool authenticated = false;

  authFunc() async {
    authEnabled = await AuthService().checkBiometrics();
    var list = await AuthService().getAvailableBiometrics();
    list.contains(BiometricType.face)
        ? print('face id available')
        : print('face id unavailable');
    authenticated = await AuthService().authenticate();
    authenticated == true
        ? print('User Authenticated')
        : print('Authentication failed');
  }

  Future<List<int>> getList() async {
    await Future.delayed(Duration(seconds: 1));

    return passcode;
  }

  void onpressed(int keyValue, StreamController streamController, List list) {
    if (passcode.length < 4) {
      passcode.add(keyValue);
      streamController.add(passcode);
      print(passcode);
    }

    /*   list.length != 4 ? list.add(keyValue) : null;
    print(list);*/
  }

  void navigate(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ConfirmPasscode()));
  }

  void confirmPasscode(List list, List confirmatory) {
    list == confirmatory ? true : false;
  }

  void advance(BuildContext context) {
    passcodeConfirmation.length == 4 &&
            passcode.toString() == passcodeConfirmation.toString()
        ? Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomePage(),
          ))
        : null;
    print('passcode: ${passcode.length}');
    print("confirmation: ${passcodeConfirmation.length}");
    print(
        'condition: ${passcode.toString() == passcodeConfirmation.toString()}');
    print('passcodeToString: ${passcode.toString()}');
    print('confirmationToString: ${passcodeConfirmation.toString()}');
  }

  void removeLastIndex() {
    passcode.removeLast();
    print(passcode);
    notifyListeners();
  }

  void initFunc() async {
    authFunc();
    AuthService().checkBiometrics();
    AuthService().getAvailableBiometrics();

    var hold = await AuthService().getAvailableBiometrics();
    hold.isEmpty
        ? print('No Biometric type')
        : print('${hold.length} Biometrics available');
    print(passcode);
  }
}
