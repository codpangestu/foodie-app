/*
 * ============================================================================
 * TUGAS: Anggota 2 - Membuat Desain UI Foodie & Halaman Detail Produk
 * FASE: Fase 5 - Membuat UI Flutter
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Halaman detail produk (`ProductDetailPage`) yang menampilkan gambar resolusi tinggi,
 *    nama lengkap, kategori, rating ulasan, harga, deskripsi makanan, opsi input
 *    catatan pesanan (notes), pemilih jumlah kuantitas, serta tombol tambah ke keranjang.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Memberikan informasi mendalam kepada pengguna sebelum memutuskan memesan makanan.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Presentation / Pages`. Menerima `ProductEntity` sebagai argumen
 *    dan memicu penambahan item ke `CartProvider`.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi ProductDetailPage di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Ketuk salah satu kartu produk di halaman Home.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Halaman detail makanan dengan animasi transisi rapi, tombol pengatur kuantitas (+/-),
 *    dan feedback SnackBar saat dimasukkan ke keranjang.
 * ============================================================================
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../domain/entities/product_entity.dart';
import '../widgets/custom_image_view.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _increment() {
    if (_quantity < widget.product.stock) {
      setState(() => _quantity++);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Jumlah telah mencapai stok maksimum yang tersedia.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() => _quantity--);
    }
  }

  // Tombol bulat putih di atas foto (hanya tampilan)
  Widget _circleButton({required IconData icon, required Color color, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(icon, color: color),
          onPressed: onPressed,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = widget.product.price * _quantity;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Foto Makanan + panel melengkung
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            leading: _circleButton(
              icon: Icons.arrow_back_rounded,
              color: AppTheme.textPrimary,
              onPressed: () => context.pop(),
            ),
            actions: [
              _circleButton(
                icon: Icons.favorite_border_rounded,
                color: AppTheme.primaryColor,
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CustomImageView(
                    imageUrl: widget.product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  // Panel putih melengkung yang menimpa foto
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: -1,
                    child: Container(
                      height: 28,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Konten Informasi Produk
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kategori & Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.product.categoryName,
                          style: const TextStyle(
                            color: AppTheme.primaryDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_rounded, color: AppTheme.starColor, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              widget.product.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${widget.product.reviewCount})',
                              style: const TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Nama Produk
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Harga Satuan
                  Text(
                    CurrencyFormatter.formatRupiah(widget.product.price),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Kartu info stok
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.inventory_2_outlined,
                              size: 18, color: AppTheme.primaryColor),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Ketersediaan',
                              style: TextStyle(fontSize: 11, color: AppTheme.textSecondary),
                            ),
                            Text(
                              'Sisa stok: ${widget.product.stock} porsi',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Deskripsi
                  const Text(
                    'Deskripsi Menu',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Catatan Pesanan
                  const Text(
                    'Catatan Khusus (Opsional)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _noteController,
                    decoration: InputDecoration(
                      hintText: 'Contoh: Jangan terlalu pedas, kuah dipisah...',
                      prefixIcon: const Icon(Icons.edit_note_rounded, color: AppTheme.textSecondary),
                      filled: true,
                      fillColor: AppTheme.backgroundColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: AppTheme.primaryColor, width: 1.5),
                      ),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Bar berbentuk pil
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Pengatur Kuantitas
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppTheme.borderColor),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_rounded, size: 20),
                      onPressed: _decrement,
                    ),
                    Text(
                      '$_quantity',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_rounded, size: 20, color: AppTheme.primaryColor),
                      onPressed: _increment,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              // Tombol Tambah Keranjang
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: widget.product.stock > 0
    ? () {
        final cart = context.read<CartProvider>();
        final messenger = ScaffoldMessenger.of(context);
        final router = GoRouter.of(context);

        cart.addToCart(
          widget.product,
          quantity: _quantity,
          note: _noteController.text.trim(),
        );
        messenger.hideCurrentSnackBar();
        messenger.showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text('$_quantity x ${widget.product.name} dimasukkan ke keranjang'),
                ),
              ],
            ),
            backgroundColor: AppTheme.successColor,
            behavior: SnackBarBehavior.floating,
            persist: false,
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Lihat Keranjang',
              textColor: Colors.white,
              onPressed: () => router.go('/cart'),
            ),
          ),
        );
        router.pop();
      }
    : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tambah'),
                      Text(
                        CurrencyFormatter.formatRupiah(subtotal),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}