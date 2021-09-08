import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Frases do dia",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  get onPressed => null;

  var _frases = ["Frase 1", "Frase 2", "Frase 3", "Frase 4"];
  var _fraseGerada = "Clique para gerar uma frase!";

  void _gerarFrase() {
    var numeroSorteado = Random().nextInt(_frases.length);

    setState(() {
      _fraseGerada = _frases[numeroSorteado];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Frases do dia"),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            // width: double.infinity,
            // decoration: BoxDecoration(
            //     border: Border.all(width: 3, color: Colors.blueGrey)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset("images/logo.png"),
                Text(
                  _fraseGerada,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 17,
                      fontStyle: FontStyle.italic,
                      color: Colors.black),
                ),
                ElevatedButton(
                  onPressed: _gerarFrase,
                  child: Text('Nova Frase'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
