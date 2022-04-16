class Media{
  List<String>? pictures;
  List<String>? videos;

  Media({this.pictures, this.videos});

  factory Media.fromJson(Map<String, dynamic> json){
    return Media(
      pictures: json["pictures"] != null ? List<String>.from(json["pictures"]) : null,
      videos: json["videos"] != null ? List<String>.from(json["videos"]) : null,
    );
  }
}