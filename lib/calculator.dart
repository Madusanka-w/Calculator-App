import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String equation = '0';
  String result = '0';
  String expression = '0';
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equation = '0';
        result = '0';
      } else if (buttonText == '=') {
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('/', '/');
        try {
          final Parser p = Parser();
          final Expression exp = p.parse(expression);
          final ContextModel cm = ContextModel();
          final double evalResult = exp.evaluate(EvaluationType.REAL, cm);
          result = evalResult.toString();
        } catch (e) {
          result = 'Error';
        }
      } else if (buttonText == 'Del') {
        if (equation.length > 1) {
          equation = equation.substring(0, equation.length - 1);
        }
      } else {
        if (equation == '0') {
          equation = buttonText;
        } else {
          equation += buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: ElevatedButton(
        onPressed: () => onButtonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Calculator'),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                style: TextStyle(fontSize: equationFontSize),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                result,
                style: TextStyle(fontSize: resultFontSize),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * .75,
                    child: Table(children: [
                      TableRow(
                        children: [
                          buildButton('C', 1, Colors.blue),
                          buildButton('Del', 1, Colors.blue),
                          buildButton('/', 1, Colors.blue),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton('7', 1, Colors.blue),
                          buildButton('8', 1, Colors.blue),
                          buildButton('9', 1, Colors.blue),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton('4', 1, Colors.blue),
                          buildButton('5', 1, Colors.blue),
                          buildButton('6', 1, Colors.blue),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton('1', 1, Colors.blue),
                          buildButton('2', 1, Colors.blue),
                          buildButton('3', 1, Colors.blue),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton('.', 1, Colors.blue),
                          buildButton('0', 1, Colors.blue),
                          buildButton('00', 1, Colors.blue),
                        ],
                      )
                    ])),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(children: [buildButton('x', 1, Colors.blue)]),
                      TableRow(children: [buildButton('-', 1, Colors.blue)]),
                      TableRow(children: [buildButton('+', 1, Colors.blue)]),
                      TableRow(
                          children: [buildButton('=', 2, Colors.redAccent)]),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
