/*
 * ============================================================================
 * TUGAS: Anggota 2 & 4 - Menghubungkan Flutter dengan API & State Management Pesanan
 * FASE: Fase 5 & 6 - Membuat UI & Integrasi CRUD
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Mengelola state riwayat pesanan (Orders) dan mengeksekusi proses checkout pesanan
 *    baru dari keranjang belanja ke endpoint REST API `/orders`.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Untuk menyinkronkan data transaksi antara aplikasi Flutter dan backend JSON Server,
 *    serta menampilkan riwayat transaksi pesanan pada halaman Orders.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Presentation / Providers` untuk fitur Orders.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi OrderProvider di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Panggil `await context.read<OrderProvider>().checkout(...)` saat tombol checkout ditekan.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Pesanan baru tersimpan di backend dan otomatis muncul di daftar halaman Orders.
 * ============================================================================
 */

import 'package:flutter/foundation.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../cart/models/cart_item.dart';
import '../../models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  final ApiClient apiClient;

  OrderProvider({required this.apiClient});

  List<OrderModel> _orders = [];
  List<OrderModel> get orders => _orders;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  /// Mengambil daftar pesanan dari backend
  Future<void> fetchOrders() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await apiClient.get(AppConstants.ordersEndpoint);
      final List<dynamic> data = response.data as List<dynamic>;
      _orders = data.map((e) => OrderModel.fromJson(e as Map<String, dynamic>)).toList();
      // Urutkan dari yang terbaru
      _orders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
      _isLoading = false;
    } catch (e) {
      _errorMessage = 'Gagal memuat riwayat pesanan: $e';
      _isLoading = false;
    }
    notifyListeners();
  }

  /// Membuat pesanan baru (Checkout)
  Future<OrderModel?> checkout({
    required List<CartItem> cartItems,
    required int totalAmount,
    String customerName = 'Budi Santoso',
    String customerAddress = 'Jl. Sudirman No. 45, Jakarta Selatan',
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final orderId = 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';
      final orderItems = cartItems.map((c) => OrderItemModel.fromCartItem(c)).toList();

      final newOrder = OrderModel(
        id: orderId,
        orderDate: DateTime.now(),
        customerName: customerName,
        customerAddress: customerAddress,
        items: orderItems,
        totalAmount: totalAmount,
        status: 'Diproses',
        paymentMethod: 'QRIS',
      );

      await apiClient.post(
        AppConstants.ordersEndpoint,
        data: newOrder.toJson(),
      );

      _orders.insert(0, newOrder);
      _isLoading = false;
      notifyListeners();
      return newOrder;
    } catch (e) {
      _errorMessage = 'Gagal melakukan checkout: $e';
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }
}
