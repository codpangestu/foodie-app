/*
 * ============================================================================
 * TUGAS: Anggota 2 & 4 - Membuat Model Riwayat Transaksi Pesanan
 * FASE: Fase 2 & 5 - Setup Database & Membuat UI Flutter
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Mendefinisikan model `OrderModel` yang menyimpan data transaksi pesanan makanan:
 *    nomor order, tanggal transaksi, nama pemesan, daftar item makanan, total biaya,
 *    dan status pesanan ("Diproses", "Sedang Diantar", "Selesai").
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Untuk menampilkan halaman riwayat pesanan (Orders Page) dan detail setiap transaksi.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Model representasi data transaksi pada layer Data / Features Orders.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi OrderModel dan OrderItemModel di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Ubah respon JSON dari endpoint `/orders` menggunakan `OrderModel.fromJson()`.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Objek pesanan lengkap beserta daftar item belanja.
 * ============================================================================
 */

import 'package:equatable/equatable.dart';
import '../../cart/models/cart_item.dart';

class OrderItemModel extends Equatable {
  final String productId;
  final String productName;
  final int price;
  final int quantity;
  final String imageUrl;

  const OrderItemModel({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  factory OrderItemModel.fromCartItem(CartItem item) {
    return OrderItemModel(
      productId: item.productId,
      productName: item.productName,
      price: item.price,
      quantity: item.quantity,
      imageUrl: item.imageUrl,
    );
  }

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['productId']?.toString() ?? '',
      productName: json['productName'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }

  @override
  List<Object?> get props => [productId, productName, price, quantity, imageUrl];
}

class OrderModel extends Equatable {
  final String id;
  final DateTime orderDate;
  final String customerName;
  final String customerAddress;
  final List<OrderItemModel> items;
  final int totalAmount;
  final String status;
  final String paymentMethod;

  const OrderModel({
    required this.id,
    required this.orderDate,
    required this.customerName,
    required this.customerAddress,
    required this.items,
    required this.totalAmount,
    this.status = 'Diproses',
    this.paymentMethod = 'QRIS',
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final rawDate = json['orderDate'] as String?;
    final date = rawDate != null ? DateTime.tryParse(rawDate) ?? DateTime.now() : DateTime.now();

    final rawItems = json['items'] as List<dynamic>? ?? [];
    final itemsList = rawItems.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>)).toList();

    return OrderModel(
      id: json['id']?.toString() ?? '',
      orderDate: date,
      customerName: json['customerName'] as String? ?? 'Pelanggan Foodie',
      customerAddress: json['customerAddress'] as String? ?? 'Alamat Pemesan',
      items: itemsList,
      totalAmount: (json['totalAmount'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'Diproses',
      paymentMethod: json['paymentMethod'] as String? ?? 'QRIS',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderDate': orderDate.toIso8601String(),
      'customerName': customerName,
      'customerAddress': customerAddress,
      'items': items.map((e) => e.toJson()).toList(),
      'totalAmount': totalAmount,
      'status': status,
      'paymentMethod': paymentMethod,
    };
  }

  @override
  List<Object?> get props => [
        id,
        orderDate,
        customerName,
        customerAddress,
        items,
        totalAmount,
        status,
        paymentMethod,
      ];
}
