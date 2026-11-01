/*
 * ============================================================================
 * TUGAS: Anggota 3 - Membuat Form Tambah & Edit Produk serta Validasi
 * FASE: Fase 6 - Integrasi dan CRUD
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Halaman formulir (`AdminProductFormPage`) untuk menambah produk baru (Create)
 *    maupun mengubah data produk yang sudah ada (Update) lengkap dengan sistem
 *    validasi input (nama, harga, kategori, stok, URL gambar, deskripsi).
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Memenuhi requirement "Create: Tambah produk, Update: Edit produk, Validasi:
 *    Form tambah dan edit" agar data yang dikirimkan ke JSON Server selalu valid.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Presentation / Pages`. Mengonversi data form menjadi
 *    `ProductEntity` dan meneruskannya ke `ProductProvider` (Use Cases).
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi AdminProductFormPage dengan FormState di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Akses dari tombol "Tambah Produk" atau ikon edit pada daftar produk admin.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Formulir yang memvalidasi kesalahan input secara real-time dan menyimpan data ke REST API.
 * ============================================================================
 */

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/product_entity.dart';
import '../providers/product_provider.dart';
import '../widgets/custom_image_view.dart';

class AdminProductFormPage extends StatefulWidget {
  final ProductEntity? product;

  const AdminProductFormPage({super.key, this.product});

  @override
  State<AdminProductFormPage> createState() => _AdminProductFormPageState();
}

