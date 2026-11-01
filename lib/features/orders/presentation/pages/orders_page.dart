/*
 * ============================================================================
 * TUGAS: Anggota 2 - Membuat Desain UI Foodie & Halaman Riwayat Pesanan
 * FASE: Fase 5 - Membuat UI Flutter
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Halaman riwayat pesanan (`OrdersPage`) yang menampilkan daftar transaksi pesanan
 *    makanan: status pengerjaan ("Diproses", "Selesai"), rincian makanan, waktu transaksi,
 *    dan total nominal pembayaran.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Memenuhi fitur utama "Pesanan: Menampilkan daftar pesanan dan detail setiap transaksi"
 *    sehingga pengguna dapat memantau status pesanan mereka secara transparan.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer `Presentation / Pages`. Mengambil data dari `OrderProvider`.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi OrdersPage di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Ketuk tab "Pesanan" pada Bottom Navigation.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Kartu transaksi lengkap dengan badge status pesanan dan rincian harga.
 * ============================================================================
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../products/presentation/widgets/empty_state_widget.dart';
import '../../../products/presentation/widgets/error_state_widget.dart';
import '../../../products/presentation/widgets/loading_widget.dart';
import '../../models/order_model.dart';
import '../providers/order_provider.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderProvider>().fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.orders.isEmpty) {
            return const AppLoadingWidget(message: 'Memuat riwayat transaksi...');
          }

          if (provider.errorMessage.isNotEmpty && provider.orders.isEmpty) {
            return ErrorStateWidget(
              message: provider.errorMessage,
              onRetry: () => provider.fetchOrders(),
            );
          }

          if (provider.orders.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.receipt_long_outlined,
              title: 'Belum Ada Pesanan',
              description: 'Kamu belum memesan makanan apa pun. Pesan menu favoritmu sekarang!',
              buttonText: 'Pesan Makanan',
              onButtonPressed: () => context.go('/'),
            );
          }

          return RefreshIndicator(
            color: AppTheme.primaryColor,
            onRefresh: () => provider.fetchOrders(),
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: provider.orders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final order = provider.orders[index];
                return _buildOrderCard(order);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderCard(OrderModel order) {
    final isDone = order.status.toLowerCase() == 'selesai';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baris Header: ID & Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.id,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppTheme.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isDone ? AppTheme.successColor.withOpacity(0.12) : AppTheme.secondaryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order.status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isDone ? AppTheme.successColor : const Color(0xFFD97706),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Waktu Pemesanan
          Text(
            CurrencyFormatter.formatDate(order.orderDate),
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: AppTheme.borderColor),
          const SizedBox(height: 8),

          // Daftar Item
          Column(
            children: order.items.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${item.quantity}x ${item.productName}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ),
                    Text(
                      CurrencyFormatter.formatRupiah(item.price * item.quantity),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 12),
          const Divider(color: AppTheme.borderColor),
          const SizedBox(height: 8),

          // Total Pembayaran & Metode
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.qr_code_rounded, size: 16, color: AppTheme.textSecondary),
                  const SizedBox(width: 4),
                  Text(
                    order.paymentMethod,
                    style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Total: ',
                    style: TextStyle(fontSize: 13, color: AppTheme.textSecondary),
                  ),
                  Text(
                    CurrencyFormatter.formatRupiah(order.totalAmount),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
