class CatalogModel {
  static List<Item> items = [];
}

class Item {
  final int id;
  final String name;
  final String des;
  final num price;
  final String color;
  final String image;

  Item(
      {required this.id,
      required this.name,
      required this.des,
      required this.price,
      required this.color,
      required this.image});

  factory Item.fromMap(Map<dynamic, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      des: map['des'],
      price: map['price'],
      color: map['color'],
      image: map['image'],
    );
  }

  toMap() => {
        "id": id,
        "name": name,
        "des": des,
        "price": price,
        "color": color,
        "image": image,
      };
}
