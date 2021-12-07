// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_field, deprecated_member_use, unused_local_variable, unused_element, avoid_print, unused_import, avoid_web_libraries_in_flutter, prefer_collection_literals

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> _listaTarefas = [];
  Map<String, dynamic> _ultimaTarefaRemovida = Map();
  TextEditingController _controllerTarefa = TextEditingController();

  Future<File> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/dados.json");
  }

  _salvarTarefa() {
    String textoDigitado = _controllerTarefa.text;

    Map<String, dynamic> tarefa = Map();
    tarefa["titulo"] = textoDigitado;
    tarefa["realizada"] = false;
    setState(() {
      _listaTarefas.add(tarefa);
    });

    _salvaArquivo();
    _controllerTarefa.text = "";
  }

  _salvaArquivo() async {
    var arquivo = await _getFile();

    // Criar Dados

    String dados = json.encode(_listaTarefas);
    arquivo.writeAsString(dados);
  }

  _lerArquivo() async {
    try {
      final arquivo = await _getFile();
      return arquivo.readAsString();
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _lerArquivo().then((dados) {
      setState(() {
        _listaTarefas = json.decode(dados);
      });
    });
  }

  Widget criarItemLista(context, index) {
    // var item = _listaTarefas[index]["titulo"];
    return Dismissible(
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          // recuperar o ultimo item excluido
          _ultimaTarefaRemovida = _listaTarefas[index];
          // remover o item da lista
          _listaTarefas.removeAt(index);
          _salvaArquivo;
          // snackbar
          final snackBar = SnackBar(
            backgroundColor: Colors.black87,
            duration: Duration(seconds: 5),
            content: Text("Tarefa removida!"),
            action: SnackBarAction(
              label: "Desfazer",
              onPressed: () {
                // insere novamente o item removido na lista
                setState(() {
                  _listaTarefas.insert(index, _ultimaTarefaRemovida);
                });

                _salvaArquivo();
              },
            ),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        },
        background: Container(
          color: Colors.green,
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.edit,
                color: Colors.white,
              )
            ],
          ),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.delete,
                color: Colors.white,
              )
            ],
          ),
        ),
        key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
        child: CheckboxListTile(
            title: Text(_listaTarefas[index]["titulo"]),
            value: _listaTarefas[index]["realizada"],
            onChanged: (valorAlterado) {
              setState(() {
                _listaTarefas[index]["realizada"] = valorAlterado;
              });
              _salvaArquivo();
            }));
  }

  @override
  Widget build(BuildContext context) {
    // _salvaArquivo();
    // print("itens: " + _listaTarefas.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.purple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("adicionar Tarefa"),
                  content: TextField(
                    controller: _controllerTarefa,
                    decoration: InputDecoration(
                      labelText: "Digite sua tarefa",
                    ),
                    onChanged: (text) {},
                  ),
                  actions: [
                    FlatButton(
                      child: Text("Cancelar"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    FlatButton(
                      child: Text("Salvar"),
                      onPressed: () {
                        _salvarTarefa();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              });
        },
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: _listaTarefas.length,
            itemBuilder: criarItemLista,
            // return ListTile(
            //   title: Text(_listaTarefas[index]["titulo"]),
            // );
          ))
        ],
      ),
    );
  }
}

// CheckboxListTile(
//                   title: Text(_listaTarefas[index]["titulo"]),
//                   value: _listaTarefas[index]["realizada"],
//                   onChanged: (valorAlterado) {
//                     setState(() {
//                       _listaTarefas[index]["realizada"] = valorAlterado;
//                     });
//                     _salvaArquivo();
//                   })
