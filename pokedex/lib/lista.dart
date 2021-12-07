import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokedex/home.dart';

class Lista extends StatefulWidget {
  const Lista({Key? key}) : super(key: key);

  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  Future<List<Pokemon>> _carregaPokemon() async {
    String url = "https://pokeapi.co/api/v2/pokemon?limit=100&offset=0";

    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> dadosJson = json.decode(response.body);

    // dadosJson = dadosJson.toString();

    List<Pokemon> pokemons = dadosJson["results"].map<Pokemon>((map) {
      return Pokemon.fromJson(map);
    }).toList();
    // print("Resultado: " + dadosJson.toString());
    return pokemons;

    // List<Pokemon> pokemons = [];
    // for (var pokemon in json.decode(response.body)) {
    //   Pokemon p = Pokemon(pokemon["name"], pokemon["url"]);
    //   pokemons.add(p);
    // }
    // print(pokemons.toString());

    // return pokemons;
  }

  @override
  Widget build(BuildContext context) {
    _carregaPokemon();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokedex"),
        backgroundColor: Color(0xff121214),
      ),
      backgroundColor: Color(0xff1F1F33),
      body: FutureBuilder<List<Pokemon>>(
          future: _carregaPokemon(),
          builder: (context, snapshot) {
            String resultado = "";
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError) {
                  resultado = "Error";
                } else {
                  resultado = "Carregou";
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        // child: ElevatedButton(
                        //   style: ElevatedButton.styleFrom(
                        //     primary: Colors.blue, // background
                        //     onPrimary: Colors.white, // foreground
                        //   ),
                        //   onPressed: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(builder: (context) => Home()),
                        //     );
                        //   },
                        //   child: Text("Pesquisar"),
                        // ),

                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          },
                          icon: Icon(Icons.search),
                          label: Text("Pesquisa individual:"),
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
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              List<Pokemon>? lista = snapshot.data;
                              Pokemon pokemon = lista![index];
                              pokemon._nome;

                              return GestureDetector(
                                onTap: () {
                                  // var pokemon;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home(
                                              pokemon._nome,
                                            )),
                                  );
                                },
                                child: Container(
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
                                  margin: EdgeInsets.all(16),
                                  padding: EdgeInsets.all(16),
                                  child: ListTile(
                                    title: Text(pokemon._nome),
                                    subtitle: Text(pokemon.url),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  );
                }
                break;
            }
            return Center(
              child: Text(resultado),
            );
          }),
    );
  }
}

class Pokemon {
  String _nome;

  String _url;

  get nome => _nome;

  set nome(nome) {
    _nome = nome;
  }

  get url => _url;

  set url(url) {
    _url = url;
  }

  Pokemon(this._nome, this._url);

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(json["name"], json["url"]);
  }
}
