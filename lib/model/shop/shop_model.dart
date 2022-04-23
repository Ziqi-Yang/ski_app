import 'package:ski_app/common.dart';
import 'package:ski_app/model/shop/shop_item.dart';
import 'package:ski_app/model/shop/swiper_model.dart';

class ShopModel{
  final List<SwiperModel> swiper;
  final List<ShopItem> itemList;

  ShopModel({required this.swiper,required this.itemList});

  factory ShopModel.fromJson(Map<String, dynamic> json){
    return ShopModel(
        swiper: List<SwiperModel>.from(json["swiper"].map((e) => SwiperModel.fromJson(e))),
        itemList: List<ShopItem>.from(json["itemList"].map((e) => ShopItem.fromJson(e)))
    );
  }

}