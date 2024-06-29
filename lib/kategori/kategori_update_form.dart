import 'package:flutter/material.dart';
import 'package:klinik_app_fauzan/ui/kategori_detail.dart';
import 'package:klinik_app_fauzan/model/kategori.dart';
import 'kategori_detail.dart';
import '../service/kategori_service.dart';

class KategoriUpdateForm extends StatefulWidget {
  final Kategori kategori;

  const KategoriUpdateForm({Key? key, required this.kategori})
      : super(key: key);

  @override
  State<KategoriUpdateForm> createState() => _KategoriUpdateFormState();
}

class _KategoriUpdateFormState extends State<KategoriUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaKategoriCtrl = TextEditingController();

  Future<Kategori> getData() async {
    Kategori data =
        await KategoriService().getById(widget.kategori.id.toString());
    setState(() {
      _namaKategoriCtrl.text = data.namaKategori;
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
        title: const Text("Ubah Pelanggan"),
        backgroundColor: Color.fromRGBO(237, 5, 63, 0.612),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _fieldNamaKategori(),
              SizedBox(height: 20),
              _tombolSimpan()
            ],
          ),
        ),
      ),
    );
  }

  _fieldNamaKategori() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Pelanggan"),
      controller: _namaKategoriCtrl,
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: () async {
          Kategori kategori =
              new Kategori(namaKategori: _namaKategoriCtrl.text);
          String id = widget.kategori.id.toString();
          await KategoriService().ubah(kategori, id).then((value) {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => KategoriDetail(kategori: value)));
          });
        },
        child: const Text("Simpan"));
  }
}
