class Video {
  var id;
  var titulo;
  var descricao;
  var imagem;
  var canal;

  Video({this.id, this.titulo, this.descricao, this.imagem, this.canal});

  // static converterJson(Map<String, dynamic> json) {
  //   return Video(
  //       id: json["id"]["videoId"],
  //       titulo: json["snippet"]["titulo"],
  //       // descricao: json["id"]["videoId"],
  //       imagem: json["snippet"]["thumbnails"]["high"]["url"],
  //       canal: json["snippet"]["chanelId"]);
  // }

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json["id"]["videoId"],
      titulo: json["snippet"]["title"],
      descricao: json["snippet"]["description"],
      imagem: json["snippet"]["thumbnails"]["high"]["url"],
      canal: json["snippet"]["channelTitle"],
    );
  }
}
