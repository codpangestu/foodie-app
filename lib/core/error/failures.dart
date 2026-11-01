/*
 * ============================================================================
 * TUGAS: Anggota 4 - Membuat Entity, Repository Contract & Penanganan Error
 * FASE: Fase 1 & 4 - Setup Project & Menerapkan Clean Architecture
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    File ini mendefinisikan kelas-kelas Failure (kegagalan) yang digunakan oleh
 *    Domain Layer dan Presentation Layer untuk merepresentasikan status error
 *    tanpa menggunakan mekanisme try-catch yang tersebar di UI.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Dengan membungkus error ke dalam objek Failure, kode menjadi lebih prediktif
 *    dan aman. Domain layer dan UI hanya perlu mengecek tipe Failure dan menampilkan
 *    pesan yang ramah kepada pengguna (user-friendly message).
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer Core / Domain. Digunakan sebagai nilai kembalian dari Repository
 *    dan Use Case ke Presentation Layer (Provider/Bloc/State).
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi Failure, ServerFailure, NetworkFailure, ValidationFailure di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Gunakan di Unit Test atau Use Case, bandingkan dua objek Failure dengan nilai
 *    message yang sama untuk memastikan kesamaan nilai (Equatable).
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Objek Failure menyediakan pesan kesalahan yang konsisten untuk ditampilkan
 *    di SnackBar atau pesan error halaman.
 * ============================================================================
 */

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(super.message, {this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Koneksi jaringan terputus. Silakan coba lagi.']);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Gagal memuat data lokal.']);
}
