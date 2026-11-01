/*
 * ============================================================================
 * TUGAS: Anggota 4 - Membuat Repository Contract
 * FASE: Fase 4 - Menerapkan Clean Architecture
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Mendefinisikan antarmuka abstrak (abstract class / interface) kontrak
 *    repository untuk operasi CRUD produk tanpa menyertakan detail teknis
 *    bagaimana data diambil atau disimpan.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Prinsip Dependency Inversion (SOLID): Layer domain tingkat tinggi tidak boleh
 *    bergantung pada layer data tingkat rendah; keduanya harus bergantung pada abstraksi.
 *    Ini memungkinkan pertukaran sumber data (REST API, Firebase, SQLite) tanpa
 *    mengubah logika bisnis di domain layer.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Domain / Repositories`. Kontrak ini diimplementasikan oleh
 *    `ProductRepositoryImpl` di layer Data dan dipanggil oleh Use Cases.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Definisi abstract class ProductRepository dengan metode CRUD di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Digunakan sebagai tipe ketergantungan pada Use Case constructor (Dependency Injection).
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Menyediakan interface jelas untuk Get, Create, Update, dan Delete produk.
 * ============================================================================
 */

import '../entities/product_entity.dart';

abstract class ProductRepository {
  /// Mengambil daftar semua produk, dengan opsional filter kategori atau pencarian nama
  Future<List<ProductEntity>> getProducts({String? categoryId, String? query});

  /// Mengambil detail satu produk berdasarkan ID uniknya
  Future<ProductEntity> getProductById(String id);

  /// Menambah produk baru ke backend (Operasi Create)
  Future<ProductEntity> createProduct(ProductEntity product);

  /// Memperbarui informasi produk yang sudah ada (Operasi Update)
  Future<ProductEntity> updateProduct(ProductEntity product);

  /// Menghapus produk berdasarkan ID (Operasi Delete)
  Future<void> deleteProduct(String id);
}
