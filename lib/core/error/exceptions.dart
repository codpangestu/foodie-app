/*
 * ============================================================================
 * TUGAS: Anggota 4 - Menghubungkan Flutter dengan API & Penanganan Error
 * FASE: Fase 1 & 4 - Setup Project & Menerapkan Clean Architecture
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    File ini mendefinisikan kelas-kelas Exception kustom yang dilempar (thrown)
 *    oleh Data Layer ketika terjadi kegagalan pada operasi data (misal: HTTP error,
 *    koneksi terputus, atau data lokal tidak ditemukan).
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Kita membutuhkan exception yang terstruktur agar layer data dapat membedakan
 *    jenis kegagalan secara spesifik tanpa membocorkan detail implementasi teknis
 *    Dio/HTTP ke layer Domain.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer Core / Data. Remote Datasource melempar (throw) Exception ini,
 *    kemudian Repository Implementation menangkap (catch) Exception dan mengubahnya
 *    menjadi Failure sebelum dikirim ke Domain Layer (Use Case).
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi ServerException, NetworkException, dan CacheException di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Dapat diuji dengan memicu error pada Remote Datasource (misal mematikan JSON
 *    Server) dan memastikan catch block menangkap ServerException.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Exception membawa pesan error yang informatif dan statusCode yang dapat dibaca.
 * ============================================================================
 */

class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => 'ServerException: $message (code: $statusCode)';
}

class NetworkException implements Exception {
  final String message;

  const NetworkException({
    this.message = 'Tidak dapat terhubung ke server. Periksa koneksi internet Anda.',
  });

  @override
  String toString() => 'NetworkException: $message';
}

class CacheException implements Exception {
  final String message;

  const CacheException({
    this.message = 'Gagal memproses penyimpanan lokal.',
  });

  @override
  String toString() => 'CacheException: $message';
}
