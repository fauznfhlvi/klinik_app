import 'package:flutter/material.dart';
import '../model/poli.dart';
import 'poli_detail.dart';
import '../service/poli_service.dart';

class PoliForm extends StatefulWidget {
  const PoliForm({super.key});

  @override
  State<PoliForm> createState() => _PoliFormState();
}

class _PoliFormState extends State<PoliForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPoliCtrl = TextEditingController();
  final _imageNameCtrl = TextEditingController();
  final _hargaCtrl =
      TextEditingController(); // Tambahkan controller untuk harga

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Mobil"),
        backgroundColor: const Color.fromRGBO(237, 5, 63, 0.612),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _fieldNamaPoli(),
                const SizedBox(height: 20),
                _fieldImageName(),
                const SizedBox(height: 20),
                _fieldHarga(), // Tambahkan input field untuk harga
                const SizedBox(height: 20),
                _tombolSimpan(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _fieldNamaPoli() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Mobil"),
      controller: _namaPoliCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nama mobil tidak boleh kosong';
        }
        return null;
      },
    );
  }

  _fieldImageName() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Gambar"),
      controller: _imageNameCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nama gambar tidak boleh kosong';
        }
        return null;
      },
    );
  }

  _fieldHarga() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Harga"),
      controller: _hargaCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Harga tidak boleh kosong';
        }
        return null;
      },
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState?.validate() ?? false) {
          Poli poli = Poli(
            id: '', // Menggunakan id kosong saat penambahan
            namaPoli: _namaPoliCtrl.text,
            imageName: _imageNameCtrl.text,
            harga: _hargaCtrl.text,
          );
          await PoliService().simpan(poli).then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PoliDetail(poli: value),
              ),
            );
          });
        }
      },
      child: const Text("Simpan"),
    );
  }
}
