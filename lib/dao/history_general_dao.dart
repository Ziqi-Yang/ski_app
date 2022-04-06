import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ski_app/common.dart' show Api;
import 'package:ski_app/model/history_general_model.dart';

class HistoryGeneralDao{
  static Future<HistoryGeneralModel> fetch() async {
    var url = Uri.parse(Api.historyGeneralNullUser);
    final response = await http.get(url);
    if (response.statusCode == 200){
      Utf8Decoder utf8decoder = const Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HistoryGeneralModel.fromJson(result);
    } else {
      throw Exception("Failed to load setting page json.");
    }
  }
}
