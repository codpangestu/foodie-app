/*
 * ============================================================================
 * TUGAS: Anggota 2 & 3 - Membuat Halaman Keranjang & Interaksi Pesanan
 * FASE: Fase 5 & 6 - Membuat UI Flutter & Integrasi CRUD
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Halaman keranjang belanja (`CartPage`) yang menampilkan daftar makanan yang dipilih,
 *    mengatur penambahan/pengurangan porsi, menghapus item, menghitung total harga,
 *    dan memproses checkout pesanan ke backend REST API.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Memenuhi fitur utama "Keranjang: Mengatur jumlah makanan, menghapus item,
 *    dan menghitung total harga" serta jembatan transaksi checkout.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Presentation / Pages`. Mengombinasikan `CartProvider`
 *    dan `OrderProvider` untuk alur transaksi.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi CartPage di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Ketuk tab "Keranjang" pada navigasi bawah atau tombol keranjang.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Daftar item belanja dengan kalkulasi harga realtime, konfirmasi hapus,
 *    dan alur checkout yang menyimpan pesanan ke endpoint `/orders`.
 * ============================================================================
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../orders/presentation/providers/order_provider.dart';
import '../../../products/presentation/widgets/custom_image_view.dart';
import '../../../products/presentation/widgets/empty_state_widget.dart';
import '../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void _showDeleteConfirmation(BuildContext context, String productId, String productName) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Hapus Item?'),
        content: Text('Apakah kamu yakin ingin menghapus "$productName" dari keranjang belanja?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal', style: TextStyle(color: AppTheme.textSecondary)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.errorColor),
            onPressed: () {
              context.read<CartProvider>().removeItem(productId);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('"$productName" dihapus dari keranjang.'),
                  backgroundColor: AppTheme.textPrimary,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void _handleCheckout(BuildContext context) async {
    final cartProvider = context.read<CartProvider>();
    final orderProvider = context.read<OrderProvider>();

    if (cartProvider.isEmpty) return;

    final createdOrder = await orderProvider.checkout(
      cartItems: cartProvider.cartItemList,
      totalAmount: cartProvider.totalAmount,
    );

    if (createdOrder != null && context.mounted) {
      cartProvider.clear();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppTheme.successColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded, color: AppTheme.successColor, size: 48),
              ),
              const SizedBox(height: 18),
              const Text(
                'Pesanan Berhasil Dibuat!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
              ),
              const SizedBox(height: 8),
              Text(
                'Nomor Pesanan: ${createdOrder.id}\nPesananmu sedang diproses oleh restoran.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary, height: 1.4),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    context.go('/orders');
                  },
                  child: const Text('Lihat Daftar Pesanan'),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(orderProvider.errorMessage),
          backgroundColor: AppTheme.errorColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, _) {
              if (cart.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(Icons.delete_sweep_rounded, color: AppTheme.errorColor),
                tooltip: 'Kosongkan Keranjang',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      title: const Text('Kosongkan Keranjang?'),
                      content: const Text('Semua menu yang ada di keranjang akan dihapus.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Batal'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.errorColor),
                          onPressed: () {
                            cart.clear();
                            Navigator.pop(ctx);
                          },
                          child: const Text('Kosongkan'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, _) {
          if (cart.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.remove_shopping_cart_outlined,
              title: 'Keranjang Kamu Masih Kosong',
              description: 'Perut kenyang hati senang. Yuk cari makanan atau minuman favoritmu sekarang!',
              buttonText: 'Mulai Pesan Menu',
              onButtonPressed: () => context.go('/'),
            );
          }

          final items = cart.cartItemList;

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.borderColor),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Gambar Thumbnail
                          CustomImageView(
                            imageUrl: item.imageUrl,
                            width: 72,
                            height: 72,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          const SizedBox(width: 14),

                          // Detail Teks
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.productName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  CurrencyFormatter.formatRupiah(item.price),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (item.note.isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    'Catatan: ${item.note}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontStyle: FontStyle.italic,
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),

                          // Tombol Kuantitas & Hapus
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.delete_outline_rounded, size: 20, color: AppTheme.errorColor),
                                onPressed: () => _showDeleteConfirmation(context, item.productId, item.productName),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.backgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppTheme.borderColor),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (item.quantity > 1) {
                                          cart.updateQuantity(item.productId, item.quantity - 1);
                                        } else {
                                          _showDeleteConfirmation(context, item.productId, item.productName);
                                        }
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        child: Icon(Icons.remove, size: 16),
                                      ),
                                    ),
                                    Text(
                                      '${item.quantity}',
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                    ),
                                    InkWell(
                                      onTap: () => cart.updateQuantity(item.productId, item.quantity + 1),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        child: Icon(Icons.add, size: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Rincian Pembayaran & Tombol Checkout
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 16,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Pembayaran',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          Text(
                            CurrencyFormatter.formatRupiah(cart.totalAmount),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: Consumer<OrderProvider>(
                          builder: (context, orderProv, _) {
                            return ElevatedButton(
                              onPressed: orderProv.isLoading ? null : () => _handleCheckout(context),
                              child: orderProv.isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                    )
                                  : const Text('Checkout Pesanan Sekarang'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
