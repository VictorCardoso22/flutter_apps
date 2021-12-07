// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:i18n_extension/i18n_widget.dart';

class Home extends StatefulWidget {
  // const Home({Key? key}) : super(key: key);

  String? nome;
  Home([this.nome]);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controllerPokemon = TextEditingController();
  String _nome = "";
  String _id = '';
  String _altura = "";
  String _peso = "";
  String _habilidade = "";
  String _imagem = "";
  String _tipo = "";
  // String _descricao = "";
  String _descHab = "";

  // var nome;

  // String _idioma = "";

  _recuperar() async {
    // String nome;
    // var pokemonNome;
    // if (this.nome == "") {
    var pokemonNome = _controllerPokemon.text;

    // } else {
    //   var pokemonNome = widget.nome;
    // }

    String url = "https://pokeapi.co/api/v2/pokemon/$pokemonNome/";

    http.Response response;
    response = await http.get(Uri.parse(url));
    Map<String, dynamic> retorno = json.decode(response.body);

    // json.decode(json.encode(response.databody)
    int id = retorno["id"];
    String nome = retorno["name"];
    int altura = retorno["height"];
    int peso = retorno["weight"];

    String habilidade = retorno["abilities"][0]["ability"]["name"];

    String imagem = retorno["sprites"]["other"]["home"]["front_default"];
    String tipo = retorno["types"][0]["type"]["name"];

    // String urlDesc = "https://pokeapi.co/api/v2/characteristic/${id}/";
    // http.Response responseDescricao = await http.get(Uri.parse(urlDesc));
    // Map<String, dynamic> retornoDesc = json.decode(responseDescricao.body);

    // // String descricao = retornoDesc["highest_stat"]["name"];
    // String descricao = retornoDesc["descriptions"][0]["description"];
    // String idioma = retornoDesc["descriptions"][0]["language"]["name"];

    String urlHab = "https://pokeapi.co/api/v2/ability/$id/";
    http.Response responseHabilidade = await http.get(Uri.parse(urlHab));
    Map<String, dynamic> retornoHab = json.decode(responseHabilidade.body);
    String descHab = retornoHab["effect_entries"][0]["effect"];

    setState(() {
      _nome = nome;
      _id = "#${id.toString()}";
      _altura = "Altura: ${altura.toString()} ";
      _peso = " Peso: ${peso.toString()} ";
      _habilidade = "Habilidade principal: $habilidade";
      _imagem = imagem;
      _tipo = "Tipo: $tipo";
      _descHab = descHab;
    });
  }

  _carregarPokemon(String? pokemonNome) async {
    // pokemonNome;
    if (pokemonNome != widget.nome || pokemonNome == "") {
      pokemonNome = _controllerPokemon.text;
    }
    String url2 = "https://pokeapi.co/api/v2/pokemon/${pokemonNome}/";
    http.Response resposta;
    resposta = await http.get(Uri.parse(url2));
    Map<String, dynamic> retorno = json.decode(resposta.body);

    int id = retorno["id"];
    String nome = retorno["name"];
    int altura = retorno["height"];
    int peso = retorno["weight"];

    String habilidade = retorno["abilities"][0]["ability"]["name"];

    String imagem = retorno["sprites"]["other"]["home"]["front_default"];
    String tipo = retorno["types"][0]["type"]["name"];

    String urlHab = "https://pokeapi.co/api/v2/ability/$id/";
    http.Response responseHabilidade = await http.get(Uri.parse(urlHab));
    Map<String, dynamic> retornoHab = json.decode(responseHabilidade.body);
    String descHab = retornoHab["effect_entries"][0]["effect"];

    setState(() {
      _nome = nome;
      _id = "#${id.toString()}";
      _altura = "Altura: ${altura.toString()} ";
      _peso = " Peso: ${peso.toString()} ";
      _habilidade = "Habilidade principal: $habilidade";
      _imagem = imagem;
      _tipo = "Tipo: $tipo";
      _descHab = descHab;
      widget.nome = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    _carregarPokemon(widget.nome);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokedex"),
        backgroundColor: Color(0xff121214),
      ),
      backgroundColor: Color(0xff1F1F33),
      body: SafeArea(
        child: Container(
          // color: Color(0xff1F1F33),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 35,
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          decoration: const InputDecoration(
                            fillColor: Color(0xff9C9CAD),
                            filled: true,
                            labelText: "Digite o nome do pokemon desejado:",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white24,
                              ),
                            ),
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                          controller: _controllerPokemon,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _recuperar,
                        icon: Icon(Icons.search),
                        label: Text("Enviar"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(150, 56),
                          primary: Color(0xff3A3A61),
                          onPrimary: Colors.white,
                          textStyle: TextStyle(
                            // color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: Color(0xff9C9CAD),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        alignment: FractionalOffset(0.0, 1.0),
                        padding: EdgeInsets.all(8),
                        // margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          _nome,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 22,
                            color: Color(0xff222222),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: FractionalOffset(0.0, 1.0),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          _id,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xff666666),
                          ),
                        ),
                      ),
                      Container(
                        // color: Colors.blue,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(220),
                            color: Color(0xff616161)),
                        child: _imagem == ""
                            ? Image.asset("images/pokemon.png")
                            : Image(
                                image: NetworkImage(_imagem),
                                height: 350,
                              ),
                      ),
                      Wrap(
                        children: [
                          Container(
                              width: 200,
                              padding: EdgeInsets.all(16),
                              child: Text(
                                _altura,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff222222),
                                  fontWeight: FontWeight.bold,
                                  // backgroundColor: Color(0xff616161),
                                ),
                              )),
                          Container(
                              // width: 150,
                              padding: EdgeInsets.all(16),
                              child: Text(
                                _peso,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff222222),
                                  fontWeight: FontWeight.bold,
                                  // backgroundColor: Color(0xff616161),
                                ),
                              )),
                          Container(
                              // width: 200,
                              padding: EdgeInsets.all(16),
                              child: Text(
                                _tipo,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff222222),
                                  fontWeight: FontWeight.bold,
                                  // backgroundColor: Color(0xff616161),
                                ),
                              )),
                          Container(
                              // width: 200,
                              padding: EdgeInsets.all(16),
                              child: Text(
                                _habilidade,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff222222),
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Container(child: Text(_idioma)),
                          // Container(child: Text(_descricao)),
                          Container(child: Text(_descHab))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
