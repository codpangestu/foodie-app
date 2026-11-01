/*
 * ============================================================================
 * TUGAS: Anggota 2 & 4 - Membuat Model Keranjang Belanja
 * FASE: Fase 2 & 5 - Setup Database & Membuat UI Flutter
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Mendefinisikan model item keranjang belanja (`CartItem`) yang menyimpan informasi
 *    produk yang dipilih, jumlah kuantitas, catatan khusus, dan perhitungan subtotal.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Sebagai struktur data untuk mengelola pesanan sebelum pengguna melakukan checkout.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Model data yang digunakan pada fitur Cart dan Presentation Layer.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi CartItem dengan serialization di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Buat `CartItem` dan panggil `item.subtotal` untuk memastikan perkalian harga * qty benar.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Subtotal yang akurat dan kemampuan salin nilai (`copyWith`).
 * ============================================================================
 */

import 'package:equatable/equatable.dart';
import '../../products/domain/entities/product_entity.dart';

class CartItem extends Equatable {
  final String id;
  final String productId;
  final String productName;
  final int price;
  final String imageUrl;
  final int quantity;
  final String note;

  const CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
    this.note = '',
  });

  int get subtotal => price * quantity;

  CartItem copyWith({
    String? id,
    String? productId,
    String? productName,
    int? price,
    String? imageUrl,
    int? quantity,
    String? note,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      note: note ?? this.note,
    );
  }

  factory CartItem.fromProduct(ProductEntity product, {int quantity = 1, String note = ''}) {
    return CartItem(
      id: 'cart-${product.id}-${DateTime.now().millisecondsSinceEpoch}',
      productId: product.id,
      productName: product.name,
      price: product.price,
      imageUrl: product.imageUrl,
      quantity: quantity,
      note: note,
    );
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id']?.toString() ?? '',
      productId: json['productId']?.toString() ?? '',
      productName: json['productName'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      imageUrl: json['imageUrl'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      note: json['note'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'note': note,
    };
  }

  @override
  List<Object?> get props => [id, productId, productName, price, imageUrl, quantity, note];
}
