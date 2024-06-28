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
  Stream<Poli> getData() async* {
    Poli data = await PoliService().getById(widget.poli.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Mobil"),
        backgroundColor: Color.fromRGBO(237, 5, 63, 0.612),
      ),
      body: StreamBuilder(
        stream: getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Text('Data Tidak Ditemukan');
          }
          return Column(
            children: [
              SizedBox(height: 20),
              Text(
                "Nama Mobil : ${snapshot.data.namaPoli}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Image.network(
                'https://bukalapak/gambar-mobil.jpg', // Ganti URL ini dengan URL gambar mobil Anda
                height: 200,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Text('Gagal memuat gambar');
                },
              ),
              SizedBox(height: 20),
              Text(
                "Avanza merupakan mobil dengan mesin 1200 cc dengan di bandrol harga Rp.100.000.000,00 juta rupiah ${snapshot.data.namaPoli}", // Teks baru yang ingin ditambahkan
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [_tombolUbah(), _tombolHapus()],
              )
            ],
          );
        },
      ),
    );
  }

  _tombolUbah() {
    return StreamBuilder(
      stream: getData(),
      builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PoliUpdateForm(poli: snapshot.data),
            ),
          );
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        child: const Text("Ubah"),
      ),
    );
  }

  _tombolHapus() {
    return ElevatedButton(
      onPressed: () {
        AlertDialog alertDialog = AlertDialog(
          content:
              const Text("Apakah Anda Yakin ingin menghapus data mobil ini?"),
          actions: [
            // Tombol ya
            StreamBuilder(
              stream: getData(),
              builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
                onPressed: () async {
                  await PoliService().hapus(snapshot.data).then((value) {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => PoliPage()),
                    );
                  });
                },
                child: Text("Ya"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
            ),
            // Tombol Batal
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Tidak"),
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
