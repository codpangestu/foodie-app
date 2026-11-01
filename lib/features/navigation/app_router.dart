/*
 * ============================================================================
 * TUGAS: Anggota 2 - Membuat Navigasi Aplikasi dengan GoRouter
 * FASE: Fase 5 - Membuat UI Flutter
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Mengonfigurasi declarative routing berbasis `go_router` untuk navigasi antar
 *    layar (Home, Cart, Orders, Admin, Detail Produk, dan Form Produk).
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Menyediakan sistem routing terstruktur, mendukung deep linking, navigasi
 *    tab berulang (StatefulShellRoute), dan pengiriman parameter/objek antar layar.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Presentation / Navigation`. Menghubungkan seluruh halaman
 *    dalam satu konfigurasi routing pusat.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi AppRouter di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Digunakan pada `MaterialApp.router` di `lib/main.dart`.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Navigasi antar halaman berjalan lancar tanpa kehilangan state tab.
 * ============================================================================
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../cart/presentation/pages/cart_page.dart';
import '../orders/presentation/pages/orders_page.dart';
import '../products/domain/entities/product_entity.dart';
import '../products/presentation/pages/admin_product_form_page.dart';
import '../products/presentation/pages/admin_product_list_page.dart';
import '../products/presentation/pages/home_page.dart';
import '../products/presentation/pages/product_detail_page.dart';
import 'main_navigation_scaffold.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _cartNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _ordersNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _adminNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      // Stateful Nested Navigation dengan Bottom Navigation Bar
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainNavigationScaffold(navigationShell: navigationShell);
        },
        branches: [
          // Branch 0: Home / Menu
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          // Branch 1: Keranjang (Cart)
          StatefulShellBranch(
            navigatorKey: _cartNavigatorKey,
            routes: [
              GoRoute(
                path: '/cart',
                builder: (context, state) => const CartPage(),
              ),
            ],
          ),
          // Branch 2: Pesanan (Orders)
          StatefulShellBranch(
            navigatorKey: _ordersNavigatorKey,
            routes: [
              GoRoute(
                path: '/orders',
                builder: (context, state) => const OrdersPage(),
              ),
            ],
          ),
          // Branch 3: Admin (CRUD Produk)
          StatefulShellBranch(
            navigatorKey: _adminNavigatorKey,
            routes: [
              GoRoute(
                path: '/admin',
                builder: (context, state) => const AdminProductListPage(),
              ),
            ],
          ),
        ],
      ),

      // Route Layar Penuh (Tanpa Bottom Nav)
      GoRoute(
        path: '/product-detail',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final product = state.extra as ProductEntity;
          return ProductDetailPage(product: product);
        },
      ),
      GoRoute(
        path: '/admin/product-form',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final product = state.extra as ProductEntity?;
          return AdminProductFormPage(product: product);
        },
      ),
    ],
  );
}
