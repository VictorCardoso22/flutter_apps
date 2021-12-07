// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:pokedex/home.dart';
import 'package:pokedex/lista.dart';

class LitaPokemon extends StatefulWidget {
  const LitaPokemon({Key? key}) : super(key: key);

  @override
  _LitaPokemonState createState() => _LitaPokemonState();
}

class _LitaPokemonState extends State<LitaPokemon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokedex"),
        backgroundColor: Color(0xff121214),
      ),
      body: SafeArea(child: Container(child: Lista())),
    );
  }
}


// String imagem = retorno["sprites"]["other"]["home"]["front_default"];
