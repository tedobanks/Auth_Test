import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'button_vals.dart';
import 'logic_handler.dart';

class ConfirmPasscode extends StatefulWidget {
  const ConfirmPasscode({super.key});

  @override
  State<ConfirmPasscode> createState() => _ConfirmPasscodeState();
}

class _ConfirmPasscodeState extends State<ConfirmPasscode> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LogicHandler>(
      builder: (context, value, child) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            ...ButtonVals()
                .values
                .map((e) => GestureDetector(
                      onTap: () {
                        value.onpressed(e['value'] as int, value.myStreamController, value.passcode);
                      },
                      child: Container(
                        child: Text(e['key'].toString()),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[100],
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      ),
                    ))
                .toList(),
            GestureDetector(
              onTap: () => value.advance(context),
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(color: Colors.purple[300]),
                  padding: EdgeInsets.all(10),
                  child: Text('Advance')),
            ),
          ],
        ),
      ),
    );
  }
}
