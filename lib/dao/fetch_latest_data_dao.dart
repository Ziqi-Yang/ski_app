import 'package:ski_app/model/history_general_model.dart';
import 'package:ski_app/common.dart' show Api;
import 'dart:convert';
import 'package:http/http.dart' as http;

class FetchLatestDataDao {
  static Future<List> fetch({String userId = "null"}) async{
    var url = Uri.parse("${Api.fetchLatestData}$userId");
    final response = await http.get(url);
    if (response.statusCode == 200){
      Utf8Decoder utf8decoder = const Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return [result["id"],HistoryGeneralCommonItem.fromList(result["data"])];
    } else {
      throw Exception("Failed to load setting page json.");
    }
  }

}