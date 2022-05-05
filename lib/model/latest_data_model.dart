class LatestDataModel{
  final String startTime;
  final String lastTime;
  final int score;
  final double averageSpeed;

  LatestDataModel({required this.startTime, required this.lastTime,
    required this.score, required this.averageSpeed});

  factory LatestDataModel.fromJson(Map<String, dynamic> json){
    return LatestDataModel(
        startTime: json["startTime"], lastTime: json["lastTime"],
        score: json["score"], averageSpeed: json["averageSpeed"]);
  }
}