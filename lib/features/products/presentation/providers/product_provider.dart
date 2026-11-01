/*
 * ============================================================================
 * TUGAS: Anggota 3 & 4 - Mengatur Alur CRUD Produk & State Management Provider
 * FASE: Fase 4 & 6 - Menerapkan Clean Architecture & Integrasi CRUD
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Sebagai State Management (ChangeNotifier) yang mengelola status data produk
 *    (Loading, Success, Empty, Error) dan menghubungkan interaksi UI dengan Use Cases.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Memisahkan state aplikasi dan logika presentasi dari Widget UI. Memungkinkan
 *    widget di berbagai halaman mendengarkan pembaruan data secara reaktif
 *    (Consumer / context.watch).
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Presentation / Providers`. Provider memanggil Use Cases
 *    (Domain Layer) dan mengubah hasilnya menjadi state yang siap ditampilkan oleh UI.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi ProductProvider dengan metode CRUD lengkap di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Didaftarkan di `MultiProvider` pada `main.dart`, lalu diakses dengan
 *    `context.read<ProductProvider>().fetchProducts()`.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    UI otomatis ter-rebuild saat data berubah, menampilkan indikator loading saat memuat,
 *    dan menampilkan pesan error saat gagal.
 * ============================================================================
 */

import 'package:flutter/foundation.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/create_product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_product_by_id.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/update_product.dart';

enum ProductState { initial, loading, loaded, error }

class ProductProvider extends ChangeNotifier {
  final GetProducts getProductsUseCase;
  final GetProductById getProductByIdUseCase;
  final CreateProduct createProductUseCase;
  final UpdateProduct updateProductUseCase;
  final DeleteProduct deleteProductUseCase;

  ProductProvider({
    required this.getProductsUseCase,
    required this.getProductByIdUseCase,
    required this.createProductUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
  });

  ProductState _state = ProductState.initial;
  ProductState get state => _state;

  List<ProductEntity> _products = [];
  List<ProductEntity> get products => _products;

  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _isActionLoading = false;
  bool get isActionLoading => _isActionLoading;

  /// Mengambil daftar produk dari API backend
  Future<void> fetchProducts({String? categoryId, String? query}) async {
    _state = ProductState.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      final params = GetProductsParams(
        categoryId: categoryId ?? _selectedCategory,
        query: query ?? _searchQuery,
      );
      _products = await getProductsUseCase(params);
      _state = ProductState.loaded;
    } on Failure catch (failure) {
      _errorMessage = failure.message;
      _state = ProductState.error;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ProductState.error;
    }
    notifyListeners();
  }

  /// Mengubah filter kategori aktif
  void setCategory(String? categoryId) {
    if (_selectedCategory == categoryId) {
      _selectedCategory = null; // batalkan filter jika diklik lagi
    } else {
      _selectedCategory = categoryId;
    }
    fetchProducts();
  }

  /// Melakukan pencarian produk berdasarkan nama
  void setSearchQuery(String query) {
    _searchQuery = query;
    fetchProducts();
  }

  /// Tambah Produk Baru (Create)
  Future<bool> addProduct(ProductEntity product) async {
    _isActionLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final newProduct = await createProductUseCase(product);
      _products.insert(0, newProduct);
      _isActionLoading = false;
      notifyListeners();
      return true;
    } on Failure catch (failure) {
      _errorMessage = failure.message;
      _isActionLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      _isActionLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Edit Produk (Update)
  Future<bool> editProduct(ProductEntity product) async {
    _isActionLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final updated = await updateProductUseCase(product);
      final index = _products.indexWhere((p) => p.id == updated.id);
      if (index != -1) {
        _products[index] = updated;
      }
      _isActionLoading = false;
      notifyListeners();
      return true;
    } on Failure catch (failure) {
      _errorMessage = failure.message;
      _isActionLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      _isActionLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Hapus Produk (Delete)
  Future<bool> removeProduct(String id) async {
    _isActionLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await deleteProductUseCase(id);
      _products.removeWhere((p) => p.id == id);
      _isActionLoading = false;
      notifyListeners();
      return true;
    } on Failure catch (failure) {
      _errorMessage = failure.message;
      _isActionLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      _isActionLoading = false;
      notifyListeners();
      return false;
    }
  }
}
