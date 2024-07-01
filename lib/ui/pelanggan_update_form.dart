import 'package:flutter/material.dart';
import 'package:klinik_app_fauzan/ui/pelanggan_detail.dart';
import 'package:klinik_app_fauzan/model/pelanggan.dart';
import '../service/pelanggan_service.dart';

class PelangganUpdateForm extends StatefulWidget {
  final Pelanggan pelanggan;

  const PelangganUpdateForm({Key? key, required this.pelanggan})
      : super(key: key);

  @override
  State<PelangganUpdateForm> createState() => _PelangganUpdateFormState();
}

class _PelangganUpdateFormState extends State<PelangganUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPelangganCtrl = TextEditingController();
  final _imageNameCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    Pelanggan data =
        await PelangganService().getById(widget.pelanggan.id.toString());
    setState(() {
      _namaPelangganCtrl.text = data.namaPelanggan;
      _imageNameCtrl.text = data.imageName;
      _alamatCtrl.text = data.alamat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ubah Pelanggan"),
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
      decoration: const InputDecoration(labelText: "Email"),
      controller: _alamatCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email tidak boleh kosong';
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
              id: widget.pelanggan.id,
              namaPelanggan: _namaPelangganCtrl.text,
              imageName: _imageNameCtrl.text,
              alamat: _alamatCtrl.text,
            );
            await PelangganService()
                .ubah(pelanggan, pelanggan.id)
                .then((value) {
              Navigator.pop(context);
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
