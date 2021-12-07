import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show
        BoxDecoration,
        BuildContext,
        Center,
        CircularProgressIndicator,
        Column,
        ConnectionState,
        Container,
        DecorationImage,
        Divider,
        FutureBuilder,
        Key,
        ListTile,
        ListView,
        NetworkImage,
        State,
        StatefulWidget,
        Text,
        Widget;
import 'package:flutter/rendering.dart';
import 'package:youtube/Api.dart';
import 'package:youtube/model/Video.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class Inicio extends StatefulWidget {
  String pesquisa;
  Inicio(this.pesquisa);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  _listarVideos(String pesquisa) {
    Api api = Api();
    return api.Pesquisar(pesquisa);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      future: _listarVideos(widget.pesquisa),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    List<Video>? videos = snapshot.data;
                    Video video = videos![index];

                    return GestureDetector(
                      onTap: () {
                        FlutterYoutube.playYoutubeVideoByUrl(
                            apiKey: CHAVE_YOUTUBE_API,
                            videoUrl: video.id,
                            autoPlay: true);
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(video.imagem),
                              ),
                            ),
                          ),
                          ListTile(
                              title: Text(video.titulo),
                              subtitle: Text(video.canal)),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                        height: 2,
                      ),
                  itemCount: snapshot.data!.length);
            } else {
              return Center(
                child: Text("Nenhum dado a ser exibido"),
              );
            }
            break;
        }
      },
    );
  }
}
