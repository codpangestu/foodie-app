/*
 * ============================================================================
 * TUGAS: Anggota 2 - Membuat Widget dan Utilitas UI yang Bisa Digunakan Ulang
 * FASE: Fase 1 & 5 - Setup Project & Membuat UI Flutter
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Menyediakan fungsi utilitas untuk memformat angka nominal harga menjadi format
 *    Mata Uang Rupiah (Contoh: 28000 -> "Rp 28.000") dan format tanggal pesanan.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Untuk menjaga konsistensi tampilan harga di seluruh aplikasi Foodie (Home, Detail,
 *    Cart, Orders, dan Admin CRUD) menggunakan package `intl`.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer Core / Utils. Digunakan oleh Presentation Layer saat menampilkan
 *    data harga dari Entity/Model ke Widget tampilan pengguna.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi class CurrencyFormatter di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Panggil `CurrencyFormatter.formatRupiah(28000)` di widget Text.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    String berformat "Rp 28.000".
 * ============================================================================
 */

import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final NumberFormat _rupiahFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  static String formatRupiah(num amount) {
    return _rupiahFormat.format(amount);
  }

  static String formatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd MMM yyyy, HH:mm', 'id_ID');
    return formatter.format(dateTime);
  }
}
