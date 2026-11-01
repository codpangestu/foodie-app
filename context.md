# Context Project Foodie App

Dokumen ini melacak status pengerjaan, arsitektur, pembagian tugas anggota, dan perkembangan setiap fase pada aplikasi **Foodie**.

---

## 1. Profil & Gambaran Proyek
- **Nama Aplikasi**: Foodie
- **Deskripsi**: Aplikasi pemesanan makanan berbasis Flutter dengan backend simulasi REST API (JSON Server) dan arsitektur Clean Architecture.
- **Platform Target**: Android (dapat dijalankan juga di iOS, Web, Desktop).
- **State Management**: `Provider`
- **Routing**: `go_router`
- **HTTP Client**: `Dio`
- **Backend / Database**: `json-server` dengan `backend/db.json`

---

## 2. Pembagian Tugas Anggota

| Anggota | Peran & Tanggung Jawab Utama |
|---|---|
| **Anggota 1** | **Setup Project, Struktur Folder & Integrasi**<br>• Membuat project Flutter<br>• Menyiapkan struktur folder Clean Architecture<br>• Mengatur Git & GitHub branch<br>• Mengintegrasikan hasil kerja seluruh anggota<br>• Memastikan aplikasi running di Android |
| **Anggota 2** | **Desain UI, Navigasi & Komponen Reusable**<br>• Desain UI Foodie (Modern, Estetik, Responsif)<br>• Halaman Home/Menu, Detail Produk, Keranjang (Cart), dan Pesanan (Orders)<br>• Navigasi Bottom Navigation Bar & routing<br>• Membuat reusable widget (ProductCard, SearchBar, CategoryChip, dll.) |
| **Anggota 3** | **Alur CRUD Produk & Interaksi Bisnis**<br>• Alur CRUD produk lengkap (Create, Read, Update, Delete)<br>• Form Tambah & Edit Produk<br>• Validasi input form<br>• Dialog konfirmasi penghapusan produk<br>• Alur interaksi Cart & Checkout bersama Anggota 2 & 4 |
| **Anggota 4** | **Backend REST API & Layer Data/Domain (Clean Architecture)**<br>• Menyiapkan struktur `db.json` & JSON Server<br>• Membuat Entity (Domain)<br>• Membuat Repository Contract (Domain)<br>• Membuat Use Cases (Domain)<br>• Membuat Model (Data)<br>• Membuat Remote Datasource (Data)<br>• Membuat Repository Implementation (Data)<br>• Menghubungkan Flutter dengan REST API |
| **Anggota 5** | **Dokumentasi, Diagram & Presentasi**<br>• Dokumentasi teknis aplikasi di `context.md` dan `docs/`<br>• Penjelasan fitur & tujuan aplikasi<br>• Diagram Clean Architecture & alur data<br>• Slide presentasi tim & skenario demonstrasi |

---

## 3. Format Wajib Komentar Kode
Setiap file Dart di dalam project ini WAJIB diawali dengan format komentar standar 6 bagian:

```dart
/*
 * ============================================================================
 * TUGAS: [Anggota X - Deskripsi Tanggung Jawab]
 * FASE: [Fase X - Nama Fase]
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    [Penjelasan fungsi file secara detail]
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    [Alasan teknis dan fungsional implementasi]
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    [Posisi layer: Presentation, Domain, Data, atau Core]
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    [Implementasi kode ada di bawah header ini]
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    [Instruksi run / test]
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    [Ekspektasi output / perilaku sistem]
 * ============================================================================
 */
```

---

## 4. Status Fase Pengerjaan

- [x] **Fase 1: Setup Project & Struktur Folder (Anggota 1)**
  - Konfigurasi `pubspec.yaml` (provider, dio, go_router, equatable, intl, cached_network_image).
  - Struktur folder Clean Architecture (`lib/core/`, `lib/features/products/`, `lib/features/cart/`, `lib/features/orders/`, `lib/features/navigation/`).
- [x] **Fase 2: Setup Database JSON (`db.json`) (Anggota 4)**
  - Schema dan seed data realistis untuk `users`, `categories`, `products`, `carts`, dan `orders` di `backend/db.json`.
- [x] **Fase 3: Membuat & Dokumentasi REST API (Anggota 4)**
  - JSON Server dikonfigurasi dengan script `npm run dev` pada port 3000.
  - Dokumentasi endpoint REST API lengkap di `backend/README.md`.
- [x] **Fase 4: Menerapkan Clean Architecture (Anggota 4)**
  - Core: `exceptions.dart`, `failures.dart`, `api_client.dart`, `currency_formatter.dart`, `app_constants.dart`, `usecase.dart`.
  - Domain: `ProductEntity`, `ProductRepository` contract, UseCases (`GetProducts`, `GetProductById`, `CreateProduct`, `UpdateProduct`, `DeleteProduct`).
  - Data: `ProductModel` (JSON serialization), `ProductRemoteDataSource` (Dio), `ProductRepositoryImpl`.
- [x] **Fase 5: Membuat UI Flutter & Navigasi (Anggota 2)**
  - Visual Theme: `AppTheme` dengan warna warm orange & Material 3.
  - Reusable Widgets: `ProductCard`, `CategoryChipList`, `AppLoadingWidget`, `EmptyStateWidget`, `ErrorStateWidget`.
  - Halaman Pengguna: `HomePage`, `ProductDetailPage`, `CartPage`, `OrdersPage`.
  - Navigasi: `MainNavigationScaffold` (Bottom Navigation Bar dengan badge realtime) & `AppRouter` (`go_router`).
- [x] **Fase 6: Integrasi dan CRUD Produk (Anggota 3)**
  - State Management: `ProductProvider` (CRUD state), `CartProvider` (item & total), `OrderProvider` (transaksi).
  - Halaman Admin CRUD: `AdminProductListPage` (Read & Delete dengan dialog konfirmasi) dan `AdminProductFormPage` (Create & Update dengan form validation).
  - Fitur Upload Gambar: Mendukung pemilihan foto langsung dari Galeri perangkat atau Kamera (`image_picker`) yang di-encode Base64 otomatis ke `db.json`, serta tetap mendukung URL/Asset manual.
  - Integrasi Checkout: Cart -> POST `/orders` -> Orders List.
- [x] **Fase 7: Testing dan Debugging (Anggota 1)**
  - `test/widget_test.dart` (Unit test CurrencyFormatter & ProductEntity, lolos 100%).
  - Analisis statis `flutter analyze` bebas dari compilation/syntax errors.
- [x] **Fase 8: Dokumentasi dan Presentasi (Anggota 5)**
  - `docs/dokumentasi_proyek.md`: Penjelasan fitur, pemetaan requirement, dan diagram Clean Architecture (Mermaid).
  - `docs/slide_presentasi.md`: Susunan slide presentasi lengkap untuk demonstrasi dan pembagian bicara.

---

## 5. Cara Menjalankan Project

### A. Menjalankan Backend JSON Server
```bash
cd backend
npm install
npm run dev
# REST API berjalan di http://localhost:3000
```

### B. Menjalankan Flutter App
```bash
flutter pub get
flutter run
```
*Catatan Android*: Endpoint API diatur dinamis (`http://10.0.2.2:3000` untuk emulator Android, `http://localhost:3000` untuk web/desktop).
