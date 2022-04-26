class HistoryModel {
  /// data:
  /// {"2022-4-6": [Instance of 'HistoryGeneralCommonItem',..., Instance of 'HistoryGeneralCommonItem'],
  /// "2022-4-5": [Instance of 'HistoryGeneralCommonItem', ...]}

  final Map data;
  final int? next;

  HistoryModel({required this.data,required this.next});

  factory HistoryModel.fromJson(Map<String, dynamic> json){
    Map<String, dynamic> daysData = {};
    for (var day in  json["data"].keys){
      var dayData = <HistoryItem>[];
      for (var d in json["data"][day]){
        dayData.add(HistoryItem.fromList(d));
      }
      daysData[day] = dayData;
    }
    return HistoryModel(
        data: daysData,
      next: json["next"]
    );
  }
}


class HistoryItem {
  final String startTime;
  final String lastTime;
  final int score;
  final double speed;

  const HistoryItem({required this.startTime,required this.lastTime,
   required this.score,required this.speed});

  factory HistoryItem.fromList(List<dynamic> data){
    return HistoryItem(
        startTime: data[0], lastTime: data[1], score: data[2], speed: data[3]);
  }
}


