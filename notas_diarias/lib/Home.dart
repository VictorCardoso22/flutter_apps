// ignore_for_file: prefer_const_constructors, file_names, duplicate_ignore, prefer_final_fields, unused_field, unused_import, unused_local_variable, avoid_print, unused_element, deprecated_member_use, prefer_collection_literals, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:notas_diarias/helper/anotacao_helper.dart';
import 'package:notas_diarias/model/Anotacao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  var _db = AnotacaoHelper();
  List<Anotacao> _anotacoes = [];

  _exibirTelaCadastro({Anotacao? anotacao}) {
    String textoSalvarAtualizar = "";
    if (anotacao == null) {
      _tituloController.text = "";
      _descricaoController.text = "";
      textoSalvarAtualizar = "Salvar";
    } else {
      _tituloController.text = anotacao.titulo!;
      _descricaoController.text = anotacao.descricao!;
      textoSalvarAtualizar = "Atualizar";
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("${textoSalvarAtualizar} anotação!"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _tituloController,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: "Titulo", hintText: "Digite o titulo"),
                ),
                TextField(
                  controller: _descricaoController,
                  autofocus: false,
                  decoration: InputDecoration(
                      labelText: "Descrição", hintText: "Digite o Descrição"),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancelar")),
              TextButton(
                  onPressed: () {
                    _salvarAtualizarAnotacao(anotacaoSelecionada: anotacao);
                    Navigator.pop(context);
                  },
                  child: Text("${textoSalvarAtualizar} ")),
            ],
          );
        });
  }

  _recuperarAnotacoes() async {
    List anotacoesRecuperadas = await _db.recuperarAnotacoes();
    // anotacoes = anotacoesRecuperadas;
    List<Anotacao> listaTemporaria = [];
    for (var item in anotacoesRecuperadas) {
      Anotacao anotacao = Anotacao.fromMap(item);
      listaTemporaria.add(anotacao);
    }

    setState(() {
      _anotacoes = listaTemporaria;
    });
    listaTemporaria = [];

    print("Lista de anotações: " + anotacoesRecuperadas.toString());
  }

  _salvarAtualizarAnotacao({Anotacao? anotacaoSelecionada}) async {
    String? titulo = _tituloController.text;
    String? descricao = _descricaoController.text;

    if (anotacaoSelecionada == null) {
      Anotacao anotacao =
          Anotacao(titulo, descricao, DateTime.now().toString());
      int resultado = await _db.salvarAnotacao(anotacao);
    } else {
      anotacaoSelecionada.titulo = titulo;
      anotacaoSelecionada.descricao = descricao;

      int resultado = await _db.atualizarAnotacao(anotacaoSelecionada);
    }

    // _db.salvarAnotacao(anotacao);

    _tituloController.clear();
    _descricaoController.clear();
    _recuperarAnotacoes();
  }

  _formatarData(String? data) {
    initializeDateFormatting('pt_BR');

    // var formatador = DateFormat("d/M/y H:m:s");
    // var formatador = DateFormat.yMd("pt_BR");
    var formatador = DateFormat.yMMMMd("pt_BR");

    DateTime dataConvertida = DateTime.parse(data!);

    String dataFormatada = formatador.format(dataConvertida);

    return dataFormatada;
  }

  _removerAnotacao(int id) async {
    await _db.removerAnotacao(id);

    _recuperarAnotacoes();
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _recuperarAnotacoes();
  }

  @override
  Widget build(BuildContext context) {
    // _recuperarAnotacoes();
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas anotaçes"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _anotacoes.length,
              itemBuilder: (context, index) {
                final anotacao = _anotacoes[index];
                return Card(
                  child: ListTile(
                    title: Text("${anotacao.titulo}"),
                    subtitle: Text(
                        " ${_formatarData(anotacao.data)} - ${anotacao.descricao}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _exibirTelaCadastro(anotacao: anotacao);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title:
                                        Text("Deseja excluir essa anotação?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("Cancelar")),
                                      TextButton(
                                          onPressed: () {
                                            _removerAnotacao(anotacao.id!);
                                            Navigator.pop(context);
                                          },
                                          child: Text("Excluir")),
                                    ],
                                  );
                                });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          _exibirTelaCadastro();
        },
      ),
    );
  }
}
