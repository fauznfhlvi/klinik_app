import 'package:flutter/material.dart';
import 'package:klinik_app_fauzan/model/pelanggan.dart';
import 'package:klinik_app_fauzan/ui/pelanggan_detail.dart';
import '../service/pelanggan_service.dart';

class PelangganForm extends StatefulWidget {
  const PelangganForm({super.key});

  @override
  State<PelangganForm> createState() => _PelangganFormState();
}

class _PelangganFormState extends State<PelangganForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPelangganCtrl = TextEditingController();
  final _imageNameCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Pelanggan"),
        backgroundColor: Color.fromRGBO(237, 5, 63, 0.612),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _fieldNamaPelanggan(),
                SizedBox(height: 20),
                _fieldImageName(),
                SizedBox(height: 20),
                _fieldAlamat(),
                SizedBox(height: 20),
                _tombolSimpan()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _fieldNamaPelanggan() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Pelanggan"),
      controller: _namaPelangganCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nama Pelanggan tidak boleh kosong';
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
          return 'Nama Gambar tidak boleh kosong';
        }
        return null;
      },
    );
  }

  _fieldAlamat() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Alamat"),
      controller: _alamatCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Alamat tidak boleh kosong';
        }
        return null;
      },
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState?.validate() ?? false) {
            Pelanggan pelanggan = Pelanggan(
              id: '', // id should be generated by the server
              namaPelanggan: _namaPelangganCtrl.text,
              imageName: _imageNameCtrl.text,
              alamat: _alamatCtrl.text,
            );
            await PelangganService().simpan(pelanggan).then((value) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PelangganDetail(pelanggan: value)));
            });
          }
        },
        child: const Text("Simpan"));
  }
}
