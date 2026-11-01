/*
 * ============================================================================
 * TUGAS: Anggota 1 - Mengintegrasikan Hasil Setiap Anggota & Main Entrypoint
 * FASE: Fase 1 & 6 - Setup Project & Integrasi Lengkap
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Sebagai titik masuk utama (entry point) aplikasi Flutter `main.dart`.
 *    File ini menginisialisasi Dependency Injection seluruh layer Clean Architecture
 *    (Core, Data, Domain, Presentation), mendaftarkan Provider state management,
 *    dan menjalankan `MaterialApp.router` dengan tema visual Foodie.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Menggabungkan hasil kerja Anggota 1 (Setup & Integrasi), Anggota 2 (UI & Navigasi),
 *    Anggota 3 (CRUD & Form), dan Anggota 4 (Data, REST API & Use Cases) ke dalam
 *    satu aplikasi yang utuh dan siap dijalankan di Android.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Composition Root: Menghubungkan Network -> Datasources -> Repositories ->
 *    Use Cases -> Providers -> UI Widgets.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi method `main()` dan widget `FoodieApp` di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Pastikan JSON Server backend berjalan (`cd backend && npm run dev`),
 *    lalu jalankan aplikasi dengan perintah: `flutter run`.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Aplikasi Foodie terbuka dengan antarmuka modern, menampilkan daftar menu makanan,
 *    dan terhubung langsung ke backend REST API.
 * ============================================================================
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/network/api_client.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_constants.dart';
import 'features/cart/presentation/providers/cart_provider.dart';
import 'features/navigation/app_router.dart';
import 'features/orders/presentation/providers/order_provider.dart';
import 'features/products/data/datasources/product_remote_data_source.dart';
import 'features/products/data/repositories/product_repository_impl.dart';
import 'features/products/domain/usecases/create_product.dart';
import 'features/products/domain/usecases/delete_product.dart';
import 'features/products/domain/usecases/get_product_by_id.dart';
import 'features/products/domain/usecases/get_products.dart';
import 'features/products/domain/usecases/update_product.dart';
import 'features/products/presentation/providers/product_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Core Network Client
  final apiClient = ApiClient();

  // 2. Data Layer
  final productRemoteDataSource = ProductRemoteDataSourceImpl(apiClient: apiClient);
  final productRepository = ProductRepositoryImpl(remoteDataSource: productRemoteDataSource);

  // 3. Domain Layer (Use Cases)
  final getProductsUseCase = GetProducts(productRepository);
  final getProductByIdUseCase = GetProductById(productRepository);
  final createProductUseCase = CreateProduct(productRepository);
  final updateProductUseCase = UpdateProduct(productRepository);
  final deleteProductUseCase = DeleteProduct(productRepository);

  runApp(
    MultiProvider(
      providers: [
        // Provider Produk (CRUD)
        ChangeNotifierProvider<ProductProvider>(
          create: (_) => ProductProvider(
            getProductsUseCase: getProductsUseCase,
            getProductByIdUseCase: getProductByIdUseCase,
            createProductUseCase: createProductUseCase,
            updateProductUseCase: updateProductUseCase,
            deleteProductUseCase: deleteProductUseCase,
          ),
        ),
        // Provider Keranjang Belanja
        ChangeNotifierProvider<CartProvider>(
          create: (_) => CartProvider(),
        ),
        // Provider Pesanan & Transaksi
        ChangeNotifierProvider<OrderProvider>(
          create: (_) => OrderProvider(apiClient: apiClient),
        ),
      ],
      child: const FoodieApp(),
    ),
  );
}

class FoodieApp extends StatelessWidget {
  const FoodieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
