import 'package:flutter/material.dart';
import 'package:klinik_app_fauzan/ui/pelanggan_form.dart';
import 'package:klinik_app_fauzan/model/pelanggan.dart';
import 'pelanggan_update_form.dart';
import '../service/pelanggan_service.dart';

class PelangganDetail extends StatefulWidget {
  final Pelanggan pelanggan;

  const PelangganDetail({super.key, required this.pelanggan});

  @override
  State<PelangganDetail> createState() => _PelangganDetailState();
}

class _PelangganDetailState extends State<PelangganDetail> {
  late Future<Pelanggan> _futurePelanggan;

  @override
  void initState() {
    super.initState();
    _futurePelanggan =
        PelangganService().getById(widget.pelanggan.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pelanggan"),
        backgroundColor: const Color.fromRGBO(237, 5, 63, 0.612),
      ),
      body: FutureBuilder<Pelanggan>(
        future: _futurePelanggan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Data Tidak Ditemukan'));
          } else {
            return Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "Nama Pelanggan : ${snapshot.data!.namaPelanggan}",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                snapshot.data!.imageName.isNotEmpty
                    ? Image.asset(
                        'assets/images/${snapshot.data!.imageName}',
                        height: 200,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const Text('Gagal memuat gambar');
                        },
                      )
                    : const Text('Tidak ada gambar'),
                const SizedBox(height: 20),
                Text(
                  "Alamat : ${snapshot.data!.alamat}",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _tombolUbah(snapshot.data!),
                    _tombolHapus(snapshot.data!)
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _tombolUbah(Pelanggan pelanggan) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PelangganUpdateForm(pelanggan: pelanggan),
          ),
        );
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      child: const Text("Ubah"),
    );
  }

  Widget _tombolHapus(Pelanggan pelanggan) {
    return ElevatedButton(
      onPressed: () {
        AlertDialog alertDialog = AlertDialog(
          content: const Text(
              "Apakah Anda Yakin ingin menghapus data pelanggan ini?"),
          actions: [
            ElevatedButton(
              onPressed: () async {
                try {
                  await PelangganService().hapus(pelanggan);
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PelangganForm()),
                  );
                } catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal menghapus data: $e')),
                  );
                }
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
            ),
          ],
        );
        showDialog(context: context, builder: (context) => alertDialog);
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      child: const Text("Hapus"),
    );
  }
}
