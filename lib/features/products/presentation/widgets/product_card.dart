/*
 * ============================================================================
 * TUGAS: Anggota 2 - Membuat Widget yang Bisa Digunakan Ulang
 * FASE: Fase 5 - Membuat UI Flutter (Kartu Produk Makanan)
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Widget kartu produk (`ProductCard`) yang menampilkan visual makanan lezat,
 *    nama, kategori, rating bintang, harga Rupiah, dan tombol cepat tambah ke keranjang.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Sebagai komponen utama di grid menu Home Foodie yang menarik secara visual
 *    dan konsisten di seluruh layar.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Presentation / Widgets`. Mengonsumsi objek `ProductEntity`
 *    dari Domain Layer dan memanggil callback aksi navigasi/keranjang.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi ProductCard di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Dipakai di dalam GridView pada HomePage.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Kartu modern dengan gambar melengkung, bayangan halus, dan tombol tambah cepat.
 * ============================================================================
 */

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../domain/entities/product_entity.dart';
import 'custom_image_view.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk & Rating Badge
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Stack(
                  children: [
                    CustomImageView(
                      imageUrl: product.imageUrl,
                      borderRadius: BorderRadius.circular(16),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    // Rating Badge (kiri atas)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_rounded, size: 14, color: AppTheme.starColor),
                            const SizedBox(width: 3),
                            Text(
                              product.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                color: AppTheme.textPrimary,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Informasi Produk
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 2, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            product.categoryName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryDark,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            CurrencyFormatter.formatRupiah(product.price),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                        // Quick Add Button (bulat)
                        InkWell(
                          onTap: onAddToCart,
                          customBorder: const CircleBorder(),
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: const BoxDecoration(
                              color: AppTheme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}