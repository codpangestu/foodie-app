/*
 * ============================================================================
 * TUGAS: Anggota 3 - Membuat Alur CRUD Produk & Konfirmasi Penghapusan
 * FASE: Fase 6 - Integrasi dan CRUD
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Halaman manajemen admin (`AdminProductListPage`) untuk mengelola seluruh data
 *    produk makanan (Read, Tambah, Edit, dan Hapus) secara langsung ke backend REST API.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Memenuhi kebutuhan evaluasi "Halaman Admin untuk mengelola produk secara lengkap
 *    (Create, Read, Update, Delete) dengan dialog konfirmasi sebelum penghapusan".
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Presentation / Pages`. Berinteraksi dengan `ProductProvider`
 *    yang menghubungkan aksi CRUD ke Use Cases di Domain Layer.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi AdminProductListPage di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Ketuk tab "Admin" pada Bottom Navigation.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Daftar produk dengan tombol aksi Edit dan Delete, dialog konfirmasi modal,
 *    serta FloatingActionButton untuk menambah produk baru.
 * ============================================================================
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../domain/entities/product_entity.dart';
import '../providers/product_provider.dart';
import '../widgets/custom_image_view.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/error_state_widget.dart';
import '../widgets/loading_widget.dart';

class AdminProductListPage extends StatelessWidget {
  const AdminProductListPage({super.key});

  void _showDeleteDialog(BuildContext context, ProductEntity product) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: const [
            Icon(Icons.warning_amber_rounded, color: AppTheme.errorColor, size: 28),
            SizedBox(width: 8),
            Text('Konfirmasi Hapus'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Apakah kamu yakin ingin menghapus produk:'),
            const SizedBox(height: 8),
            Text(
              '"${product.name}"',
              style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tindakan ini akan menghapus data dari backend REST API dan tidak dapat dibatalkan.',
              style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal', style: TextStyle(color: AppTheme.textSecondary)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.errorColor),
            onPressed: () async {
              Navigator.pop(ctx);
              final provider = context.read<ProductProvider>();
              final success = await provider.removeProduct(product.id);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? 'Produk "${product.name}" berhasil dihapus!'
                          : 'Gagal menghapus produk: ${provider.errorMessage}',
                    ),
                    backgroundColor: success ? AppTheme.successColor : AppTheme.errorColor,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: const Text('Hapus Sekarang'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Produk (Admin CRUD)'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Tambah Produk', style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () {
          context.push('/admin/product-form');
        },
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) {
          if (provider.state == ProductState.loading && provider.products.isEmpty) {
            return const AppLoadingWidget(message: 'Memuat data produk...');
          }

          if (provider.state == ProductState.error && provider.products.isEmpty) {
            return ErrorStateWidget(
              message: provider.errorMessage,
              onRetry: () => provider.fetchProducts(),
            );
          }

          if (provider.products.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.inventory_2_outlined,
              title: 'Belum Ada Produk Tersedia',
              description: 'Kamu belum menambahkan produk makanan apa pun ke database.',
              buttonText: 'Tambah Produk Sekarang',
              onButtonPressed: () => context.push('/admin/product-form'),
            );
          }

          return RefreshIndicator(
            color: AppTheme.primaryColor,
            onRefresh: () => provider.fetchProducts(),
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
              itemCount: provider.products.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final product = provider.products[index];
                return _buildAdminProductCard(context, product);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildAdminProductCard(BuildContext context, ProductEntity product) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
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
            imageUrl: product.imageUrl,
            width: 70,
            height: 70,
            borderRadius: BorderRadius.circular(12),
          ),
          const SizedBox(width: 14),

          // Detail Teks
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryLight,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        product.categoryName,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Stok: ${product.stock}',
                      style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  product.name,
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
                  CurrencyFormatter.formatRupiah(product.price),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),

          // Tombol Aksi: Edit & Delete
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, color: AppTheme.primaryColor),
                tooltip: 'Edit Produk',
                onPressed: () {
                  context.push('/admin/product-form', extra: product);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, color: AppTheme.errorColor),
                tooltip: 'Hapus Produk',
                onPressed: () => _showDeleteDialog(context, product),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
