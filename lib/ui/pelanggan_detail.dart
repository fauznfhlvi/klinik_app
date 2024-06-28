import 'package:flutter/material.dart';
import '../model/poli.dart';
import 'pelanggan_update_form.dart';
import 'pelanggan.dart';
import '../service/poli_service.dart';

class PelangganDetail extends StatefulWidget {
  final Poli poli;

  const PelangganDetail({super.key, required this.poli});

  @override
  State<PelangganDetail> createState() => _PelangganDetailState();
}

class _PelangganDetailState extends State<PelangganDetail> {
  Stream<Poli> getData() async* {
    Poli data = await PoliService().getById(widget.poli.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Pelanggan"),
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
                      builder: (context) =>
                          PelangganUpdateForm(poli: snapshot.data)));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Ubah")));
  }

  _tombolHapus() {
    return ElevatedButton(
        onPressed: () {
          AlertDialog alertDialog = AlertDialog(
            content: const Text(
                "Apakah Anda Yakin ingin menghapus data pelanggan ini?"),
            actions: [
              //tombol ya
              StreamBuilder(
                  stream: getData(),
                  builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
                        onPressed: () async {
                          await PoliService()
                              .hapus(snapshot.data)
                              .then((value) {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Pelanggan()));
                          });
                        },
                        child: Text("Ya"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                      )),
              //tombol Batal
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Tidak"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              )
            ],
          );
          showDialog(context: context, builder: (context) => alertDialog);
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text("Hapus"));
  }
}
