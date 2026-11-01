# Materi Slide Presentasi Aplikasi Foodie

<!--
============================================================================
TUGAS: Anggota 5 - Membuat Slide Presentasi & Menyiapkan Materi Demonstrasi
FASE: Fase 8 - Dokumentasi dan Presentasi
============================================================================

1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
   Menyediakan naskah dan susunan slide presentasi resmi untuk tim pengembang
   aplikasi Foodie saat mempresentasikan proyek di hadapan dosen/evaluator.

2. MENGAPA KITA MEMBUTUHKANNYA:
   Memastikan presentasi terstruktur rapi, mencakup seluruh requirement yang dinilai,
   dan membagi peran bicara secara adil untuk Anggota 1 hingga Anggota 5.

3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
   Menjelaskan konsep arsitektur dan keunggulannya secara visual dalam slide.

4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
   (Susunan slide presentasi di bawah)

5. CARA MENJALANKAN DAN MENGUJINYA:
   Dapat diekspor ke PowerPoint / Google Slides atau dipresentasikan langsung.

6. HASIL YANG SEHARUSNYA MUNCUL:
   Materi presentasi 9 slide dengan panduan bicara dan skenario live demo.
============================================================================
-->

---

## Slide 1: Cover & Judul Presentasi
- **Judul**: Foodie - Aplikasi Pemesanan Kuliner Modern Berbasis Flutter & Clean Architecture
- **Subtitle**: Penerapan REST API CRUD, Provider State Management, dan Arsitektur Modular
- **Disusun Oleh**: Tim Pengembang Foodie (Anggota 1 - 5)
- **Pembicara**: Anggota 1 (Membuka presentasi & memperkenalkan anggota)

---

## Slide 2: Latar Belakang & Masalah
- **Latar Belakang**:
  - Industri kuliner bergerak cepat menuju digitalisasi pemesanan instan.
  - Kebutuhan aplikasi mobile yang responsif, terstruktur rapi, dan mudah di-maintain.
- **Tantangan Teknis**:
  - Kode yang bercampur aduk antara UI dan Business Logic membuat aplikasi sulit di-scale dan diuji.
  - Pentingnya pemisahan lapisan (separation of concerns) menggunakan standar arsitektur industri.
- **Pembicara**: Anggota 5

---

## Slide 3: Arsitektur Aplikasi (Clean Architecture)
- **Konsep Clean Architecture (Uncle Bob)**:
  1. **Presentation Layer**: UI Widgets, Pages, dan Providers.
  2. **Domain Layer**: Core Business Logic murni (Entities, Use Cases, Repository Contracts).
  3. **Data Layer**: Implementasi data (Models, Remote Datasources, Repositories).
  4. **Core Layer**: Error Handling (Exception & Failure), ApiClient (Dio), dan Utilities.
- **Keuntungan**:
  - UI independen dari backend/database.
  - Logika bisnis mudah diuji (*testable*).
- **Pembicara**: Anggota 4

---

## Slide 4: Backend REST API & Struktur Data
- **Teknologi**: JSON Server + `db.json` pada port 3000.
- **Entitas Data Utama**:
  - `products`: id, name, description, price, category, imageUrl, rating, stock.
  - `categories`: Makanan Utama, Minuman, Camilan, Dessert.
  - `carts`: Item keranjang belanja.
  - `orders`: Riwayat transaksi dan rincian belanja.
- **Endpoint**:
  - `GET /products`, `POST /products`, `PUT /products/:id`, `DELETE /products/:id`.
- **Pembicara**: Anggota 4

---

## Slide 5: Fitur Utama Pengguna (Customer Flow)
- **Home / Dashboard**:
  - Pencarian makanan real-time (search bar).
  - Filter kategori makanan horizontal chip.
  - Grid menu dengan badge rating dan tombol tambah cepat.
- **Detail Produk**:
  - Informasi deskripsi, sisa stok porsi.
  - Input catatan pesanan (misal: "tidak pedas").
  - Pengatur kuantitas (+/-) dan kalkulasi subtotal otomatis.
- **Keranjang & Checkout**:
  - Mengubah jumlah porsi dan menghapus menu.
  - Checkout instan yang tersimpan ke endpoint `/orders`.
- **Pembicara**: Anggota 2

---

## Slide 6: Fitur Admin & Implementasi CRUD Nyata
- **Tujuan Halaman Admin**:
  - Memberikan demonstrasi nyata pengujian Create, Read, Update, dan Delete ke backend REST API.
- **Operasi CRUD**:
  - **Create**: Form penambahan menu baru dengan validasi field wajib.
  - **Read**: Daftar produk ter-update secara real-time.
  - **Update**: Form edit harga, stok, nama, atau deskripsi menu.
  - **Delete**: Penghapusan menu dengan dialog konfirmasi modal pengaman.
- **Pembicara**: Anggota 3

---

## Slide 7: Pemenuhan Standar User Experience (UX States)
- **Loading State**: Circular progress indicator oranye saat data diambil.
- **Empty State**: Ilustrasi bersahabat saat menu, hasil pencarian, atau keranjang kosong.
- **Success State**: Floating SnackBar hijau saat aksi berhasil dieksekusi.
- **Error State**: Pesan kegagalan ramah pengguna dilengkapi tombol "Coba Lagi" (Retry).
- **Pembicara**: Anggota 2 & Anggota 3

---

## Slide 8: Pembagian Kerja & Kontribusi Tim
- **Anggota 1**: Project Setup, Folder Architecture, Integrasi Modul, & Build Android.
- **Anggota 2**: UI/UX Design, Home, Detail, Cart, Orders, Reusable Widgets, & Navigasi.
- **Anggota 3**: Alur CRUD Produk, Form Validasi, Dialog Konfirmasi, & Integrasi Keranjang.
- **Anggota 4**: Database JSON, REST API JSON Server, Domain & Data Layer Clean Architecture.
- **Anggota 5**: Dokumentasi Teknis, Diagram Clean Architecture, Slide, & Skenario Demo.
- **Pembicara**: Anggota 1 & Anggota 5

---

## Slide 9: Skenario Live Demonstration
1. **Langkah 1**: Menjalankan JSON Server (`npm run dev`) dan Aplikasi Flutter (`flutter run`).
2. **Langkah 2**: Menjelajahi menu di Home, mencoba pencarian "Burger", memilih filter kategori "Minuman".
3. **Langkah 3**: Membuka Detail Produk, menambah catatan pesanan, memasukkan ke Keranjang.
4. **Langkah 4**: Membuka Keranjang Belanja, menaikkan jumlah porsi, melakukan Checkout.
5. **Langkah 5**: Membuka menu Pesanan dan memverifikasi data transaksi telah masuk.
6. **Langkah 6**: Masuk ke menu Admin, menambah menu baru "Sate Ayam Madura", lalu mengedit harganya, dan menghapusnya dengan konfirmasi dialog.
- **Pembicara**: Seluruh Anggota Tim
