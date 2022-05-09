import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:ski_app/dao/history_dao.dart';
import 'package:ski_app/model/history_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("历史数据"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
        body: SafeArea(
          child: SfCalendar(
            view: CalendarView.month,
            firstDayOfWeek: 1,
            showDatePickerButton: true,
            showNavigationArrow: true,
            headerStyle: const CalendarHeaderStyle(
              textStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)
            ),
            // cellBorderColor: Colors.black38,
            dataSource: ItemsDataSource(
              source: [], // 无默认(初始)数据
              userId: "100",),
            selectionDecoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.blueAccent, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              shape: BoxShape.rectangle,
            ),
            initialSelectedDate: DateTime.now(),
            monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                showAgenda: true
            ),
            appointmentBuilder: _itemBuilder,
            loadMoreWidgetBuilder:
              (BuildContext context, LoadMoreCallback loadMoreAppointments){
                return FutureBuilder<void>(
                  future: loadMoreAppointments(),
                  builder: (context, snapShot) {
                    return Container(
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: const SpinKitSquareCircle(
                          color: Colors.blue,
                          size: 50,
                        )
                        // child: CircularProgressIndicator(
                        // valueColor: AlwaysStoppedAnimation(Colors.blue))
                    );
                  },
                );
              },
          )
          )
        );
  }

  Widget _itemBuilder(BuildContext context, CalendarAppointmentDetails details){
    Item detail = details.appointments.first;
    DateFormat timeFormatter = DateFormat("HH:MM");
    String startTime = timeFormatter.format(detail.from);
    String endTime = timeFormatter.format(detail.to);
    bool isFav = detail.isFav;

    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Row(
          children: [
            Expanded(child: Container( // FIXME 加入onTap功能
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2),],
                color: detail.color,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${detail.score} 分", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  Text("开始: $startTime  结束: $endTime", style: TextStyle(color: Colors.white.withAlpha(220)),)
                ],
              ),
            )),
            LikeButton(
              isLiked: detail.isFav,
              likeBuilder: (bool isLiked) {
                return Icon(
                  isLiked ? Icons.favorite: Icons.favorite_border,
                  color: isLiked ? Colors.redAccent: Colors.black54,
                  size: 24,
                );
              },
            ),
          ],
        )    );
  }

}

class ItemsDataSource extends CalendarDataSource {
  List<Item> source;
  String userId;

  ItemsDataSource({required this.source, required this.userId});

  final List<int> dataIds = [];
  final List<Color> colorPalette = const [
    // const Color(0xfff6b93b),
    Color(0xffe55039),
    Color(0xff4a69bd),
    Color(0xff60a3bc),
    Color(0xff78e08f),
    Color(0xfffa983a),
    Color(0xffeb2f06),
    Color(0xff1e3799),
    Color(0xff3c6382),
    Color(0xff38ada9),
  ];


  @override
  List<dynamic> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].to;
  }

  @override
  String getSubject(int index) {
    return source[index].score.toString();
  }

  @override
  Color getColor(int index) {
    return source[index].color;
  }

  // Done 加上load more功能
  // 在_getDataSource区域应获取和当前时间在一块区域的数据, 这里获取之后的数据
  // https://help.syncfusion.com/flutter/calendar/load-more
  // https://github.com/syncfusion/flutter-examples/blob/master/lib/samples/calendar/calendar_loadmore.dart
  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
    // startDate example: 2022-04-25 00:00:00.000
    List<Item> newDatas = [];
    DateFormat dateFormat =  DateFormat("yyyy-MM-dd");
    String startDateString = dateFormat.format(startDate);
    String endDateString = dateFormat.format(endDate);
    DateTime curDate = startDate.add(const Duration(days: -1)); // 开始日期前一天

    await HistoryDao.fetch(userId, startDateString, endDateString).then((value){
      List<List<HistoryItem>> historyDatas = value.historyData;
      for (int i = 0; i <  historyDatas.length; i ++){
        curDate = curDate.add(const Duration(days: 1));
        List<HistoryItem> dayDatas = historyDatas[i];
        for (int j = 0; j < dayDatas.length; j ++){
          HistoryItem data = dayDatas[j];
          DateTime startTime = _addTime(curDate, data.startTime);
          DateTime endTime = _addTime(curDate, data.endTime);
          Item tmpItem = Item(data.score, startTime, endTime, colorPalette[j % colorPalette.length], data.isFav);
          if (dataIds.contains(data.dataId)){ //  FIXME 这里改为 dataIds (接口需要改下)
            continue;
          }
          newDatas.add(tmpItem);
          dataIds.add(data.dataId);
        }
      }
    });
    appointments.addAll(newDatas);
    notifyListeners(CalendarDataSourceAction.add, newDatas);
  }

  DateTime _addTime(DateTime date, String timeStr){
    // timeStr 09:01:04
    DateFormat timeFormat = DateFormat("HH:mm:ss");
    DateTime tmp = timeFormat.parse(timeStr);
    DateTime newDate = date.add(Duration(
      hours: tmp.hour,
      minutes: tmp.minute,
      seconds: tmp.second
    ));
    return newDate;
  }

}


class Item {
  final int score;
  final DateTime from;
  final DateTime to;
  final Color color;
  final bool isFav;

  Item(this.score, this.from, this.to, this.color, this.isFav);
}

