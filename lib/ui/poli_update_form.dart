import 'package:flutter/material.dart';
import '../model/poli.dart';
import 'poli_detail.dart';
import '../service/poli_service.dart';

class PoliUpdateForm extends StatefulWidget {
  final Poli poli;

  const PoliUpdateForm({Key? key, required this.poli}) : super(key: key);

  @override
  State<PoliUpdateForm> createState() => _PoliUpdateFormState();
}

class _PoliUpdateFormState extends State<PoliUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPoliCtrl = TextEditingController();
  final _imageNameCtrl = TextEditingController();
  final _hargaCtrl = TextEditingController();

  Future<void> getData() async {
    Poli data = await PoliService().getById(widget.poli.id);
    setState(() {
      _namaPoliCtrl.text = data.namaPoli;
      _imageNameCtrl.text = data.imageName;
      _hargaCtrl.text = data.harga;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ubah Mobil"),
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
                _fieldHarga(),
                const SizedBox(height: 20),
                _tombolSimpan(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fieldNamaPoli() {
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

  Widget _fieldImageName() {
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

  Widget _fieldHarga() {
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

  Widget _tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState?.validate() ?? false) {
          Poli poli = Poli(
            id: widget.poli.id,
            namaPoli: _namaPoliCtrl.text,
            imageName: _imageNameCtrl.text,
            harga: _hargaCtrl.text,
          );
          await PoliService().ubah(poli, widget.poli.id).then((value) {
            Navigator.pop(context);
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
