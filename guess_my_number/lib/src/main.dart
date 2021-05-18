import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
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
  int? _random_number;
  int? _guessed_number;
  bool? _pressed;
  bool? _lower;
  bool? _higher;
  bool? _success;

  String getSuccessMessage() {
    return 'It was ' + _random_number.toString();
  }

  dynamic _createAlertDialog(BuildContext context) {
    return showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "You guessed right",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            content: Text(
              getSuccessMessage(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            contentTextStyle: TextStyle(
              color: Colors.black,
            ),
            actions: <Widget>[
              RaisedButton(
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Try again',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'guess my number',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  "I'm thinking of a number between 1 and 100.",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  "It's your turn to guess my number!",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (_pressed != null && _pressed!) ...<Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    "You tried",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              if (_lower != null && _lower!) ...<Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    "Lower",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              if (_higher != null && _higher!) ...<Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    "Higher",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              Container(
                child: Card(
                  elevation: 5,
                  color: Colors.orangeAccent,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Text(
                          'Try a number!',
                          style: TextStyle(
                            fontSize: 25,
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
                            if (_pressed == null) {
                              _random_number = Random().nextInt(100) + 1;
                              print(_random_number);
                              _pressed = true;

                              _guessed_number = int.parse(_input!);
                              if (_guessed_number == _random_number) {
                                _createAlertDialog(context);
                              } else {
                                if (_guessed_number! > _random_number!) {
                                  _lower = true;
                                  _higher = false;
                                } else {
                                  _higher = true;
                                  _lower = false;
                                }
                              }
                            } else {
                              _guessed_number = int.parse(_input!);
                              if (_guessed_number == _random_number) {
                                _createAlertDialog(context);
                                _lower = null;
                                _higher = null;
                                _pressed = null;
                              } else {
                                if (_guessed_number! > _random_number!) {
                                  _lower = true;
                                  _higher = false;
                                } else {
                                  _higher = true;
                                  _lower = false;
                                }
                              }
                            }
                          });
                        },
                        child: Text(
                          'Guess',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
