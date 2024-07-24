import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'button_vals.dart';
import 'logic_handler.dart';

class PasscodePage extends StatefulWidget {
  const PasscodePage({super.key});

  @override
  State<PasscodePage> createState() => _PasscodePageState();
}

class _PasscodePageState extends State<PasscodePage> {
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
            StreamBuilder<List<int>>(
              stream: value.myStreamController.stream,
              builder: (context, snapshot) {
                final currentLength = value.passcode.length;
                return Text(
                  value.passcode.map((n) => '.').join('') +
                      (currentLength < 4 ? '_' : ''),
                  style: TextStyle(
                    fontSize: 120,
                    color: Colors.amber,
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
            ...ButtonVals()
                .values
                .map((e) => GestureDetector(
                      onTap: () {
                        value.onpressed(e['value'] as int,
                            value.myStreamController, value.passcode);
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
            Row(
              children: [
                GestureDetector(
                  onTap: () => value.removeLastIndex(),
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(color: Colors.purple[300]),
                      padding: EdgeInsets.all(10),
                      child: Text('Remove')),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => value.navigate(context),
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(color: Colors.purple[300]),
                      padding: EdgeInsets.all(10),
                      child: Text('Continue')),
                ),
                GestureDetector(
                  onTap: () => value.authFunc(),
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(color: Colors.purple[300]),
                      padding: EdgeInsets.all(10),
                      child: Text('Authenticate')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
