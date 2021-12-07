// ignore_for_file: prefer_const_constructors, file_names, duplicate_ignore, prefer_final_fields, unused_field, unused_import, empty_constructor_bodies, unnecessary_null_comparison, unused_local_variable, prefer_const_declarations, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:notas_diarias/model/Anotacao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AnotacaoHelper {
  static final String nomeTabela = "anotacao";
  static final AnotacaoHelper _anotacaoHelper = AnotacaoHelper._internal();
  Database? _db;

  factory AnotacaoHelper() {
    return _anotacaoHelper;
  }

  AnotacaoHelper._internal() {}

  get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await inicializaDb();
      return _db;
    }
  }

  _onCreate(Database db, int version) async {
    String sql =
        "CREATE TABLE $nomeTabela (id INTEGER PRIMARY KEY AUTOINCREMENT, titulo VARCHAR, descricao TEXT, data DATETIME)";
    await db.execute(sql);
  }

  inicializaDb() async {
    final caminhoBanco = await getDatabasesPath();
    final localBanco = join(caminhoBanco, "bd_minhas_anotacoes.db");

    var db = await openDatabase(localBanco, version: 1, onCreate: _onCreate);
    return db;
  }

  Future salvarAnotacao(Anotacao anotacao) async {
    var bancoDados = await db;

    int? resultado = await bancoDados.insert(nomeTabela, anotacao.toMap());

    return resultado;
  }

  recuperarAnotacoes() async {
    var bancoDados = await db;
    String sql = "SELECT * FROM $nomeTabela ORDER BY data DESC";
    List anotacoes = await bancoDados.rawQuery(sql);
    return anotacoes;
  }

  Future atualizarAnotacao(Anotacao anotacao) async {
    var bancoDados = await db;
    return await bancoDados.update(nomeTabela, anotacao.toMap(),
        where: "id = ?", whereArgs: [anotacao.id]);
  }

  Future removerAnotacao(int id) async {
    var bancoDados = await db;
    return await bancoDados
        .delete(nomeTabela, where: "id = ?", whereArgs: [id]);
  }
}
