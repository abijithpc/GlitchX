import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? id;
  final String name;
  final String description;
  final String category;
  final int diskCount;
  final int price;
  final int stock;
  final String minSpecs;
  final String recSpecs;
  final DateTime releaseDate;
  final List<String> imageUrls;
  final double rating;

  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.diskCount,
    required this.price,
    required this.stock,
    required this.minSpecs,
    required this.recSpecs,
    required this.releaseDate,
    required this.imageUrls,
    required this.rating,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'description': description,
  //     'category': category,
  //     'diskCount': diskCount,
  //     'price': price,
  //     'stock': stock,
  //     'minSpecs': minSpecs,
  //     'recSpecs': recSpecs,
  //     'releaseDate': releaseDate,
  //     'imageUrl': imageUrl,
  //   };
  // }

  factory ProductModel.fromMap(Map<String, dynamic> map, String id) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      category: map['category'],
      diskCount: map['diskCount'],
      price: map['price'],
      stock: map['stock'],
      minSpecs: map['minSpecs'],
      recSpecs: map['recSpecs'],
      releaseDate: _fromTimestamp(map['releaseDate']),
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      rating: (map['rating'] ?? 0).toDouble(),
    );
  }

  static DateTime _fromTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    } else {
      return DateTime.now();
    }
  }

  @override
  String toString() {
    return 'ProductModel{id: $id, name: $name, description: $description, category: $category, diskCount: $diskCount, price: $price, stock: $stock, minSpecs: $minSpecs, recSpecs: $recSpecs, releaseDate: $releaseDate, imageUrl: $imageUrls}';
  }

  // CopyWith method
  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    int? diskCount,
    int? price,
    int? stock,
    String? minSpecs,
    String? recSpecs,
    DateTime? releaseDate,
    List<String>? imageUrl,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      diskCount: diskCount ?? this.diskCount,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      minSpecs: minSpecs ?? this.minSpecs,
      recSpecs: recSpecs ?? this.recSpecs,
      releaseDate: releaseDate ?? this.releaseDate,
      imageUrls: imageUrl ?? imageUrls,
      rating: rating,
    );
  }

  ProductModel toEntity() {
    return ProductModel(
      name: name,
      description: description,
      category: category,
      diskCount: diskCount,
      price: price,
      stock: stock,
      minSpecs: minSpecs,
      recSpecs: recSpecs,
      releaseDate: releaseDate,
      imageUrls: imageUrls,
      rating: rating,
    );
  }
}
