/*
 * ============================================================================
 * TUGAS: Anggota 4 - Membuat Datasource
 * FASE: Fase 4 - Menerapkan Clean Architecture
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Mengimplementasikan komunikasi langsung ke backend REST API (JSON Server)
 *    untuk mengambil, membuat, memperbarui, dan menghapus data produk (CRUD)
 *    menggunakan `ApiClient`.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Datasource bertindak sebagai pintu gerbang komunikasi eksternal (remote)
 *    yang mengonversi respon mentah dari API menjadi objek `ProductModel`.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Data / Datasources`. Layer ini hanya diketahui oleh
 *    Repository Implementation dan tidak boleh diakses langsung oleh Use Case atau UI.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Definisi abstract class ProductRemoteDataSource dan implementasinya di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Panggil `dataSource.getProducts()` ketika backend JSON Server sedang menyala.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Daftar `ProductModel` hasil parse dari endpoint `/products`.
 * ============================================================================
 */

import '../../../../core/network/api_client.dart';
import '../../../../core/utils/app_constants.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({String? categoryId, String? query});
  Future<ProductModel> getProductById(String id);
  Future<ProductModel> createProduct(ProductModel product);
  Future<ProductModel> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ProductModel>> getProducts({String? categoryId, String? query}) async {
    final Map<String, dynamic> queryParams = {};
    if (categoryId != null && categoryId.isNotEmpty) {
      queryParams['categoryId'] = categoryId;
    }
    if (query != null && query.trim().isNotEmpty) {
      queryParams['q'] = query.trim();
    }

    final response = await apiClient.get(
      AppConstants.productsEndpoint,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );

    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((item) => ProductModel.fromJson(item as Map<String, dynamic>)).toList();
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    final response = await apiClient.get('${AppConstants.productsEndpoint}/$id');
    return ProductModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<ProductModel> createProduct(ProductModel product) async {
    final response = await apiClient.post(
      AppConstants.productsEndpoint,
      data: product.toJson(),
    );
    return ProductModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    final response = await apiClient.put(
      '${AppConstants.productsEndpoint}/${product.id}',
      data: product.toJson(),
    );
    return ProductModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> deleteProduct(String id) async {
    await apiClient.delete('${AppConstants.productsEndpoint}/$id');
  }
}
