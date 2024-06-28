import 'package:flutter/material.dart';
import 'package:klinik_app_fauzan/model/pelanggan.dart';
import 'package:klinik_app_fauzan/ui/pelanggan_detail.dart';
import 'pelanggan_detail.dart';
import '../service/pelanggan_service.dart';
//file poliform12a

class PelangganForm extends StatefulWidget {
  const PelangganForm({super.key});

  @override
  State<PelangganForm> createState() => _PelangganFormState();
}

class _PelangganFormState extends State<PelangganForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPelangganCtrl = TextEditingController();

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
          child: Column(
            children: [
              _fieldNamaPelanggan(),
              SizedBox(height: 20),
              _tombolSimpan()
            ],
          ),
        ),
      ),
    );
  }

  _fieldNamaPelanggan() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Pelanggan"),
      controller: _namaPelangganCtrl,
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: () async {
          Pelanggan pelanggan =
              new Pelanggan(namaPelanggan: _namaPelangganCtrl.text);
          await PelangganService().simpan(pelanggan).then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PelangganDetail(pelanggan: value)));
          });
        },
        child: const Text("Simpan"));
  }
}
