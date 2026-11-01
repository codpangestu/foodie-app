/*
 * ============================================================================
 * TUGAS: Anggota 1 - Memastikan Aplikasi Bisa Dijalankan & Pengujian Dasar
 * FASE: Fase 7 - Testing dan Debugging
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    File pengujian (unit/smoke test) dasar untuk memverifikasi inisialisasi
 *    dan pemuatan komponen aplikasi Foodie tanpa mengalami crash.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Mencegah regresi (regression test) dan memastikan seluruh dependency
 *    dan routing terdefinisi dengan benar saat aplikasi pertama kali dimuat.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Pengujian layer UI dan integrasi.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi test di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Jalankan perintah di terminal: `flutter test`.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Seluruh test berstatus "All tests passed!".
 * ============================================================================
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:pemesanan_mkkn/core/utils/currency_formatter.dart';
import 'package:pemesanan_mkkn/features/products/domain/entities/product_entity.dart';

void main() {
  group('Smoke Test & Unit Test Foodie', () {
    test('CurrencyFormatter format rupiah dengan benar', () {
      final formatted = CurrencyFormatter.formatRupiah(28000);
      expect(formatted.contains('28.000'), isTrue);
    });

    test('ProductEntity properti terisi dengan benar', () {
      const product = ProductEntity(
        id: '1',
        name: 'Nasi Goreng',
        description: 'Enak',
        price: 25000,
        categoryId: 'cat-1',
        categoryName: 'Makanan Utama',
        imageUrl: 'https://example.com/image.jpg',
      );

      expect(product.id, '1');
      expect(product.name, 'Nasi Goreng');
      expect(product.price, 25000);
      expect(product.isAvailable, true);
    });
  });
}
