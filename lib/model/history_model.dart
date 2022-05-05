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

  const HistoryItem({required this.startTime,required this.endTime,
    required this.score, required this.isFav, required this.speed});

  factory HistoryItem.fromJson(Map<String, dynamic> data){
    return HistoryItem(
        startTime: data["startTime"], endTime: data["endTime"], score: data["score"],
        isFav: data["isFav"], speed: data["averageSpeed"]);
  }
}


