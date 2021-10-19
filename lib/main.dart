import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

void main() => runApp(const MaterialApp(home: Scaffold(body: TestWidget())));

class TestWidget extends StatelessWidget {
  /* Also added biometrics support into:
    android/app/src/main/AndroidManifest.xml
    android/app/src/main/kotlin/MainActivity.kt
    ios/Runner/Info.plist
  */
  const TestWidget({Key? key}) : super(key: key);

  Future<bool> checkAuth() async {
    final auth = LocalAuthentication();
    final deviceSupportsBiometrics = await auth.canCheckBiometrics;
    if (deviceSupportsBiometrics) {
      return auth.authenticate(
        localizedReason: 'Scan fingerprint to authenticate',
        biometricOnly: true,
        useErrorDialogs: true,
        stickyAuth: true,
      );
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: checkAuth(),
        builder: (context, snapshot) => Text(snapshot.data.toString()),
      ),
    );
  }
}
