import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ski_app/common.dart' show Api;
import 'package:ski_app/model/single_data_model.dart';

class SingleDataDao{
  static Future<SingleDataModle> fetch(String userId,String dataId) async {
    var url = Uri.parse("${Api.singleData}$userId/$dataId");
    final response = await http.get(url);
    if (response.statusCode == 200){
      Utf8Decoder utf8decoder = const Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return SingleDataModle.fromJson(result);
    } else {
      throw Exception("Failed to load setting page json.");
    }
  }
}
