/*
 * ============================================================================
 * TUGAS: Anggota 2 - Membuat Widget yang Bisa Digunakan Ulang
 * FASE: Fase 5 - Membuat UI Flutter (Komponen Render Gambar Fleksibel)
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Widget serbaguna (`CustomImageView`) yang otomatis mendeteksi sumber gambar:
 *    - Jika berupa file lokal (diawali `assets/images/...`), dimuat menggunakan `Image.asset`.
 *    - Jika berupa URL internet (diawali `http://` atau `https://`), dimuat menggunakan `CachedNetworkImage`.
 *    - Jika kosong atau gagal dimuat, menampilkan fallback ikon makanan yang estetik.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Memudahkan penggantian gambar menu dengan file aset lokal tanpa perlu mengubah
 *    kode widget di banyak tempat. Cukup letakkan file di folder `assets/images/`
 *    dan ubah path-nya di `backend/db.json`.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Presentation / Widgets`.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi CustomImageView di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Panggil `CustomImageView(imageUrl: product.imageUrl)`.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Gambar lokal atau online tampil proporsional dengan penanganan error yang aman.
 * ============================================================================
 */

import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class CustomImageView extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const CustomImageView({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (imageUrl.startsWith('data:image')) {
      // 1. Gambar Hasil Upload (Base64)
      try {
        final commaIndex = imageUrl.indexOf(',');
        final base64String = commaIndex != -1 ? imageUrl.substring(commaIndex + 1) : imageUrl;
        final bytes = base64Decode(base64String.trim());
        imageWidget = Image.memory(
          bytes,
          fit: fit,
          width: width,
          height: height,
          errorBuilder: (context, error, stackTrace) => _buildFallback(),
        );
      } catch (_) {
        imageWidget = _buildFallback();
      }
    } else if (imageUrl.startsWith('assets/')) {
      // 2. Gambar dari Aset Lokal
      imageWidget = Image.asset(
        imageUrl,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) => _buildFallback(),
      );
    } else if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      // 3. Gambar dari Jaringan Internet (URL)
      imageWidget = Image.network(
        imageUrl,
        fit: fit,
        width: width,
        height: height,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: width,
            height: height,
            color: AppTheme.backgroundColor,
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.primaryColor),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => _buildFallback(),
      );
    } else {
      // 3. Path tidak valid / kosong
      imageWidget = _buildFallback();
    }

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  Widget _buildFallback() {
    return Container(
      width: width,
      height: height,
      color: AppTheme.primaryLight,
      child: const Center(
        child: Icon(
          Icons.fastfood_rounded,
          color: AppTheme.primaryColor,
          size: 36,
        ),
      ),
    );
  }
}
