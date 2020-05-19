import 'package:flutter/material.dart';

void main() => runApp(Mycalculator());

class Mycalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Calculator();
  }
}

class _Calculator extends State<Calculator> {
  String text = '0';
  double numone = 0;
  double numtwo = 0;
  String result = '0';
  String finalresult = '0';
  String opr = '';
  String previousopr = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                      text,
                      style: TextStyle(color: Colors.white, fontSize: 60),
                      maxLines: 1,
                      textAlign: TextAlign.right,
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("C", Color(0xffa5a5a5), 1),
                button("+/-", Color(0xffa5a5a5), 1),
                button("%", Color(0xffa5a5a5), 1),
                button("/", Color(0xffff9800), 1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("7", Color(0xff323232), 1),
                button("8", Color(0xff323232), 1),
                button("9", Color(0xff323232), 1),
                button("X", Color(0xffff9800), 1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("4", Color(0xff323232), 1),
                button("5", Color(0xff323232), 1),
                button("6", Color(0xff323232), 1),
                button("-", Color(0xffff9800), 1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("1", Color(0xff323232), 1),
                button("2", Color(0xff323232), 1),
                button("3", Color(0xff323232), 1),
                button("+", Color(0xffff9800), 1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("0", Color(0xff323232), 0),
                button(".", Color(0xff323232), 1),
                button("=", Color(0xff323232), 1)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget button(String btnText, Color color, int number) {
    Container container;
    if (number == 0) {
      container = Container(
        padding: EdgeInsets.only(bottom: 10),
        child: RaisedButton(
          onPressed: () {
            calculate(btnText);
          },
          child: Text(btnText,
              style: TextStyle(
                fontSize: 30,
              )),
          color: color,
          padding: EdgeInsets.only(left: 81, top: 20, right: 81, bottom: 20),
          shape: StadiumBorder(),
        ),
      );
    } else {
      container = Container(
        padding: EdgeInsets.only(bottom: 10),
        child: RaisedButton(
          onPressed: () {
            calculate(btnText);
          },
          child: Text(btnText,
              style: TextStyle(
                fontSize: 30,
              )),
          color: color,
          padding: EdgeInsets.all(20),
          shape: CircleBorder(),
        ),
      );
    }
    return container;
  }

  void calculate(txtBtn) {
    if (txtBtn == 'C') {
      text = '0';
      numone = 0;
      numtwo = 0;
      result = '';
      finalresult = '0';
      opr = '';
      previousopr = '';
    } else if (opr == "=" && txtBtn == "=") {
      switch (previousopr) {
        case '+':
          finalresult = add();
          break;
        case '-':
          finalresult = sub();
          break;
        case '/':
          finalresult = div();
          break;
        case 'X':
          finalresult = mul();
          break;
      }
    } else if (txtBtn == '+' ||
        txtBtn == '-' ||
        txtBtn == '/' ||
        txtBtn == 'X' ||
        txtBtn == '=') {
      if (numone == 0) {
        numone = double.parse(result);
      } else {
        numtwo = double.parse(result);
      }
      switch (opr) {
        case '+':
          finalresult = add();
          break;
        case '-':
          finalresult = sub();
          break;
        case '/':
          finalresult = div();
          break;
        case 'X':
          finalresult = mul();
          break;
      }
      previousopr = opr;
      opr = txtBtn;
      result = '';
    } else if (txtBtn == '%'){
      result = (numone / 100).toString();
      finalresult = result;
    }
    else if (txtBtn == '+/-'){
      result.startsWith('-') ? result.substring(1): result = '-' + result;
    }
    else if (txtBtn == '.'){
      if (!result.contains('.'))
        result += '.';
      finalresult = result;
    }
    else {
      if (result == '0')
        result = txtBtn;

      result = result + txtBtn;
      finalresult = result;
    }
    setState(() {
      text = finalresult;
    });
  }

  String add() {
    result = (numone + numtwo).toString();
    numone = double.parse(result);
    return decimalRemove(result);
  }

  String sub() {
    result = (numone - numtwo).toString();
    numone = double.parse(result);
    return decimalRemove(result);
  }

  String mul() {
    result = (numone * numtwo).toString();
    numone = double.parse(result);
    return decimalRemove(result);
  }

  String div() {
    result = (numone / numtwo).toString();
    numone = double.parse(result);
    return decimalRemove(result);
  }
  String decimalRemove(String _result){
    if (_result.contains('.')){
      List<String> split = _result.split('.');
      if (!(int.parse(split[1]) > 0) )
        return split[0];
    }
    return _result;
  }
}
