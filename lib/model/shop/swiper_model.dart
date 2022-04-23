class SwiperModel{
  final String cover;
  final String? link;

  SwiperModel({required this.cover,required this.link});

  factory SwiperModel.fromJson(Map<String, dynamic> json){
    return SwiperModel(
        cover: json["cover"],
        link: json["link"]);
  }
}