class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String brand;
  final String category;
  final double rating;
  final int stock;
  final String thumbnail;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.brand,
    required this.category,
    required this.rating,
    required this.stock,
    required this.thumbnail,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      brand: json['brand'] ?? '',
      category: json['category'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      thumbnail: json['thumbnail'] ?? "https://via.placeholder.com/150",
    );
  }
}
