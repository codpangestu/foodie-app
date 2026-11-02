/*
 * ============================================================================
 * TUGAS: Anggota 2 - Membuat Widget yang Bisa Digunakan Ulang
 * FASE: Fase 5 - Membuat UI Flutter (Pesan Ketika Request Gagal / Error State)
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Menampilkan visual error informatif dengan tombol "Coba Lagi" (Retry) ketika
 *    request ke REST API backend gagal (misal server mati atau koneksi putus).
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Memenuhi requirement UX "Error: Pesan ketika request gagal" dan memberikan
 *    cara bagi pengguna untuk mencoba kembali tanpa harus me-restart aplikasi.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Presentation / Widgets`. Menerima pesan kegagalan dari
 *    `Failure` yang diteruskan oleh `ProductProvider`.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi ErrorStateWidget di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Tampilkan saat `provider.state == ProductState.error`.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Ikon peringatan merah, pesan error, dan tombol retry.
 * ============================================================================
 */

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ErrorStateWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorStateWidget({
    super.key,
    required this.message,
    required this.onRetry,
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
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.errorColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.wifi_off_rounded,
                size: 40,
                color: AppTheme.errorColor,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ups, Terjadi Kendala!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 20),
              label: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
