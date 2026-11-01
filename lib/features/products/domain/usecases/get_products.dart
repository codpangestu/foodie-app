/*
 * ============================================================================
 * TUGAS: Anggota 4 - Membuat Use Case
 * FASE: Fase 4 - Menerapkan Clean Architecture
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Use case untuk mengeksekusi proses bisnis pengambilan daftar produk (Read),
 *    dapat menerima parameter filter kategori maupun kata kunci pencarian.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Mengisolasi aksi bisnis spesifik ke dalam satu class terpisah sehingga mudah
 *    diuji (unit test), dipelihara, dan dapat dipanggil ulang dari berbagai layar.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Domain / Use Cases`. Menjadi jembatan yang menghubungkan
 *    Presentation Layer (Provider) dengan Repository Contract.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi class GetProducts dan GetProductsParams di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Panggil use case: `await getProducts(GetProductsParams(categoryId: 'cat-1'))`.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Mengembalikan `List<ProductEntity>` yang sesuai dengan filter.
 * ============================================================================
 */

import 'package:equatable/equatable.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProducts implements UseCase<List<ProductEntity>, GetProductsParams> {
  final ProductRepository repository;

  GetProducts(this.repository);

  @override
  Future<List<ProductEntity>> call(GetProductsParams params) async {
    return await repository.getProducts(
      categoryId: params.categoryId,
      query: params.query,
    );
  }
}

class GetProductsParams extends Equatable {
  final String? categoryId;
  final String? query;

  const GetProductsParams({this.categoryId, this.query});

  @override
  List<Object?> get props => [categoryId, query];
}
