import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
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
            dataSource: ItemsDataSource(source: _getDataSource()),
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
            GestureDetector(
              onTap: (){},
              child: IconButton(
                onPressed: (){},
                icon: isFav ? const Icon(Icons.favorite) : const Icon(Icons.favorite_outline),
                color: Colors.red,
              ),
            )
          ],
        )    );
  }

  List<Item> _getDataSource() {
    final List<Item> items = <Item>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    items.add(
        Item(70, startTime, endTime, Colors.blueAccent, false));
    items.add(
        Item(65, startTime, endTime, Colors.deepOrangeAccent, true));
    return items;
  }
}

class ItemsDataSource extends CalendarDataSource {
  List<Item> source;
  ItemsDataSource({required this.source});

  // FIXME 加上load more功能
  // 在_getDataSource区域应获取和当前时间在一块区域的数据, 这里获取之后的数据
  // https://help.syncfusion.com/flutter/calendar/load-more
  // https://github.com/syncfusion/flutter-examples/blob/master/lib/samples/calendar/calendar_loadmore.dart

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
}


class Item {
  final int score;
  final DateTime from;
  final DateTime to;
  final Color color;
  final bool isFav;

  Item(this.score, this.from, this.to, this.color, this.isFav);
}

