/*
 * ============================================================================
 * TUGAS: Anggota 4 - Membuat Repository Implementation
 * FASE: Fase 4 - Menerapkan Clean Architecture
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Mengimplementasikan antarmuka kontrak `ProductRepository` dari Domain Layer
 *    dengan memanfaatkan `ProductRemoteDataSource` untuk mengambil dan memanipulasi
 *    data produk di REST API.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Sebagai jembatan konkret antara Domain Layer dan Data Layer. Jika suatu saat
 *    kita ingin menambahkan caching lokal (LocalDataSource / SQLite), penggabungan
 *    alur data dilakukan di dalam file implementasi ini tanpa mengubah kontrak Domain.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Data / Repositories`. File ini mengimplementasikan interface
 *    yang didefinisikan di `domain/repositories/product_repository.dart`.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi ProductRepositoryImpl di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Diinstansiasi dengan menyuntikkan `ProductRemoteDataSource` lalu dioper ke Use Case.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Mengembalikan data berupa entitas murni `ProductEntity` ke use case.
 * ============================================================================
 */

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ProductEntity>> getProducts({String? categoryId, String? query}) async {
    try {
      final models = await remoteDataSource.getProducts(
        categoryId: categoryId,
        query: query,
      );
      return models;
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } on ServerException catch (e) {
      throw ServerFailure(e.message, statusCode: e.statusCode);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<ProductEntity> getProductById(String id) async {
    try {
      final model = await remoteDataSource.getProductById(id);
      return model;
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } on ServerException catch (e) {
      throw ServerFailure(e.message, statusCode: e.statusCode);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<ProductEntity> createProduct(ProductEntity product) async {
    try {
      final model = ProductModel.fromEntity(product);
      final createdModel = await remoteDataSource.createProduct(model);
      return createdModel;
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } on ServerException catch (e) {
      throw ServerFailure(e.message, statusCode: e.statusCode);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<ProductEntity> updateProduct(ProductEntity product) async {
    try {
      final model = ProductModel.fromEntity(product);
      final updatedModel = await remoteDataSource.updateProduct(model);
      return updatedModel;
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } on ServerException catch (e) {
      throw ServerFailure(e.message, statusCode: e.statusCode);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      await remoteDataSource.deleteProduct(id);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } on ServerException catch (e) {
      throw ServerFailure(e.message, statusCode: e.statusCode);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
