import 'package:flutter/material.dart';
import 'package:klinik_app_fauzan/model/kategori.dart';
import 'package:klinik_app_fauzan/service/kategori_service.dart';
import 'package:klinik_app_fauzan/ui/kategori_detail.dart';

// file poliform12a

class KategoriForm extends StatefulWidget {
  const KategoriForm({super.key});

  @override
  State<KategoriForm> createState() => _KategoriFormState();
}

class _KategoriFormState extends State<KategoriForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaKategoriCtrl = TextEditingController();

  @override
  void dispose() {
    _namaKategoriCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Kategori"),
        backgroundColor: const Color.fromRGBO(237, 5, 63, 0.612),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _fieldNamakategori(),
                const SizedBox(height: 20),
                _tombolSimpan()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _fieldNamakategori() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Nama kategori",
        border: OutlineInputBorder(),
      ),
      controller: _namaKategoriCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nama kategori tidak boleh kosong';
        }
        return null;
      },
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          try {
            Kategori kategori = Kategori(namaKategori: _namaKategoriCtrl.text);
            Kategori savedKategori = await KategoriService().simpan(kategori);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => KategoriDetail(kategori: savedKategori),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Gagal menyimpan kategori: $e'),
              ),
            );
          }
        }
      },
      child: const Text("Simpan"),
    );
  }
}
