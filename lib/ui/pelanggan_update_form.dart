import 'package:flutter/material.dart';
import 'package:klinik_app_fauzan/ui/pelanggan_detail.dart';
import 'package:klinik_app_fauzan/model/pelanggan.dart';
import 'pelanggan_detail.dart';
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

  Future<Pelanggan> getData() async {
    Pelanggan data =
        await PelangganService().getById(widget.pelanggan.id.toString());
    setState(() {
      _namaPelangganCtrl.text = data.namaPelanggan;
    });
    return data;
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
      decoration: const InputDecoration(labelText: "Nama Mobil"),
      controller: _namaPelangganCtrl,
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: () async {
          Pelanggan pelanggan =
              new Pelanggan(namaPelanggan: _namaPelangganCtrl.text);
          String id = widget.pelanggan.id.toString();
          await PelangganService().ubah(pelanggan, id).then((value) {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PelangganDetail(pelanggan: value)));
          });
        },
        child: const Text("Simpan"));
  }
}
