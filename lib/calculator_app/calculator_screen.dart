// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String txt = '', temp = '', opr = '';
  double num = 0.0;
  double num2 = 0.0, finalResult = 0.0;
  void calcmanage(String text) {
    if (text == 'AC') {
      txt = '';
      num = 0.0;
      opr = '';
      finalResult = 0.0;
    } else if (text == '%') {
      num = double.parse(txt);
      num = num / 100.0;
      txt = num.toString();
    } else if (text == '+/-') {
      if (txt[0] == '-') {
        txt = txt.substring(1);
      } else {
        txt = '-$txt';
        num = double.parse(txt);
      }
    } else if (text == '.') {
      if (!txt.contains('.')) {
        txt += text;
      }
    } else if (txt == finalResult.toString() &&
        (text == '+' || text == '/' || text == '*' || text == '-')) {
      opr = text;
      txt = '';
    } else if (text != '+' &&
        text != '-' &&
        text != '*' &&
        text != '/' &&
        text != '=') {
      if (txt == finalResult.toString()) {
        txt = '';
        finalResult = 0.0;
      }
      txt += text;
    } else if (text == '+') {
      opr = text;
      num = double.parse(txt) + finalResult;
      txt = '';
    } else if (text == '-') {
      opr = text;
      if (finalResult == 0.0)
        num = double.parse(txt);
      else
        num = finalResult - double.parse(txt);
      txt = '';
    } else if (text == '*') {
      opr = text;
      if (finalResult == 0.0)
        num = double.parse(txt);
      else
        num = finalResult * double.parse(txt);
      txt = '';
    } else if (text == '/') {
      opr = text;
      if (finalResult == 0.0)
        num = double.parse(txt);
      else
        num = finalResult / double.parse(txt);
      txt = '';
    } else if (text == '=') {
      num2 = double.parse(txt);
      if (opr == '+') {
        num += num2;
      } else if (opr == '-') {
        num -= num2;
      } else if (opr == '*') {
        num *= num2;
      } else if (opr == '/') {
        num /= num2;
      }
      finalResult = num;
      txt = finalResult.toString();
    }

    setState(() {});
  }

  Widget calcBtn(String text, Color textColor, Color btnColor) =>
      ElevatedButton(
        onPressed: () {
          calcmanage(text);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: btnColor,
            padding: const EdgeInsets.all(10.0),
            shape: const CircleBorder(),
            minimumSize: const Size(80, 80)),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 25),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Calculator',
        ),
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              txt,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 50),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcBtn('AC', Colors.black, Colors.grey),
                calcBtn('+/-', Colors.black, Colors.grey),
                calcBtn('%', Colors.black, Colors.grey),
                calcBtn('/', Colors.black, Colors.orange),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcBtn('7', Colors.white, Colors.grey[850] as Color),
                calcBtn('8', Colors.white, Colors.grey[850] as Color),
                calcBtn('9', Colors.white, Colors.grey[850] as Color),
                calcBtn('*', Colors.white, Colors.orange),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcBtn('4', Colors.white, Colors.grey[850] as Color),
                calcBtn('5', Colors.white, Colors.grey[850] as Color),
                calcBtn('6', Colors.white, Colors.grey[850] as Color),
                calcBtn('-', Colors.white, Colors.orange),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcBtn('1', Colors.white, Colors.grey[850] as Color),
                calcBtn('2', Colors.white, Colors.grey[850] as Color),
                calcBtn('3', Colors.white, Colors.grey[850] as Color),
                calcBtn('+', Colors.white, Colors.orange),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      txt += '0';
                      temp += '0';
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[850],
                        padding: const EdgeInsets.fromLTRB(43, 20, 128, 28),
                        shape: const StadiumBorder(),
                        minimumSize: const Size(80, 80)),
                    child: const Text(
                      '0',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )),
                calcBtn('.', Colors.white, Colors.grey[850] as Color),
                calcBtn('=', Colors.white, Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
