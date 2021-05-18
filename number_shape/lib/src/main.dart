import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _input;
  bool? _square;
  bool? _triangular;
  int? _number;

  bool isSquare(int number) {
    double sr = sqrt(number);
    int sqi = sr.toInt();
    if (sqi * sqi == number) {
      return true;
    }

    return false;
  }

  bool isTriangular(int number) {
    int triangular = pow(number, 1 / 3).round();
    if (triangular * triangular * triangular == number.toInt()) {
      return true;
    }

    return false;
  }

  String getMessage(int number) {
    if (_square! && _triangular!) {
      return number.toString() + ' is both square and triangular number';
    }

    if (_square!) {
      return number.toString() + ' is a square number';
    }

    if (_triangular!) {
      return number.toString() + ' is a triangular number';
    }

    return number.toString() + ' is neither square or triangular number';
  }

  dynamic _createAlertDialog(BuildContext context) {
    return showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              _number!.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            content: Text(
              getMessage(_number!),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            contentTextStyle: TextStyle(
              color: Colors.black,
            ),
            actions: <Widget>[],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'number shape',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(30),
                child: Text(
                  'please input a number to see if it is square or triangular',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.all(30),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  textAlign: TextAlign.center,
                  onChanged: (String value) {
                    setState(() {
                      _input = value;
                    });
                  },
                ),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    if (_input != null) {
                      if (_input!.compareTo("") != 0) {
                        _number = int.parse(_input!);
                        _square = isSquare(_number!);
                        _triangular = isTriangular(_number!);
                        _createAlertDialog(context);
                      }
                    }
                  });
                },
                child: Text(
                  'verify',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                color: Colors.deepPurpleAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
