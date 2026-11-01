/*
 * ============================================================================
 * TUGAS: Anggota 1 & 4 - Setup Project, Konfigurasi & Menghubungkan API
 * FASE: Fase 1 & 3 - Setup Project & Membuat REST API
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Menyimpan konstanta global aplikasi seperti URL dasar (Base URL) API,
 *    daftar endpoint REST API, timeout koneksi, dan nama aplikasi.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Mencegah hardcoded URL dan string di banyak tempat. Jika alamat IP atau
 *    port server berubah, kita hanya perlu mengubah satu baris di file ini.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer Core (Cross-cutting concern) yang dapat diakses oleh
 *    Data Layer (Network / Datasource) maupun Presentation Layer jika diperlukan.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi konstanta di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Ubah `baseUrl` jika menjalankan di device fisik (misal IP laptop: http://192.168.1.5:3000)
 *    atau biarkan default `http://10.0.2.2:3000` untuk Android Emulator.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Koneksi HTTP mengarah tepat ke JSON Server port 3000.
 * ============================================================================
 */

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class AppConstants {
  static const String appName = 'Foodie';

  /// Mendapatkan Base URL sesuai platform yang menjalankan aplikasi:
  /// - Web / Windows / macOS / Linux: http://localhost:3000
  /// - Android Emulator: http://10.0.2.2:3000
  /// - Android Device Fisik: Masukkan IP Wi-Fi lokal komputer kamu di sini
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:3000';
    }
    try {
      if (Platform.isAndroid) {
        return 'http://10.0.2.2:3000';
      }
    } catch (_) {}
    return 'http://localhost:3000';
  }

  // Endpoints
  static const String productsEndpoint = '/products';
  static const String categoriesEndpoint = '/categories';
  static const String cartsEndpoint = '/carts';
  static const String ordersEndpoint = '/orders';
  static const String usersEndpoint = '/users';

  // Network Timeouts
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
}
