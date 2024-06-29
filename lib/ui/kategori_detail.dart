import 'package:flutter/material.dart';
import 'package:klinik_app_fauzan/ui/kategori_form.dart';
import 'package:klinik_app_fauzan/model/kategori.dart';
import 'kategori_update_form.dart';
import '../service/kategori_service.dart';

class KategoriDetail extends StatefulWidget {
  final Kategori kategori;

  const KategoriDetail({super.key, required this.kategori});

  @override
  State<KategoriDetail> createState() => _KategoriDetailState();
}

class _KategoriDetailState extends State<KategoriDetail> {
  Stream<Kategori> getData() async* {
    Kategori data =
        await KategoriService().getById(widget.kategori.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Kategori"),
        backgroundColor: const Color.fromRGBO(237, 5, 63, 0.612),
      ),
      body: StreamBuilder(
        stream: getData(),
        builder: (context, AsyncSnapshot<Kategori> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return const Center(child: Text('Data Tidak Ditemukan'));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Nama Kategori: ${snapshot.data?.namaKategori}",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _tombolUbah(snapshot.data!),
                    _tombolHapus(snapshot.data!)
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _tombolUbah(Kategori kategori) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KategoriUpdateForm(kategori: kategori),
          ),
        );
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      child: const Text("Ubah"),
    );
  }

  Widget _tombolHapus(Kategori kategori) {
    return ElevatedButton(
      onPressed: () {
        AlertDialog alertDialog = AlertDialog(
          content: const Text(
              "Apakah Anda Yakin ingin menghapus data kategori ini?"),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await KategoriService()
                    .hapus(kategori.id.String())
                    .then((value) {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const KategoriForm()),
                  );
                });
              },
              child: const Text("Ya"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Tidak"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            )
          ],
        );
        showDialog(context: context, builder: (context) => alertDialog);
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      child: const Text("Hapus"),
    );
  }
}