class _AdminProductFormPageState extends State<AdminProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _stockController;
  late final TextEditingController _imageUrlController;
  late final TextEditingController _descriptionController;

  late String _selectedCategoryId;
  late String _selectedCategoryName;
  late bool _isAvailable;

  final Map<String, String> _categories = {
    'cat-1': 'Makanan Utama',
    'cat-2': 'Minuman',
    'cat-3': 'Camilan',
    'cat-4': 'Dessert',
  };

  bool get isEditMode => widget.product != null;

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    _nameController = TextEditingController(text: p?.name ?? '');
    _priceController = TextEditingController(text: p != null ? p.price.toString() : '');
    _stockController = TextEditingController(text: p != null ? p.stock.toString() : '20');
    _imageUrlController = TextEditingController(
      text: p?.imageUrl ??
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600&auto=format&fit=crop&q=80',
    );
    _descriptionController = TextEditingController(text: p?.description ?? '');

    _selectedCategoryId = p?.categoryId ?? 'cat-1';
    _selectedCategoryName = _categories[_selectedCategoryId] ?? 'Makanan Utama';
    _isAvailable = p?.isAvailable ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _imageUrlController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 75,
      );
      if (picked != null) {
        final bytes = await picked.readAsBytes();
        final base64String = 'data:image/jpeg;base64,${base64Encode(bytes)}';
        setState(() {
          _imageUrlController.text = base64String;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memilih gambar: $e'),
            backgroundColor: AppTheme.errorColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final provider = context.read<ProductProvider>();

    final productToSave = ProductEntity(
      id: isEditMode ? widget.product!.id : DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      price: int.parse(_priceController.text.trim()),
      categoryId: _selectedCategoryId,
      categoryName: _selectedCategoryName,
      imageUrl: _imageUrlController.text.trim(),
      rating: isEditMode ? widget.product!.rating : 4.8,
      reviewCount: isEditMode ? widget.product!.reviewCount : 1,
      stock: int.parse(_stockController.text.trim()),
      isAvailable: _isAvailable,
    );

    final bool success;
    if (isEditMode) {
      success = await provider.editProduct(productToSave);
    } else {
      success = await provider.addProduct(productToSave);
    }

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle_rounded, color: Colors.white),
                const SizedBox(width: 8),
                Text(isEditMode ? 'Produk berhasil diperbarui!' : 'Produk baru berhasil ditambahkan!'),
              ],
            ),
            backgroundColor: AppTheme.successColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
        context.pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menyimpan: ${provider.errorMessage}'),
            backgroundColor: AppTheme.errorColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit Produk' : 'Tambah Produk Baru'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Preview Gambar & Tombol Upload
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: AppTheme.backgroundColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppTheme.borderColor),
                          ),
                          child: ValueListenableBuilder<TextEditingValue>(
                            valueListenable: _imageUrlController,
                            builder: (context, value, _) {
                              final url = value.text.trim();
                              return CustomImageView(
                                imageUrl: url,
                                width: 140,
                                height: 140,
                                borderRadius: BorderRadius.circular(20),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () => _pickImage(ImageSource.gallery),
                              icon: const Icon(Icons.photo_library_rounded, size: 18),
                              label: const Text('Dari Galeri'),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton.icon(
                              onPressed: () => _pickImage(ImageSource.camera),
                              icon: const Icon(Icons.camera_alt_rounded, size: 18),
                              label: const Text('Kamera'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Input Nama Produk
                  const Text('Nama Produk *', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Contoh: Sate Ayam Madura',
                      prefixIcon: Icon(Icons.restaurant_rounded),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Nama produk wajib diisi.';
                      }
                      if (value.trim().length < 3) {
                        return 'Nama produk minimal 3 karakter.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Dropdown Kategori
                  const Text('Kategori *', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedCategoryId,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.category_rounded),
                    ),
                    items: _categories.entries.map((e) {
                      return DropdownMenuItem(
                        value: e.key,
                        child: Text(e.value),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedCategoryId = val;
                          _selectedCategoryName = _categories[val]!;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  // Baris: Harga & Stok
                  Row(
                    children: [
                      // Input Harga
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Harga (Rp) *', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _priceController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: '25000',
                                prefixIcon: Icon(Icons.payments_rounded),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Harga wajib diisi.';
                                }
                                final parsed = int.tryParse(value.trim());
                                if (parsed == null || parsed <= 0) {
                                  return 'Harga harus > 0.';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Input Stok
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Stok Porsi *', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _stockController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: '10',
                                prefixIcon: Icon(Icons.inventory_2_rounded),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Stok wajib diisi.';
                                }
                                final parsed = int.tryParse(value.trim());
                                if (parsed == null || parsed < 0) {
                                  return 'Stok tidak boleh minus.';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Input URL / Status Upload Gambar
                  const Text('Sumber Gambar (Upload Foto atau URL) *', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _imageUrlController,
                    builder: (context, value, _) {
                      final isUploaded = value.text.startsWith('data:image');
                      if (isUploaded) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryLight,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle_rounded, color: AppTheme.primaryColor, size: 22),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Text(
                                  'Foto berhasil dipilih dari perangkat!',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline_rounded, color: AppTheme.errorColor, size: 20),
                                tooltip: 'Hapus foto & ganti',
                                onPressed: () {
                                  _imageUrlController.clear();
                                },
                              ),
                            ],
                          ),
                        );
                      }
                      return TextFormField(
                        controller: _imageUrlController,
                        decoration: const InputDecoration(
                          hintText: 'https://... atau assets/images/...',
                          prefixIcon: Icon(Icons.image_rounded),
                        ),
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'Gambar wajib diisi (gunakan tombol upload atau isi link).';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // Input Deskripsi
                  const Text('Deskripsi Produk *', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Jelaskan rasa, bumbu, dan bahan utama makanan ini...',
                      alignLabelWithHint: true,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Deskripsi wajib diisi.';
                      }
                      if (value.trim().length < 8) {
                        return 'Deskripsi minimal 8 karakter.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Switch Status Ketersediaan
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Status Ketersediaan', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      _isAvailable ? 'Menu ini tersedia untuk dipesan' : 'Menu sedang habis/tidak aktif',
                      style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                    ),
                    value: _isAvailable,
                    activeThumbColor: AppTheme.primaryColor,
                    onChanged: (val) {
                      setState(() => _isAvailable = val);
                    },
                  ),
                  const SizedBox(height: 32),

                  // Tombol Simpan
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: provider.isActionLoading ? null : _handleSubmit,
                      child: provider.isActionLoading
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : Text(isEditMode ? 'Simpan Perubahan' : 'Tambah Produk ke Menu'),
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
