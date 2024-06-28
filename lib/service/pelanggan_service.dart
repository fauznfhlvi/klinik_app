import 'package:dio/dio.dart';
import '../helpers/api_client.dart';
import '../model/pelanggan.dart';

class PelangganService {
  Future<List<Pelanggan>> listData() async {
    final Response response = await ApiClient().get('pelanggan');
    final List data = response.data as List;
    List<Pelanggan> result =
        data.map((json) => Pelanggan.fromJson(json)).toList();
    return result;
  }

  Future<Pelanggan> simpan(Pelanggan pelanggan) async {
    var data = pelanggan.toJson();
    final Response response = await ApiClient().post('pelanggan', data);
    Pelanggan result = Pelanggan.fromJson(response.data);
    return result;
  }

  Future<Pelanggan> ubah(Pelanggan pelanggan, String id) async {
    var data = pelanggan.toJson();
    final Response response = await ApiClient().put('pelanggan/${id}', data);
    print(response);
    Pelanggan result = Pelanggan.fromJson(response.data);
    return result;
  }

  Future<Pelanggan> getById(String id) async {
    final Response response = await ApiClient().get('pelanggan/${id}');
    Pelanggan result = Pelanggan.fromJson(response.data);
    return result;
  }

  Future<Pelanggan> hapus(Pelanggan pelanggan) async {
    final Response response =
        await ApiClient().delete('pelanggan/${pelanggan.id}');
    Pelanggan result = Pelanggan.fromJson(response.data);
    return result;
  }
}
