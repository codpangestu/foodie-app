# 🍔 Foodie - Aplikasi Pemesanan Makanan Modern (Clean Architecture)

<!--
============================================================================
TUGAS: Anggota 5 - Membuat Dokumentasi Aplikasi & README Resmi Proyek
FASE: Fase 8 - Dokumentasi dan Presentasi
============================================================================

1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
   File README.md utama yang menjadi halaman muka repositori resmi proyek Foodie di GitHub.
   Mendokumentasikan gambaran umum, fitur aplikasi, arsitektur Clean Architecture,
   pembagian peran tim (Anggota 1-5), panduan instalasi lokal, panduan emulator MEmu/AVD,
   dokumentasi REST API, panduan push ke GitHub, hingga pengujian sistem.

2. MENGAPA KITA MEMBUTUHKANNYA:
   Sebagai dokumentasi berstandar industri yang mempermudah kolaborator, evaluator,
   dosen/penguji, dan pengembang untuk memahami alur arsitektur serta menjalankan aplikasi
   dengan cepat tanpa kendala konfigurasi.

3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
   Menjelaskan pembagian 3 lapisan arsitektur (Domain, Data, Presentation) beserta
   modul Core, prinsip Dependency Inversion, dan isolasi business logic dari framework.

4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
   (Dokumentasi lengkap proyek di bawah ini)

5. CARA MENJALANKAN DAN MENGUJINYA:
   Dilihat langsung melalui markdown preview atau di halaman GitHub repositori:
   https://github.com/codpangestu/foodie-app

6. HASIL YANG SEHARUSNYA MUNCUL:
   Tampilan dokumentasi proyek yang komprehensif, rapi, informatif, dan profesional.
