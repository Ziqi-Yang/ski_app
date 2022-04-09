// | **字段**           | **类型**    | **备注**  |
// |------------------|-----------|---------|
// | start_time       | string    | NonNull |
// | end_time         | string    | NonNull |
// | last_time        | string    | NonNull |
// | score            | int       | NonNull |
// | average_speed    | double       | NonNull |
// | max_slope        | double       | NonNull |
// | max_swivel       | double       | NonNull |
// | swivel_num       | int       | NonNull |
// | instant_speed    | dict      | NonNull |
// | distance         | list<double> | NonNull |
// | speed            | list<double> | NonNull |
// | skeleton_gif_url | string    | NonNull |

class SingleDataModle {
  final String startTime;
  final String endTime;
  final String lastTime;
  final int score;
  final double averageSpeed;
  final double maxSlope;
  final double maxSwivel;
  final int swivelNum;
  final instantSpeedModel instantSpeed;
  final String skeletonGifUrl;

  SingleDataModle({required this.startTime,
    required this.endTime,
    required this.lastTime,
    required this.score,
    required this.averageSpeed,
    required this.maxSlope,
    required this.maxSwivel,
    required this.swivelNum,
    required this.instantSpeed,
    required this.skeletonGifUrl});

  factory SingleDataModle.fromJson(Map<String, dynamic> json){
    return SingleDataModle(
        startTime: json["start_time"],
        endTime: json["end_time"],
        lastTime: json["last_time"],
        score: json["score"],
        averageSpeed: json["average_speed"].toDouble(), // 防止返回整数(就是int了)
        maxSlope: json["max_slope"].toDouble(),
        maxSwivel: json["max_swivel"].toDouble(),
        swivelNum: json["swivel_num"],
        instantSpeed: instantSpeedModel.fromJson(json["instant_speed"]),
        skeletonGifUrl: json["skeleton_gif_url"]);
  }
}

class instantSpeedModel {
  final List<double> distance;
  final List<double> speed;

  instantSpeedModel({required this.distance, required this.speed});

  factory instantSpeedModel.fromJson(Map<String, dynamic> json){
    return instantSpeedModel(
        distance: List<double>.from(json["distance"].map((e) => e.toDouble()).toList()),
        speed: List<double>.from(json["speed"].map((e)=>e.toDouble()).toList())
    );
  }
}