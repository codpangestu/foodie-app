/*
 * ============================================================================
 * TUGAS: Anggota 4 - Membuat Use Case
 * FASE: Fase 4 - Menerapkan Clean Architecture
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Use case untuk memperbarui informasi produk yang sudah ada (Update),
 *    seperti nama, harga, stok, ketersediaan, atau deskripsi produk.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Menyediakan titik masuk terpusat untuk operasi edit produk tanpa
 *    bergantung langsung pada library HTTP atau UI form.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Domain / Use Cases`.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi class UpdateProduct di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Panggil `await updateProduct(updatedProductEntity)`.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Mengembalikan `ProductEntity` versi terbaru setelah diperbarui di backend.
 * ============================================================================
 */

import '../../../../core/usecases/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class UpdateProduct implements UseCase<ProductEntity, ProductEntity> {
  final ProductRepository repository;

  UpdateProduct(this.repository);

  @override
  Future<ProductEntity> call(ProductEntity product) async {
    return await repository.updateProduct(product);
  }
}
