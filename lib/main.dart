import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String displayText = '0';

  // Button Widget
  Widget calcButton(String btnText, Color btnColor, Color textColor) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          calculation(btnText);
        },
        child: Text(
          '$btnText',
          style: TextStyle(
            fontSize: 35,
            color: textColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          primary: btnColor,
          padding: EdgeInsets.all(20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 51, 51),
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: const Color.fromARGB(255, 49, 49, 49),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Calculator display
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '$displayText',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('AC', Colors.grey, Colors.black),
                calcButton('+/-', Colors.grey, Colors.black),
                calcButton('%', Colors.grey, Colors.black),
                calcButton('/', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton(
                    '7', const Color.fromARGB(255, 11, 11, 11)!, Colors.white),
                calcButton(
                    '8', const Color.fromARGB(255, 16, 16, 16)!, Colors.white),
                calcButton(
                    '9', const Color.fromARGB(255, 20, 20, 20)!, Colors.white),
                calcButton('x', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton(
                    '4', const Color.fromARGB(255, 11, 11, 11)!, Colors.white),
                calcButton(
                    '5', const Color.fromARGB(255, 11, 11, 11)!, Colors.white),
                calcButton(
                    '6', const Color.fromARGB(255, 11, 11, 11)!, Colors.white),
                calcButton('-', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton(
                    '1', const Color.fromARGB(255, 11, 11, 11)!, Colors.white),
                calcButton(
                    '2', const Color.fromARGB(255, 11, 11, 11)!, Colors.white),
                calcButton(
                    '3', const Color.fromARGB(255, 11, 11, 11)!, Colors.white),
                calcButton('+', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // This is button Zero
                ElevatedButton(
                  onPressed: () {
                    calculation('0');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: const Color.fromARGB(255, 0, 0, 0),
                    padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                  ),
                  child: Text(
                    '0',
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                ),
                calcButton(
                    '.', const Color.fromARGB(255, 12, 12, 12)!, Colors.white),
                calcButton('=', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  // Calculator logic
  double numOne = 0;
  double numTwo = 0;
  String result = '';
  String finalResult = '';
  String opr = '';
  String preOpr = '';

  void calculation(String btnText) {
    if (btnText == 'AC') {
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
      numOne = 0;
      numTwo = 0;
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = (numOne / 100).toString();
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.contains('.')) {
        result += '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.startsWith('-')
          ? result = result.substring(1)
          : result = '-' + result;
      finalResult = result;
    } else {
      result += btnText;
      finalResult = result;
    }

    setState(() {
      displayText = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(String result) {
    if (result.contains('.')) {
      List<String> splitDecimal = result.split('.');
      if (splitDecimal[1] == '0') {
        return splitDecimal[0];
      }
    }
    return result;
  }
}
