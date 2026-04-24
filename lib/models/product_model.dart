class ProductModel {
  final String name;
  final String imagePath;
  final double price;
  final bool isFresh;

  const ProductModel({
    required this.name,
    required this.imagePath,
    required this.price,
    this.isFresh = false,
  });
}