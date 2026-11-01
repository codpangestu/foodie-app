/*
 * ============================================================================
 * TUGAS: Anggota 4 - Membuat Use Case
 * FASE: Fase 4 - Menerapkan Clean Architecture
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Use case untuk mengambil detail data produk berdasarkan ID uniknya.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Digunakan pada halaman Detail Produk untuk memastikan data yang ditampilkan
 *    selalu akurat dan terhubung dengan repository.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Domain / Use Cases`.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi class GetProductById di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Panggil `await getProductById('1')`.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Mengembalikan satu objek `ProductEntity`.
 * ============================================================================
 */

import '../../../../core/usecases/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductById implements UseCase<ProductEntity, String> {
  final ProductRepository repository;

  GetProductById(this.repository);

  @override
  Future<ProductEntity> call(String id) async {
    return await repository.getProductById(id);
  }
}
