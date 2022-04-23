class ShopItem{
  final String cover;
  final String description;
  final String? details;
  final double price;
  final String externalLink;

  ShopItem({required this.cover, required this.description, required this.details,
    required this.price,required this.externalLink});

  factory ShopItem.fromJson(Map<String, dynamic> json){
    return ShopItem(
        cover: json["cover"],
        description: json["description"],
        details: json["details"],
        price: json["price"].toDouble(),
        externalLink: json["externalLink"]);
  }
}