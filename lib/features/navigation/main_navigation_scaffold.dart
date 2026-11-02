/*
 * ============================================================================
 * TUGAS: Anggota 2 - Membuat Navigasi Aplikasi & Bottom Navigation
 * FASE: Fase 5 - Membuat UI Flutter
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Scaffold navigasi utama (`MainNavigationScaffold`) yang membungkus 4 layar utama:
 *    Home (Menu), Keranjang (Cart), Pesanan (Orders), dan Admin (CRUD), dengan
 *    Bottom Navigation Bar interaktif serta badge penghitung jumlah keranjang.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Memenuhi requirement "Navigasi: Bottom Navigation" agar pengguna dapat berpindah
 *    halaman dengan cepat dan mulus.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Presentation / Navigation`. Mengonsumsi `CartProvider`
 *    untuk menampilkan badge realtime di ikon keranjang.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi MainNavigationScaffold di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Jalankan aplikasi, ketuk setiap ikon di bar navigasi bawah untuk berpindah tab.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Transisi tab yang halus dan badge angka keranjang yang otomatis terupdate.
 * ============================================================================
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../cart/presentation/providers/cart_provider.dart';

class MainNavigationScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainNavigationScaffold({
    super.key,
    required this.navigationShell,
  });

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: Consumer<CartProvider>(
            builder: (context, cart, _) {
              final cartCount = cart.totalItemCount;

              return NavigationBarTheme(
                data: NavigationBarThemeData(
                  height: 68,
                  indicatorShape: const StadiumBorder(),
                  labelTextStyle: WidgetStateProperty.resolveWith((states) {
                    final selected = states.contains(WidgetState.selected);
                    return TextStyle(
                      fontSize: 12,
                      fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                      color: selected ? AppTheme.primaryColor : AppTheme.textSecondary,
                    );
                  }),
                  iconTheme: WidgetStateProperty.resolveWith((states) {
                    final selected = states.contains(WidgetState.selected);
                    return IconThemeData(
                      color: selected ? AppTheme.primaryColor : AppTheme.textSecondary,
                    );
                  }),
                ),
                child: NavigationBar(
                  selectedIndex: navigationShell.currentIndex,
                  onDestinationSelected: (index) => _onTap(context, index),
                  backgroundColor: Colors.white,
                  indicatorColor: AppTheme.primaryLight,
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  destinations: [
                    const NavigationDestination(
                      icon: Icon(Icons.restaurant_menu_outlined),
                      selectedIcon: Icon(Icons.restaurant_menu_rounded),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Badge(
                        isLabelVisible: cartCount > 0,
                        label: Text('$cartCount'),
                        backgroundColor: AppTheme.errorColor,
                        child: const Icon(Icons.shopping_bag_outlined),
                      ),
                      selectedIcon: Badge(
                        isLabelVisible: cartCount > 0,
                        label: Text('$cartCount'),
                        backgroundColor: AppTheme.errorColor,
                        child: const Icon(Icons.shopping_bag_rounded),
                      ),
                      label: 'Keranjang',
                    ),
                    const NavigationDestination(
                      icon: Icon(Icons.receipt_long_outlined),
                      selectedIcon: Icon(Icons.receipt_long_rounded),
                      label: 'Pesanan',
                    ),
                    const NavigationDestination(
                      icon: Icon(Icons.admin_panel_settings_outlined),
                      selectedIcon: Icon(Icons.admin_panel_settings_rounded),
                      label: 'Admin',
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}