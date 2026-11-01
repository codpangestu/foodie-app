/*
 * ============================================================================
 * TUGAS: Anggota 4 - Menghubungkan Flutter dengan API & Setup HTTP Client
 * FASE: Fase 1 & 3 - Setup Project & Membuat REST API
 * ============================================================================
 * 
 * 1. APA FUNGSI FILE ATAU PERINTAH TERSEBUT:
 *    Mengonfigurasi dan mengelola instance `Dio` sebagai HTTP Client pusat aplikasi
 *    untuk melakukan komunikasi data (GET, POST, PUT, DELETE) dengan JSON Server.
 * 
 * 2. MENGAPA KITA MEMBUTUHKANNYA:
 *    Sentralisasi konfigurasi HTTP (Base URL, timeout, header JSON, interceptor log)
 *    membuat panggilan jaringan konsisten dan mempermudah penanganan error koneksi.
 * 
 * 3. BAGAIMANA HUBUNGANNYA DENGAN CLEAN ARCHITECTURE:
 *    Berada di layer Core / Network. Digunakan oleh Remote Datasource di Data Layer
 *    untuk mengeksekusi request HTTP ke API backend.
 * 
 * 4. KODE LENGKAP YANG PERLU KAMU MASUKKAN:
 *    Implementasi class ApiClient dengan wrapper method get, post, put, delete di bawah.
 * 
 * 5. CARA MENJALANKAN DAN MENGUJINYA:
 *    Panggil `ApiClient().get('/products')` dan pastikan data JSON berhasil diterima.
 * 
 * 6. HASIL YANG SEHARUSNYA MUNCUL:
 *    Objek Response Dio dengan status code 200/201/204 sesuai REST API standar.
 * ============================================================================
 */

import 'package:dio/dio.dart';
import '../error/exceptions.dart';
import '../utils/app_constants.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient({Dio? dio}) {
    _dio = dio ??
        Dio(
          BaseOptions(
            baseUrl: AppConstants.baseUrl,
            connectTimeout: AppConstants.connectTimeout,
            receiveTimeout: AppConstants.receiveTimeout,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        );

    // Logging interceptor untuk kemudahan debugging selama pengembangan
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: false,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
      ),
    );
  }

  Dio get dio => _dio;

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
  }) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
  }) async {
    try {
      final response = await _dio.put(path, data: data);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<Response> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.connectionError) {
      return NetworkException(
        message: 'Tidak dapat terhubung ke server. Pastikan backend JSON Server berjalan di ${AppConstants.baseUrl}.',
      );
    }

    final statusCode = e.response?.statusCode;
    final message = e.response?.statusMessage ?? e.message ?? 'Terjadi kesalahan pada server.';
    return ServerException(message: message, statusCode: statusCode);
  }
}
