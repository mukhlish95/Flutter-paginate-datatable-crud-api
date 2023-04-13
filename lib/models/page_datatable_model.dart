class PageDatatableModel {
  final int id;
  final int power;
  final int price;

  const PageDatatableModel({
    required this.id,
    required this.power,
    required this.price,
  });

  factory PageDatatableModel.fromJson(Map<String, dynamic> json) {
    return PageDatatableModel(
      id: json['id'],
      power: json['power'],
      price: json['price'],
    );
  }
}
