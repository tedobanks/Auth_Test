import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AuthService {
  final LocalAuthentication auth = LocalAuthentication();
  bool? _canCheckBiometrics;

  Future<bool> checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
      print('Biometrics Available:  ${canCheckBiometrics}');
      return canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
      return canCheckBiometrics;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
      print('Available BiometricTypes:  ${availableBiometrics}');
      return availableBiometrics;
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
      return availableBiometrics;
    }
  }

  Future<bool> authenticate() async {
    bool authenticated = false;

    try {
      authenticated = await auth.authenticate(
        localizedReason: '  ',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      return authenticated;
    } on PlatformException catch (e) {
      authenticated = false;
      print(e);
      return authenticated;
    }
  }
}
