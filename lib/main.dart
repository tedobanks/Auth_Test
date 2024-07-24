import 'package:auth_test/logic_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';
import 'passcode_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => LogicHandler()..initFunc(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PasscodePage(),
    );
  }
}
