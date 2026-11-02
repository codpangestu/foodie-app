# Backend REST API - Foodie App (JSON Server)

baca ini

# <!--

TUGAS: Anggota 4 - Menyiapkan JSON Server & Struktur db.json
FASE: Fase 2 & 3 - Setup Database JSON & REST API
============================================================================

1. APA FUNGSI FILE / PERINTAH TERSEBUT:
   File ini mendokumentasikan API backend simulasi (REST API) menggunakan json-server
   dan struktur data `db.json` untuk aplikasi Foodie.

2. MENGAPA KITA MEMBUTUHKANNYA:
   Sebagai mock backend yang cepat dan ringan untuk mendemonstrasikan operasi CRUD
   penuh (Create, Read, Update, Delete) tanpa memerlukan setup server database kompleks.

3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
   REST API bertindak sebagai Remote Data Source eksternal yang dihubungi oleh layer
   Data (Datasources & Repositories) melalui HTTP Client (Dio).

4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
   (Dokumentasi endpoint dan panduan menjalankan server di bawah ini)

5. CARA MENJALANKAN DAN MENGUJINYA:
   Buka terminal di folder backend:
   cd backend
   npm install
   npm run dev

6. HASIL YANG SEHARUSNYA MUNCUL:
   Server berjalan di http://localhost:3000 dengan resource:
   - http://localhost:3000/products
   - http://localhost:3000/categories
   - http://localhost:3000/carts
   - http://localhost:3000/orders
   - # http://localhost:3000/users
     -->

## Endpoint REST API

| Method      | Endpoint        | Keterangan                                     |
| ----------- | --------------- | ---------------------------------------------- |
| GET         | `/products`     | Mengambil seluruh daftar produk                |
| GET         | `/products/:id` | Mengambil detail 1 produk berdasarkan ID       |
| POST        | `/products`     | Menambah produk baru (Admin)                   |
| PUT / PATCH | `/products/:id` | Mengubah data produk (Admin)                   |
| DELETE      | `/products/:id` | Menghapus produk (Admin)                       |
| GET         | `/categories`   | Mengambil daftar kategori makanan              |
| GET         | `/carts`        | Mengambil daftar item di keranjang             |
| POST        | `/carts`        | Menambah item ke keranjang                     |
| PUT / PATCH | `/carts/:id`    | Memperbarui kuantitas / catatan item keranjang |
| DELETE      | `/carts/:id`    | Menghapus item dari keranjang                  |
| GET         | `/orders`       | Mengambil riwayat pesanan                      |
| POST        | `/orders`       | Membuat pesanan baru dari checkout             |

## Catatan IP untuk Flutter Android

- **Android Emulator**: Gunakan `http://10.0.2.2:3000`
- **Device Fisik (WiFi sama)**: Gunakan IP lokal laptop (misal: `http://192.168.1.x:3000`)
- **Web / Desktop**: Gunakan `http://localhost:3000`
