/*
 * ============================================================================
 * TUGAS: Anggota 4 - Membuat Entity
 * FASE: Fase 4 - Menerapkan Clean Architecture
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Mendefinisikan entitas bisnis murni `ProductEntity` yang merepresentasikan
 *    objek produk makanan/minuman pada aplikasi Foodie.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Entitas adalah inti (core) dari domain bisnis. Entitas ini tidak bergantung
 *    pada framework eksternal, library JSON, atau database, sehingga aturan
 *    bisnis tetap stabil meskipun backend atau database diubah.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Domain / Entities` (lapisan terdalam Clean Architecture).
 *    Layer Data (Model) akan meng-extend atau mengonversi data ke Entity ini.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi class ProductEntity dengan Equatable di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Buat instansiasi ProductEntity di unit test atau use case untuk memverifikasi
 *    nilai propertinya.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Objek produk yang immutable dengan properti id, nama, deskripsi, harga, kategori,
 *    gambar, rating, dan stok.
 * ============================================================================
 */

import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final int price;
  final String categoryId;
  final String categoryName;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final int stock;
  final bool isAvailable;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.categoryName,
    required this.imageUrl,
    this.rating = 4.5,
    this.reviewCount = 0,
    this.stock = 10,
    this.isAvailable = true,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        categoryId,
        categoryName,
        imageUrl,
        rating,
        reviewCount,
        stock,
        isAvailable,
      ];
}
