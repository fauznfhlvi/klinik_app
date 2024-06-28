import 'package:dio/dio.dart';
import 'package:klinik_app_fauzan/model/pelanggan.dart'; // Menggunakan model Pelanggan jika belum diimport
import '../helpers/api_client.dart';

class PoliService {
  Dio dio = ApiClient.dio;

  Future<List<Pelanggan>> listData() async {
    try {
      final Response response = await dio.get('pelanggan');
      List<Pelanggan> result = (response.data as List)
          .map((json) => Pelanggan.fromJson(json))
          .toList();
      return result;
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<Pelanggan> simpan(Pelanggan pelanggan) async {
    try {
      var data = pelanggan.toJson();
      final Response response = await dio.post('pelanggan', data: data);
      Pelanggan result = Pelanggan.fromJson(response.data);
      return result;
    } catch (e) {
      throw Exception('Failed to save data: $e');
    }
  }

  Future<Pelanggan> ubah(Pelanggan pelanggan, String id) async {
    try {
      var data = pelanggan.toJson();
      final Response response = await dio.put('pelanggan/$id', data: data);
      Pelanggan result = Pelanggan.fromJson(response.data);
      return result;
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  Future<Pelanggan> getById(String id) async {
    try {
      final Response response = await dio.get('pelanggan/$id');
      Pelanggan result = Pelanggan.fromJson(response.data);
      return result;
    } catch (e) {
      throw Exception('Failed to get data: $e');
    }
  }

  Future<void> hapus(Pelanggan pelanggan) async {
    try {
      final Response response = await dio.delete('pelanggan/${pelanggan.id}');
      if (response.statusCode == 204) {
        return;
      } else {
        throw Exception('Failed to delete data');
      }
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }
}
