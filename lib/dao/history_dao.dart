import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ski_app/common.dart';
import 'package:ski_app/model/history_model.dart';

class HistoryDao{
  static Future<HistoryModel> fetch(String userId, String from, String to) async {
    var url = Uri.parse(Api.history);
    Map<String, dynamic> queryBody = {
      "userId": userId,
      "from": from,
      "to": to
    };
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(queryBody));
    if (response.statusCode == 200){
      Utf8Decoder utf8decoder = const Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HistoryModel.fromJson(result);
    } else {
      throw Exception("Failed to load setting page json.");
    }
  }
}
