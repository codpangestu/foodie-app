/*
 * ============================================================================
 * TUGAS: Anggota 2 - Membuat Desain UI Foodie & Tema Aplikasi
 * FASE: Fase 1 & 5 - Setup Project & Membuat UI Flutter
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Mendefinisikan sistem desain visual (ThemeData) aplikasi Foodie: palet warna
 *    makanan yang menggugah selera (vibrant warm orange), tipografi modern,
 *    gaya tombol, input form, card, dan navigasi.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Untuk menjaga konsistensi visual di seluruh layar aplikasi (Home, Detail, Cart,
 *    Orders, Admin) dan memberikan pengalaman pengguna (UX) yang menarik dan premium.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer Core / Presentation. Digunakan langsung oleh `MaterialApp` pada
 *    `main.dart` dan dijadikan referensi style oleh semua widget UI.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi class AppTheme di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Pasang `theme: AppTheme.lightTheme` pada `MaterialApp` di `main.dart`.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Aplikasi menampilkan tema warna oranye hangat modern dengan kartu dan tombol yang rapi.
 * ============================================================================
 */

import 'package:flutter/material.dart';

class AppTheme {
  // Palet Warna Utama Foodie
  static const Color primaryColor = Color(0xFF16A34A); // Warm Vibrant Coral Orange
  static const Color primaryDark = Color(0xFF16A34A);
  static const Color primaryLight = Color(0xFFDCFCE7);
  static const Color secondaryColor = Color(0xFFDCFCE7); // Warm Amber
  static const Color backgroundColor = Color(0xFFF8FAFC); // Clean Soft Slate
  static const Color surfaceColor = Colors.white;
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color successColor = Color(0xFF10B981);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color borderColor = Color(0xFFE2E8F0);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: errorColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceColor,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: textPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: errorColor),
        ),
        labelStyle: const TextStyle(color: textSecondary),
        hintStyle: const TextStyle(color: textSecondary),
      ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: borderColor, width: 0.8),
        ),
      ),
    );
  }
}
