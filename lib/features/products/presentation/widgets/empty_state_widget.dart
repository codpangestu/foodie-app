/*
 * ============================================================================
 * TUGAS: Anggota 2 - Membuat Widget yang Bisa Digunakan Ulang
 * FASE: Fase 5 - Membuat UI Flutter (Pesan Ketika Data Kosong / Empty State)
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Menampilkan tampilan ramah ketika data produk, hasil pencarian, keranjang,
 *    atau pesanan bernilai kosong (Empty state).
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Memenuhi requirement UX "Empty state: Pesan ketika data kosong" sehingga
 *    pengguna tidak melihat layar putih tanpa instruksi yang jelas.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Presentation / Widgets`.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi EmptyStateWidget di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Tampilkan saat list data bernilai kosong (`products.isEmpty`).
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Ikon ilustrasi, judul, deskripsi informatif, dan tombol aksi opsional.
 * ============================================================================
 */

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const EmptyStateWidget({
    super.key,
    this.icon = Icons.restaurant_menu_outlined,
    this.title = 'Belum Ada Menu',
    this.description = 'Makanan yang kamu cari tidak ditemukan atau belum ditambahkan.',
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppTheme.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 52,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
            ),
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onButtonPressed,
                child: Text(buttonText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
