/*
 * ============================================================================
 * TUGAS: Anggota 4 - Membuat Use Case & Arsitektur Domain
 * FASE: Fase 1 & 4 - Setup Project & Menerapkan Clean Architecture
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    File ini mendefinisikan interface generik `UseCase<Type, Params>` yang menjadi
 *    standar kontrak bagi seluruh Use Case (aturan bisnis) di dalam aplikasi.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Menjamin konsistensi antarmuka pemanggilan Use Case (callable class dengan method `call`),
 *    memudahkan pembuatan mock saat unit testing, dan memastikan setiap Use Case hanya
 *    memiliki satu tanggung jawab utama (Single Responsibility Principle).
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer Core / Domain. Seluruh Use Case konkret di folder domain/usecases/
 *    akan mengimplementasikan interface ini.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Definisi abstract class UseCase dan NoParams di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Diimplementasikan pada class UseCase spesifik (misal `GetProducts`), lalu dipanggil
 *    dengan `usecase(params)` atau `usecase.call(params)`.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Mengembalikan data bertipe `Type` dalam bentuk asynchronous `Future<Type>`.
 * ============================================================================
 */

import 'package:equatable/equatable.dart';

abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
