import 'package:dio/dio.dart';
import '../helpers/api_client.dart';
import '../model/kategori.dart';

class KategoriService {
  Future<List<Kategori>> listData() async {
    final Response response = await ApiClient().get('kategori');
    final List data = response.data as List;
    List<Kategori> result =
        data.map((json) => Kategori.fromJson(json)).toList();
    return result;
  }

  Future<Kategori> simpan(Kategori kategori) async {
    var data = kategori.toJson();
    final Response response = await ApiClient().post('kategori', data);
    Kategori result = Kategori.fromJson(response.data);
    return result;
  }

  Future<Kategori> ubah(Kategori kategori, String id) async {
    var data = kategori.toJson();
    final Response response = await ApiClient().put('kategori/${id}', data);
    print(response);
    Kategori result = Kategori.fromJson(response.data);
    return result;
  }

  Future<Kategori> getById(String id) async {
    final Response response = await ApiClient().get('kategori/${id}');
    Kategori result = Kategori.fromJson(response.data);
    return result;
  }

  Future<Kategori> hapus(Kategori kategori) async {
    final Response response =
        await ApiClient().delete('kategori/${kategori.id}');
    Kategori result = Kategori.fromJson(response.data);
    return result;
  }
}
