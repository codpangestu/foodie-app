/*
 * ============================================================================
 * TUGAS: Anggota 4 - Membuat Model
 * FASE: Fase 4 - Menerapkan Clean Architecture
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Mendefinisikan class `ProductModel` yang meng-extend `ProductEntity` dan
 *    menyediakan fungsionalitas serialisasi JSON (`fromJson`) serta deserialisasi (`toJson`).
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Untuk memisahkan representasi data dari API/Database dengan entitas domain.
 *    Jika struktur JSON di backend berubah, kita hanya perlu mengubah logika konversi
 *    di Model ini tanpa mengganggu Entity di Domain Layer.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Data / Models`. Model menjadi jembatan antara respons mentah
 *    JSON dari Datasource dengan Entity yang dimengerti oleh Domain dan Presentation.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi ProductModel, fromJson, toJson, dan fromEntity di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Gunakan `ProductModel.fromJson(map)` untuk mengubah respon JSON menjadi objek model.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Objek ProductModel yang mewarisi seluruh properti dari ProductEntity.
 * ============================================================================
 */

import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.categoryId,
    required super.categoryName,
    required super.imageUrl,
    super.rating = 4.5,
    super.reviewCount = 0,
    super.stock = 10,
    super.isAvailable = true,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      categoryId: json['categoryId'] as String? ?? '',
      categoryName: json['categoryName'] as String? ?? 'Umum',
      imageUrl: json['imageUrl'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 4.5,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      stock: (json['stock'] as num?)?.toInt() ?? 10,
      isAvailable: json['isAvailable'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'imageUrl': imageUrl,
      'rating': rating,
      'reviewCount': reviewCount,
      'stock': stock,
      'isAvailable': isAvailable,
    };
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      categoryId: entity.categoryId,
      categoryName: entity.categoryName,
      imageUrl: entity.imageUrl,
      rating: entity.rating,
      reviewCount: entity.reviewCount,
      stock: entity.stock,
      isAvailable: entity.isAvailable,
    );
  }
}
