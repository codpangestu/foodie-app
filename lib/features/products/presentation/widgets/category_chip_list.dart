/*
 * ============================================================================
 * TUGAS: Anggota 2 - Membuat Widget yang Bisa Digunakan Ulang
 * FASE: Fase 5 - Membuat UI Flutter (Kategori Menu)
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Menampilkan baris horizontal filter kategori makanan (Semua, Makanan Utama,
 *    Minuman, Camilan, Dessert) dengan indikator aktif yang menarik.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Memudahkan pengguna menyaring jenis makanan yang ingin dilihat di halaman Home.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Presentation / Widgets`. Memanggil method `setCategory`
 *    pada `ProductProvider`.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi CategoryChipList di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Ketuk salah satu chip kategori dan amati filter produk ter-refresh.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Chip yang dipilih berubah warna menjadi oranye tebal dan daftar produk berubah.
 * ============================================================================
 */

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class CategoryItem {
  final String? id;
  final String name;
  final IconData icon;

  const CategoryItem({
    required this.id,
    required this.name,
    required this.icon,
  });
}

class CategoryChipList extends StatelessWidget {
  final String? selectedCategoryId;
  final ValueChanged<String?> onSelectCategory;

  const CategoryChipList({
    super.key,
    required this.selectedCategoryId,
    required this.onSelectCategory,
  });

  static const List<CategoryItem> categories = [
    CategoryItem(id: null, name: 'Semua', icon: Icons.fastfood_rounded),
    CategoryItem(id: 'cat-1', name: 'Makanan Utama', icon: Icons.restaurant_rounded),
    CategoryItem(id: 'cat-2', name: 'Minuman', icon: Icons.local_drink_rounded),
    CategoryItem(id: 'cat-3', name: 'Camilan', icon: Icons.lunch_dining_rounded),
    CategoryItem(id: 'cat-4', name: 'Dessert', icon: Icons.icecream_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = selectedCategoryId == cat.id;

          return InkWell(
            onTap: () => onSelectCategory(cat.id),
            borderRadius: BorderRadius.circular(24),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected ? AppTheme.primaryColor : AppTheme.borderColor,
                  width: 1.2,
                ),
                boxShadow: isSelected
                    ? [
                        BoxWithShadow(
                          color: AppTheme.primaryColor.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    cat.icon,
                    size: 18,
                    color: isSelected ? Colors.white : AppTheme.textSecondary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    cat.name,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                      color: isSelected ? Colors.white : AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BoxWithShadow extends BoxShadow {
  const BoxWithShadow({
    super.color,
    super.offset,
    super.blurRadius,
  });
}
