class HistoryGeneralModel {
  /// data:
  /// {"2022-4-6": [Instance of 'HistoryGeneralCommonItem',..., Instance of 'HistoryGeneralCommonItem'],
  /// "2022-4-5": [Instance of 'HistoryGeneralCommonItem', ...]}

  final Map data;
  final int? next;

  HistoryGeneralModel({required this.data,required this.next});

  factory HistoryGeneralModel.fromJson(Map<String, dynamic> json){
    Map<String, dynamic> daysData = {};
    for (var day in  json["data"].keys){
      var dayData = <HistoryGeneralCommonItem>[];
      for (var d in json["data"][day]){
        dayData.add(HistoryGeneralCommonItem.fromList(d));
      }
      daysData[day] = dayData;
    }
    return HistoryGeneralModel(
        data: daysData,
      next: json["next"]
    );
  }
}


class HistoryGeneralCommonItem {
  final String startTime;
  final String lastTime;
  final int score;
  final double speed;

  const HistoryGeneralCommonItem({required this.startTime,required this.lastTime,
   required this.score,required this.speed});

  factory HistoryGeneralCommonItem.fromList(List<dynamic> data){
    return HistoryGeneralCommonItem(
        startTime: data[0], lastTime: data[1], score: data[2], speed: data[3]);
  }
}


