enum Category {
  snack,
  vegetable,
  fruits,
  beverages,
  dairy,
  home,
  electronics,
}

class ProductModel {
  final String name;
  final String imagePath;
  final double price;
  final bool isFresh;
  final Category category;
  final String description;

  const ProductModel({
    required this.name,
    required this.imagePath,
    required this.price,
    this.isFresh = false,
    required this.category,
    this.description = "A fresh and premium quality product carefully sourced for your daily needs. Enjoy the finest selection delivered directly to you.",
  });
}