/*
 * ============================================================================
 * TUGAS: Anggota 4 - Membuat Use Case
 * FASE: Fase 4 - Menerapkan Clean Architecture
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Use case untuk mengeksekusi proses bisnis penambahan produk baru (Create),
 *    biasanya dipicu dari Form Tambah Produk di panel Admin.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Memisahkan logika penambahan produk baru dari komponen UI form sehingga
 *    aturan validasi dan penyimpanan tersentralisasi dan dapat diuji.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Domain / Use Cases`.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi class CreateProduct di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Panggil `await createProduct(newProductEntity)`.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Mengembalikan `ProductEntity` yang berhasil dibuat dan tersimpan di backend.
 * ============================================================================
 */

import '../../../../core/usecases/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class CreateProduct implements UseCase<ProductEntity, ProductEntity> {
  final ProductRepository repository;

  CreateProduct(this.repository);

  @override
  Future<ProductEntity> call(ProductEntity product) async {
    return await repository.createProduct(product);
  }
}
