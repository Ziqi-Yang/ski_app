class HistoryModel {
  final List<List<HistoryItem>> historyData;

  HistoryModel({required this.historyData});

  factory HistoryModel.fromJson(List<dynamic> json){
    List<List<HistoryItem>> historyData = [];
    for (int day = 0; day < json.length; day ++){
      var dayData = List<HistoryItem>.from(json[day].map((e) => HistoryItem.fromJson(e)));
      historyData.add(dayData);
    }
    return HistoryModel(
        historyData: historyData
    );
  }
}


class HistoryItem {
  final String startTime;
  final String endTime;
  final int score;
  final double speed;
  final bool isFav;
  final int dataId;

  const HistoryItem({required this.startTime,required this.endTime,
    required this.score, required this.isFav, required this.speed,
    required this.dataId
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json){
    return HistoryItem(
        startTime: json["startTime"], endTime: json["endTime"], score: json["score"],
        isFav: json["isFav"], speed: json["averageSpeed"], dataId: json["dataId"]);
  }
}


