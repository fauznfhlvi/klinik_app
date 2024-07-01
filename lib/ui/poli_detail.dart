import 'package:flutter/material.dart';
import '../model/poli.dart';
import 'poli_update_form.dart';
import 'poli_page.dart';
import '../service/poli_service.dart';

class PoliDetail extends StatefulWidget {
  final Poli poli;

  const PoliDetail({super.key, required this.poli});

  @override
  State<PoliDetail> createState() => _PoliDetailState();
}

class _PoliDetailState extends State<PoliDetail> {
  late Future<Poli> _poliDetailFuture;

  @override
  void initState() {
    super.initState();
    _poliDetailFuture = PoliService().getById(widget.poli.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Mobil"),
        backgroundColor: const Color.fromRGBO(237, 5, 63, 0.612),
      ),
      body: FutureBuilder<Poli>(
        future: _poliDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return const Center(child: Text('Data Tidak Ditemukan'));
          }

          Poli? poli = snapshot.data;
          return Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "Nama Mobil: ${poli?.namaPoli ?? ''}",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/${poli?.imageName ?? ''}',
                height: 200,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Text('Gagal memuat gambar');
                },
              ),
              const SizedBox(height: 20),
              Text(
                "${poli?.namaPoli ?? ''}, di bandrol dengan harga ${poli?.harga ?? ''}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [_tombolUbah(poli), _tombolHapus(poli)],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _tombolUbah(Poli? poli) {
    return ElevatedButton(
      onPressed: () {
        if (poli != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PoliUpdateForm(poli: poli),
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      child: const Text("Ubah"),
    );
  }

  Widget _tombolHapus(Poli? poli) {
    return ElevatedButton(
      onPressed: () {
        if (poli != null) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: const Text(
                  "Apakah Anda Yakin ingin menghapus data mobil ini?"),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    await PoliService().hapus(poli).then((value) {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => PoliPage()),
                      );
                    });
                  },
                  child: const Text("Ya"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Tidak"),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
              ],
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      child: const Text("Hapus"),
    );
  }
}
