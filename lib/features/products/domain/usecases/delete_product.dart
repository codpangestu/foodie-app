/*
 * ============================================================================
 * TUGAS: Anggota 4 - Membuat Use Case
 * FASE: Fase 4 - Menerapkan Clean Architecture
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Use case untuk menghapus produk dari backend berdasarkan ID (Delete).
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Membungkus operasi penghapusan produk sehingga alur konfirmasi dan
 *    eksekusi di UI dapat dihubungkan secara bersih dengan backend.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Domain / Use Cases`.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi class DeleteProduct di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Panggil `await deleteProduct('1')`.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Produk terhapus dari backend tanpa mengembalikan nilai (Future<void>).
 * ============================================================================
 */

import '../../../../core/usecases/usecase.dart';
import '../repositories/product_repository.dart';

class DeleteProduct implements UseCase<void, String> {
  final ProductRepository repository;

  DeleteProduct(this.repository);

  @override
  Future<void> call(String id) async {
    return await repository.deleteProduct(id);
  }
}