============================================================================
-->

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-success?style=for-the-badge)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
[![State Management](https://img.shields.io/badge/State%20Management-Provider-blue?style=for-the-badge)](https://pub.dev/packages/provider)
[![Backend](https://img.shields.io/badge/Backend-JSON%20Server-orange?style=for-the-badge&logo=nodedotjs&logoColor=white)](https://github.com/typicode/json-server)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)

**Foodie** adalah aplikasi pemesanan kuliner mobile (Android) yang dikembangkan dengan standar industri menggunakan **Flutter & Dart**, menerapkan pola arsitektur **Clean Architecture (3 Layers: Domain, Data, Presentation + Core)**, manajemen status **Provider**, navigasi deklaratif **GoRouter**, serta terhubung langsung ke **REST API (JSON Server)** dengan operasi **CRUD nyata dan persistensi data**.

Repositori Resmi: [https://github.com/codpangestu/foodie-app](https://github.com/codpangestu/foodie-app)

---

## 📑 Daftar Isi
- [Gambaran Umum](#-gambaran-umum)
- [Fitur Utama Aplikasi](#-fitur-utama-aplikasi)
- [Pemetaan Fitur Terhadap Spesifikasi Tugas](#-pemetaan-fitur-terhadap-spesifikasi-tugas)
- [Arsitektur Sistem (Clean Architecture)](#-arsitektur-sistem-clean-architecture)
- [Pembagian Peran & Tanggung Jawab Tim](#-pembagian-peran--tanggung-jawab-tim)
- [Teknologi & Dependensi](#-teknologi--dependensi)
- [Panduan Instalasi & Menjalankan Aplikasi](#-panduan-instalasi--menjalankan-aplikasi)
  - [Prasyarat Sistem](#1-prasyarat-sistem)
  - [Langkah 1: Clone Repositori](#2-langkah-1-clone-repositori)
  - [Langkah 2: Menjalankan Backend JSON Server](#3-langkah-2-menjalankan-backend-json-server)
  - [Langkah 3: Konfigurasi Emulator (MEmu / AVD)](#4-langkah-3-konfigurasi-emulator-khusus-memu-play--avd)
  - [Langkah 4: Menjalankan Frontend Flutter](#5-langkah-4-menjalankan-frontend-flutter)
- [Panduan Push ke GitHub](#-panduan-push-ke-github)
- [Dokumentasi Endpoint REST API](#-dokumentasi-endpoint-rest-api)
- [Pengujian Sistem (Testing)](#-pengujian-sistem-testing)
- [Dokumentasi Lengkap Proyek](#-dokumentasi-lengkap-proyek)
- [Lisensi & Penulis](#-lisensi--penulis)

---

## 📖 Gambaran Umum

Aplikasi **Foodie** menghadirkan pengalaman pemesanan makanan cepat saji dan minuman secara modern dengan antarmuka yang bersih, responsif, dan kaya umpan balik visual (*micro-interactions*). Dibangun dari awal dengan memisahkan kode bisnis murni dari antarmuka visual, aplikasi ini dirancang agar mudah dirawat (*maintainable*), mudah diuji (*testable*), dan siap ditingkatkan ke skala yang lebih besar (*scalable*).

---

## ✨ Fitur Utama Aplikasi

| Fitur | Deskripsi Layar & Alur Interaksi |
|---|---|
| 🏠 **Home / Menu** | Katalog makanan interaktif dilengkapi banner promosi, pencarian teks real-time, filter kategori (Semua, Makanan Utama, Minuman, Camilan, Dessert), serta tombol cepat tambah ke keranjang. |
| 🔍 **Detail Produk** | Informasi mendalam produk meliputi foto HD, nama, badge kategori, harga terformat Rupiah, rating & review, deskripsi lengkap, sisa stok, kolom catatan khusus pesanan (*custom notes*), dan tombol penambah kuantitas. |
| 🛒 **Keranjang (Cart)** | Pengaturan kuantitas porsi makanan (+/-) secara dinamis, hapus item dengan modal dialog konfirmasi, rincian subtotal & ongkos kirim otomatis, serta tombol checkout pesanan. Dilengkapi badge jumlah pesanan *real-time* di Bottom Navigation Bar. |
| 📋 **Pesanan (Orders)** | Riwayat transaksi pesanan yang telah dibayar/checkout, rincian produk yang dipesan, status pesanan real-time (*Diproses*, *Selesai*), estimasi waktu pengantaran, dan metode pembayaran (QRIS / E-Wallet). |
| ⚙️ **Admin Panel (CRUD)** | Panel khusus manajemen katalog menu: **Create** (tambah menu baru dengan upload foto kamera/galeri), **Read** (katalog data tabel/list), **Update** (form edit data & stok), dan **Delete** (hapus menu permanen dari server dengan konfirmasi). |
| 🛡️ **Penanganan State Komprehensif** | Tampilan seragam untuk 4 kondisi data: **Loading State** (animasi indikator memuat data), **Empty State** (ilustrasi ramah saat data kosong), **Success State** (SnackBar dan feedback modal), serta **Error/Retry State** (pesan kesalahan koneksi dengan tombol coba lagi). |

---

## 🎯 Pemetaan Fitur Terhadap Spesifikasi Tugas

| Requirement Tugas | Implementasi di Foodie App | Status |
|---|---|:---:|
| **Dashboard** | Halaman utama Home dengan carousel banner promo & katalog menu | ✅ Selesai |
| **Navigasi** | Bottom Navigation Bar 4 Menu (`go_router` deklaratif) | ✅ Selesai |
| **Daftar Data** | Grid produk responsif dengan informasi harga, rating, & stok | ✅ Selesai |
| **Detail Data** | Layar detail produk lengkap dengan opsi kuantitas dan catatan pesanan | ✅ Selesai |
| **Create (Tambah Data)** | Form tambah menu di Admin Panel dengan upload foto dari galeri/kamera | ✅ Selesai |
| **Read (Baca Data)** | Pengambilan katalog real-time dari REST API JSON Server | ✅ Selesai |
| **Update (Ubah Data)** | Form edit menu dengan validasi input dan pembaruan data real-time | ✅ Selesai |
| **Delete (Hapus Data)** | Penghapusan data produk dilengkapi dialog modal konfirmasi aman | ✅ Selesai |
| **Validasi Form** | Validasi komprehensif (`GlobalKey<FormState>`, cek input kosong, angka valid) | ✅ Selesai |
| **Loading State** | Indikator pemuatan data seragam (`AppLoadingWidget`) | ✅ Selesai |
| **Empty State** | Tampilan ilustrasi ramah saat data/keranjang kosong (`EmptyStateWidget`) | ✅ Selesai |
| **Success Feedback** | Notifikasi SnackBar hijau dan alert dialog saat aksi sukses | ✅ Selesai |
| **Error / Retry State** | Penanganan gagal koneksi API dilengkapi tombol *Coba Lagi* | ✅ Selesai |
| **Upload Gambar** | Integrasi `image_picker` dengan konversi Base64 URI & fallback network | ✅ Selesai |
| **CRUD Nyata & Terhubung** | Terhubung ke REST API JSON Server (`backend/db.json`) dengan method HTTP standar | ✅ Selesai |

---

## 🏛️ Arsitektur Sistem (Clean Architecture)

Aplikasi Foodie mengadopsi **Clean Architecture (3 Layers)** karya Robert C. Martin (Uncle Bob). Setiap lapisan memiliki batasan yang tegas dan alur dependensi hanya mengarah ke dalam (*Inward Dependency Rule*).

```text
       +-------------------------------------------------------+
       |                  PRESENTATION LAYER                   |
       |  (UI Pages, Custom Widgets, Provider State Management) |
       +---------------------------+---------------------------+
                                   |
                                   v
       +-------------------------------------------------------+
       |                     DOMAIN LAYER                      |
       |     (Entities murni, Use Cases, Repository Contracts)  |
       +---------------------------+---------------------------+
                                   ^
                                   |
       +-------------------------------------------------------+
       |                      DATA LAYER                       |
       |    (Models, Remote Data Sources / Dio, Repo Impl)     |
       +-------------------------------------------------------+
                                   |
                   +---------------+---------------+
                   |          CORE MODULE          |
                   | (Error, Network, Theme, Utils)|
                   +-------------------------------+
```

### Struktur Folder Proyek
```text
foodie/
├── android/                         <-- Konfigurasi platform Android & gradle
├── assets/                          <-- Direktori aset gambar & ikon lokal
├── backend/                         <-- REST API mandiri (JSON Server)
│   ├── db.json                      <-- Database simulasi (products, categories, carts, orders)
│   ├── package.json                 <-- Konfigurasi dependensi Node.js & script dev
│   └── README.md                    <-- Dokumentasi khusus REST API backend
├── docs/                            <-- Dokumentasi teknis & presentasi
│   ├── dokumentasi_proyek.md        <-- Laporan teknis lengkap & diagram arsitektur
│   └── slide_presentasi.md          <-- 9 Slide presentasi tim & panduan demo
├── lib/
│   ├── core/                        <-- Modul lintas layer (Cross-cutting concerns)
│   │   ├── error/
│   │   │   ├── exceptions.dart      <-- ServerException, NetworkException
│   │   │   └── failures.dart        <-- ServerFailure, NetworkFailure
│   │   ├── network/
│   │   │   └── api_client.dart      <-- Dio HTTP Client (GET, POST, PUT, DELETE)
│   │   ├── theme/
│   │   │   └── app_theme.dart       <-- Palet warna warm coral, tipografi, Material 3
│   │   ├── usecases/
│   │   │   └── usecase.dart         <-- Kontrak standar UseCase<Type, Params>
│   │   └── utils/
│   │       ├── app_constants.dart   <-- Konfigurasi Base URL, Endpoints, Timeout
│   │       └── currency_formatter.dart <-- Formatter Rupiah (IDR) & Tanggal
│   │
│   ├── features/                    <-- Fitur modular berbasis Clean Architecture
│   │   ├── products/                <-- Fitur Katalog & CRUD Menu Makanan
│   │   │   ├── domain/              <-- Aturan bisnis murni
│   │   │   │   ├── entities/        <-- ProductEntity
│   │   │   │   ├── repositories/    <-- ProductRepository (Interface/Kontrak)
│   │   │   │   └── usecases/        <-- GetProducts, CreateProduct, UpdateProduct, dll.
│   │   │   ├── data/                <-- Implementasi sumber data
│   │   │   │   ├── models/          <-- ProductModel (JSON Serializer)
│   │   │   │   ├── datasources/     <-- ProductRemoteDataSource (Dio REST client)
│   │   │   │   └── repositories/    <-- ProductRepositoryImpl
│   │   │   └── presentation/        <-- Antarmuka dan Manajemen State
│   │   │       ├── providers/       <-- ProductProvider (ChangeNotifier)
│   │   │       ├── widgets/         <-- ProductCard, CustomImageView, States, dll.
│   │   │       └── pages/           <-- HomePage, ProductDetailPage, AdminProductPages
│   │   │
│   │   ├── cart/                    <-- Fitur Keranjang Belanja
│   │   │   ├── models/              <-- CartItem
│   │   │   └── presentation/        <-- CartProvider & CartPage
│   │   │
│   │   ├── orders/                  <-- Fitur Riwayat Transaksi Pesanan
│   │   │   ├── models/              <-- OrderModel & OrderItemModel
│   │   │   └── presentation/        <-- OrderProvider & OrdersPage
│   │   │
│   │   └── navigation/              <-- Sistem Navigasi & Routing
│   │       ├── main_navigation_scaffold.dart <-- Bottom Nav Bar + Notifikasi Badge
│   │       └── app_router.dart      <-- Deklaratif routing GoRouter
│   │
│   └── main.dart                    <-- Titik masuk aplikasi & Dependency Injection
├── test/
│   └── widget_test.dart             <-- Unit test formatter & entities
├── pubspec.yaml                     <-- Dependensi pustaka Flutter
└── README.md                        <-- Panduan resmi repositori
```

---

## 👥 Pembagian Peran & Tanggung Jawab Tim

Proyek ini dikembangkan oleh 5 anggota tim dengan pembagian tugas yang jelas pada setiap fase:

| Anggota Tim | Peran Utama | Rincian Tanggung Jawab & Berkas Terkait |
|---|---|---|
| **Anggota 1** | **Project Setup & Integration** | • Inisialisasi proyek Flutter & struktur direktori Clean Architecture.<br>• Manajemen dependensi `pubspec.yaml`.<br>• Integrasi Dependency Injection seluruh layer di `lib/main.dart`.<br>• Pengujian otomatis unit test di `test/widget_test.dart` (Lolos 100%). |
| **Anggota 2** | **UI/UX & Navigation** | • Perancangan desain sistem dan tema visual di `app_theme.dart`.<br>• Pembuatan antarmuka Home, Detail Produk, Keranjang, dan Pesanan.<br>• Implementasi sistem navigasi Bottom Navigation Bar dengan live badge.<br>• Pembuatan komponen reusable (`ProductCard`, `CustomImageView`, dll.). |
| **Anggota 3** | **CRUD Logic & Validation** | • Implementasi alur CRUD Produk lengkap di `ProductProvider`.<br>• Pembuatan layar Admin Panel (`AdminProductListPage`, `AdminProductFormPage`).<br>• Menerapkan validasi form ketat (`GlobalKey<FormState>`).<br>• Dialog modal konfirmasi penghapusan data dan integrasi upload gambar. |
| **Anggota 4** | **Database & Clean Architecture Core** | • Pemodelan struktur database REST API di `backend/db.json`.<br>• Konfigurasi backend mandiri menggunakan `json-server`.<br>• Implementasi lapisan Domain murni (Entity, Use Cases, Repository Contracts).<br>• Implementasi lapisan Data (Model serialisasi, Dio Remote DataSource, Repo Impl). |
| **Anggota 5** | **Documentation & Presentation** | • Penyusunan dokumentasi teknis komprehensif di `docs/dokumentasi_proyek.md`.<br>• Pembuatan diagram arsitektur dan sequence alur data (Mermaid).<br>• Penulisan 9 slide presentasi tim di `docs/slide_presentasi.md`.<br>• Pemeliharaan pelacak progres di `context.md` dan `README.md`. |

---

## 🛠️ Teknologi & Dependensi

| Pustaka / Alat | Versi | Fungsi dalam Proyek |
|---|---|---|
| **Flutter SDK** | `^3.13.0` | Framework pengembangan aplikasi multiplatform |
| **Dart SDK** | `^3.0.0` | Bahasa pemrograman utama |
| **provider** | `^6.1.5` | State management reaktif berbasis `ChangeNotifier` |
| **go_router** | `^18.1.2` | Routing deklaratif dengan path parameter dan navigasi shell |
| **dio** | `^5.11.1` | HTTP Client bertenaga untuk request REST API, interceptor, & timeout |
| **image_picker** | `^1.2.4` | Pengambilan gambar dari kamera atau galeri perangkat Android |
| **intl** | `^0.20.3` | Format mata uang Rupiah (`NumberFormat.currency`) dan tanggal |
| **equatable** | `^3.0.0` | Perbandingan nilai objek entity & model tanpa boilerplate |
| **json-server** | `^0.17.4` | Mock backend REST API dengan persistensi JSON otomatis |

---

## 🚀 Panduan Instalasi & Menjalankan Aplikasi

Ikuti langkah-langkah berikut untuk menjalankan aplikasi Foodie di komputer lokal kamu:

### 1. Prasyarat Sistem
Pastikan perangkat kamu telah terpasang:
- **Flutter SDK** versi 3.x ([Panduan Instalasi Flutter](https://docs.flutter.dev/get-started/install))
- **Node.js** versi 16 atau lebih baru ([Unduh Node.js](https://nodejs.org/))
- **Git** ([Unduh Git](https://git-scm.com/))
- Android Emulator (**MEmu Play**, **Android Studio AVD**) atau HP Android fisik dengan mode USB Debugging aktif.

---

### 2. Langkah 1: Clone Repositori
Buka terminal dan clone repositori ini ke komputer lokal kamu:
```bash
git clone https://github.com/codpangestu/foodie-app.git
cd foodie-app
```

---

### 3. Langkah 2: Menjalankan Backend JSON Server
Buka terminal **pertama** dan masuk ke direktori `backend`:
```bash
cd backend
npm install
npm run dev
```
> Server REST API akan berjalan di: `http://localhost:3000` (atau `http://0.0.0.0:3000`).  
> *Biarkan terminal ini tetap terbuka selama aplikasi digunakan.*

---

### 4. Langkah 3: Konfigurasi Emulator (Khusus MEmu Play / AVD)

#### A. Jika menggunakan Emulator MEmu Play (Sangat Direkomendasikan):
Emulator MEmu Play terhubung melalui port ADB `21503`. Agar MEmu dapat mengakses REST API di `localhost:3000` komputer secara langsung, jalankan perintah **port forwarding** di terminal:
```bash
adb reverse tcp:3000 tcp:3000
```
*(Setelah menjalankan perintah di atas, aplikasi di MEmu dapat langsung memanggil API melalui `http://localhost:3000` tanpa konfigurasi tambahan).*

#### B. Jika menggunakan Android Studio Emulator (AVD Standar):
Jika kamu menggunakan AVD bawaan Android Studio, ubah alamat `baseUrl` di file [app_constants.dart](file:///e:/ANDROID%20DEV%20JOURNEY/initial%20dev/foodie/lib/core/utils/app_constants.dart) menjadi:
```dart
static const String baseUrl = 'http://10.0.2.2:3000';
```

#### C. Jika menggunakan Perangkat Fisik Android (USB Debugging / WiFi):
1. Sambungkan HP dan laptop ke jaringan WiFi yang sama.
2. Cek alamat IP lokal laptop kamu (misal: `192.168.1.15`).
3. Ubah `baseUrl` di [app_constants.dart](file:///e:/ANDROID%20DEV%20JOURNEY/initial%20dev/foodie/lib/core/utils/app_constants.dart) menjadi:
```dart
static const String baseUrl = 'http://192.168.1.15:3000';
```

---

### 5. Langkah 4: Menjalankan Frontend Flutter
Buka terminal **kedua** di root direktori proyek `foodie`:
```bash
flutter pub get
flutter run
```
Pilih perangkat emulator atau HP yang aktif untuk menjalankan aplikasi.

---

## 📤 Panduan Push ke GitHub

Jika kamu ingin memperbarui atau mem-push kode proyek ini ke repositori GitHub kamu, ikuti urutan perintah berikut:

### 1. Cek Status Perubahan
```bash
git status
```

### 2. Tambahkan Semua Berkas ke Staging Area
```bash
git add .
```

### 3. Buat Commit dengan Pesan Deskriptif
```bash
git commit -m "feat: implement Clean Architecture, CRUD operations, and comprehensive documentation"
```

### 4. Push ke Repositori GitHub
```bash
git push -u origin main
```

> **Catatan Autentikasi GitHub:**  
> Jika terminal meminta password, gunakan **Personal Access Token (PAT)** GitHub kamu (Token Settings > Developer Settings > Personal Access Tokens > Classic Token dengan izin `repo`).

---

## 📡 Dokumentasi Endpoint REST API

Backend menggunakan **JSON Server** dengan endpoint RESTful standar:

| HTTP Method | Endpoint | Fungsi | Contoh Payload / Parameter |
|---|---|---|---|
| `GET` | `/products` | Mengambil seluruh katalog produk | `?_sort=rating&_order=desc` |
| `GET` | `/products/:id` | Mengambil 1 produk berdasarkan ID | `id` (integer) |
| `POST` | `/products` | Menambah produk baru (Admin Create) | `{ "name": "...", "price": 25000, "category": "Makanan Utama", "imageUrl": "..." }` |
| `PUT` | `/products/:id` | Memperbarui seluruh data produk (Admin Update) | Objek produk lengkap |
| `PATCH` | `/products/:id` | Memperbarui sebagian field produk | `{ "price": 28000 }` |
| `DELETE` | `/products/:id` | Menghapus produk dari database | `id` (integer) |
| `GET` | `/categories` | Mengambil daftar kategori makanan | - |
| `GET` | `/carts` | Mengambil daftar item di keranjang belanja | - |
| `POST` | `/carts` | Menambahkan item ke keranjang | `{ "productId": 1, "quantity": 2, "notes": "Tidak pedas" }` |
| `DELETE` | `/carts/:id` | Menghapus item dari keranjang | `id` (integer) |
| `GET` | `/orders` | Mengambil riwayat transaksi pesanan | - |
| `POST` | `/orders` | Menyimpan pesanan baru hasil checkout | `{ "items": [...], "totalAmount": 55000, "status": "Diproses" }` |

Untuk dokumentasi teknis backend selengkapnya, silakan baca [backend/README.md](file:///e:/ANDROID%20DEV%20JOURNEY/initial%20dev/foodie/backend/README.md).

---

## 🧪 Pengujian Sistem (Testing)

Proyek ini telah melalui pengujian unit test dan analisis statis kode:

### Menjalankan Unit Test
```bash
flutter test
```
**Hasil Pengujian:**
```text
00:00 +0: Smoke Test & Unit Test Foodie CurrencyFormatter format rupiah dengan benar
00:00 +1: Smoke Test & Unit Test Foodie ProductEntity properti terisi dengan benar
00:00 +2: All tests passed!
```

### Menjalankan Analisis Statis Kode (Linter)
```bash
flutter analyze --no-fatal-infos
```
*Hasil: `0 errors, 0 warnings` (Lolos analisis kualitas kode Flutter).*

---

## 📚 Dokumentasi Lengkap Proyek

Informasi mendalam dan bahan presentasi proyek dapat diakses melalui dokumen-dokumen pendukung berikut:
1. 📄 **Laporan Teknis & Diagram Lengkap**: [docs/dokumentasi_proyek.md](file:///e:/ANDROID%20DEV%20JOURNEY/initial%20dev/foodie/docs/dokumentasi_proyek.md)  
   *(Membahas analisis arsitektur, diagram kelas, sequence diagram, data flow, dan evaluasi pengujian)*.
2. 📊 **Slide Presentasi Tim**: [docs/slide_presentasi.md](file:///e:/ANDROID%20DEV%20JOURNEY/initial%20dev/foodie/docs/slide_presentasi.md)  
   *(Memuat 9 slide presentasi siap pakai untuk demonstrasi tugas besar dan skenario demo live)*.
3. 🌐 **Dokumentasi REST API Server**: [backend/README.md](file:///e:/ANDROID%20DEV%20JOURNEY/initial%20dev/foodie/backend/README.md)  
   *(Panduan skema JSON dan konfigurasi port host)*.
4. 📋 **Pelacak Progres Tim (Phase Tracker)**: [context.md](file:///e:/ANDROID%20DEV%20JOURNEY/initial%20dev/foodie/context.md)  
   *(Catatan pelacakan 8 fase pengerjaan proyek dari awal hingga selesai)*.

---

## 📄 Lisensi & Penulis

Proyek ini dibuat dan dikembangkan sebagai implementasi aplikasi mobile modern berstandar industri dengan Clean Architecture.

- **Pengembang**: Tim Pengembang Foodie
- **Repositori**: [@codpangestu/foodie-app](https://github.com/codpangestu/foodie-app)

