import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:youtube/model/Video.dart';

const CHAVE_YOUTUBE_API = "AIzaSyCGAOyy4pJ5Pu_ucU0-hUmVP84nqQKZZqI";
const ID_CANAL = "UCS50i82KsvUJT4U5q_p7PMA";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

// "476069481328-9fanr326j257u5n69isat41ta5ikkpq1.apps.googleusercontent.com"

class Api {
  Future<List<Video>> Pesquisar(String pesquisa) async {
    http.Response response = await http.get(Uri.parse(URL_BASE +
        "search"
            "?part=snippet"
            "&type=video"
            "&maxResults=20"
            "&order=date"
            "&key=$CHAVE_YOUTUBE_API"
            "&channelId=$ID_CANAL"
            "&q=$pesquisa"));

    // if (response.statusCode == 200) {
    Map<String, dynamic> dadosJson = json.decode(response.body);

    List<Video> videos = dadosJson["items"].map<Video>((map) {
      return Video.fromJson(map);
    }).toList();

    return videos;
    //print("Resultado: " + videos.toString() );

    /*
      for( var video in dadosJson["items"] ){
        print("Resultado: " + video.toString() );
      }*/
    //print("resultado: " + dadosJson["items"].toString() );

    // } else {
    // ignore: avoid_print
    // return List [];
    // }
  }
}
