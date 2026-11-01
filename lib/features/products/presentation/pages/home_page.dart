/*
 * ============================================================================
 * TUGAS: Anggota 2 - Membuat Desain UI Foodie & Halaman Home / Menu
 * FASE: Fase 5 - Membuat UI Flutter
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Halaman utama (Dashboard / Home Menu) aplikasi Foodie yang menampilkan:
 *    salam pengguna, kolom pencarian makanan, filter kategori makanan, promo banner,
 *    dan grid daftar produk makanan lengkap dengan harga dan tombol aksi.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Sebagai etalase utama tempat pengguna mencari dan menjelajahi menu kuliner
 *    yang tersedia.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Presentation / Pages`. Mengambil data dari `ProductProvider`
 *    dan meneruskan interaksi ke `CartProvider`.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi HomePage di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Akses rute `/` atau ketuk tab "Home" pada Bottom Navigation.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Koleksi menu makanan dengan gambar menarik, filter kategori yang responsif,
 *    dan interaksi tambah ke keranjang dengan notifikasi SnackBar.
 * ============================================================================
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/category_chip_list.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/error_state_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchProducts();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          color: AppTheme.primaryColor,
          onRefresh: () async {
            await context.read<ProductProvider>().fetchProducts();
          },
          child: CustomScrollView(
            slivers: [
              // Header Aplikasi & Salam
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.location_on_rounded, size: 16, color: AppTheme.primaryColor),
                              SizedBox(width: 4),
                              Text(
                                'Jakarta Selatan, ID',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.textSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Mau Makan Apa Hari Ini?',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: AppTheme.primaryLight,
                        child: const Icon(
                          Icons.person_rounded,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Search Bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Cari nasi goreng, burger, minuman...',
                      prefixIcon: const Icon(Icons.search_rounded, color: AppTheme.primaryColor),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded, size: 20),
                              onPressed: () {
                                _searchController.clear();
                                context.read<ProductProvider>().setSearchQuery('');
                              },
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      context.read<ProductProvider>().setSearchQuery(value);
                    },
                  ),
                ),
              ),

              // Banner Promo Spesial
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF5E3A), Color(0xFFFF9068)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'PROMO SPESIAL',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Diskon 30% Semua Menu',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Gunakan kode: FOODIE30',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.lunch_dining_rounded,
                        size: 56,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),

              // Kategori Makanan
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 12),
                  child: Consumer<ProductProvider>(
                    builder: (context, provider, _) {
                      return CategoryChipList(
                        selectedCategoryId: provider.selectedCategory,
                        onSelectCategory: (categoryId) {
                          provider.setCategory(categoryId);
                        },
                      );
                    },
                  ),
                ),
              ),

              // Judul Bagian Menu
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Pilihan Menu Terbaik',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Consumer<ProductProvider>(
                        builder: (context, provider, _) {
                          return Text(
                            '${provider.products.length} menu',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppTheme.textSecondary,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Grid Produk / State Handling
              Consumer<ProductProvider>(
                builder: (context, provider, _) {
                  if (provider.state == ProductState.loading) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: AppLoadingWidget(),
                    );
                  }

                  if (provider.state == ProductState.error) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: ErrorStateWidget(
                        message: provider.errorMessage,
                        onRetry: () => provider.fetchProducts(),
                      ),
                    );
                  }

                  if (provider.products.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: EmptyStateWidget(
                        icon: Icons.search_off_rounded,
                        title: 'Menu Tidak Ditemukan',
                        description: 'Coba ganti kata kunci atau pilih kategori makanan yang lain.',
                        buttonText: 'Reset Filter',
                        onButtonPressed: () {
                          _searchController.clear();
                          provider.setSearchQuery('');
                          provider.setCategory(null);
                        },
                      ),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.72,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final product = provider.products[index];
                          return ProductCard(
                            product: product,
                            onTap: () {
                              context.push('/product-detail', extra: product);
                            },
                            onAddToCart: () {
                              context.read<CartProvider>().addToCart(product);
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text('${product.name} dimasukkan ke keranjang'),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: AppTheme.successColor,
                                  duration: const Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        childCount: provider.products.length,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
