import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ski_app/model/shop/shop_model.dart';
import 'package:ski_app/common.dart' show Api;

class ShopDao{
  static Future<ShopModel> fetch() async {
    var url = Uri.parse(Api.shopIndex);
    final response = await http.get(url);
    if (response.statusCode == 200){
      Utf8Decoder utf8decoder = const Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return ShopModel.fromJson(result);
    } else {
      throw Exception("Failed to load setting page json.");
    }
  }
}