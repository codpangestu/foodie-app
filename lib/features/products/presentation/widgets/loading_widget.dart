/*
 * ============================================================================
 * TUGAS: Anggota 2 - Membuat Widget yang Bisa Digunakan Ulang
 * FASE: Fase 5 - Membuat UI Flutter (Indikator Pemuatan / Loading State)
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Menyediakan widget loading seragam dengan indikator berputar dan teks informasi
 *    saat data sedang dimuat dari backend REST API.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Memenuhi requirement UX "Loading: Indikator pemuatan" secara visual konsisten.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Presentation / Widgets`.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi AppLoadingWidget di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Tampilkan widget ini saat `provider.state == ProductState.loading`.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Spinner animasi oranye dengan pesan "Memuat menu lezat...".
 * ============================================================================
 */

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class AppLoadingWidget extends StatelessWidget {
  final String message;

  const AppLoadingWidget({
    super.key,
    this.message = 'Memuat menu lezat...',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: AppTheme.primaryColor,
            strokeWidth: 3,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
