class ProductsModel {
  String name;
  String image;
  int price;
  int quantity;
  String category;

  ProductsModel({
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.category,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        name: json["name"],
        image: json["image"],
        price: json["price"],
        quantity: json["quantity"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "price": price,
        "quantity": quantity,
        "category": category,
      };
}
