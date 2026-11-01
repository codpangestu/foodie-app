/*
 * ============================================================================
 * TUGAS: Anggota 2 & 3 - Mengatur Interaksi Keranjang & State Management
 * FASE: Fase 5 & 6 - Membuat UI & Integrasi CRUD
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Mengelola state keranjang belanja pengguna (tambah item, ubah jumlah pesanan,
 *    hapus item, hitung subtotal & total harga, dan membersihkan keranjang).
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Menyediakan state reaktif sehingga badge jumlah keranjang di navigasi dan halaman
 *    Cart selalu sinkron secara realtime saat pengguna menambah atau mengurangi makanan.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Presentation / Providers` untuk fitur Cart.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi CartProvider di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Panggil `context.read<CartProvider>().addToCart(product)` dari halaman detail produk.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Item masuk ke keranjang, total harga terhitung otomatis, dan badge keranjang bertambah.
 * ============================================================================
 */

import 'package:flutter/foundation.dart';
import '../../models/cart_item.dart';
import '../../../products/domain/entities/product_entity.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  List<CartItem> get cartItemList => _items.values.toList();

  int get totalItemCount {
    int total = 0;
    _items.forEach((_, item) {
      total += item.quantity;
    });
    return total;
  }

  int get totalAmount {
    int total = 0;
    _items.forEach((_, item) {
      total += item.subtotal;
    });
    return total;
  }

  bool get isEmpty => _items.isEmpty;

  /// Menambah produk ke keranjang
  void addToCart(ProductEntity product, {int quantity = 1, String note = ''}) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existing) => existing.copyWith(
          quantity: existing.quantity + quantity,
          note: note.isNotEmpty ? note : existing.note,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem.fromProduct(product, quantity: quantity, note: note),
      );
    }
    notifyListeners();
  }

  /// Memperbarui kuantitas item
  void updateQuantity(String productId, int quantity) {
    if (!_items.containsKey(productId)) return;

    if (quantity <= 0) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (existing) => existing.copyWith(quantity: quantity),
      );
    }
    notifyListeners();
  }

  /// Menghapus satu item dari keranjang
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  /// Mengosongkan keranjang (setelah checkout berhasil)
  void clear() {
    _items.clear();
    notifyListeners();
  }
}
