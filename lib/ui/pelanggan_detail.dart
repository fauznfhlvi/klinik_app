import 'package:flutter/material.dart';
import 'package:klinik_app_fauzan/ui/pelanggan_form.dart';
import 'package:klinik_app_fauzan/model/pelanggan.dart';
import 'pelanggan_update_form.dart';
import '/model/pelanggan.dart';
import '../service/pelanggan_service.dart';

class PelangganDetail extends StatefulWidget {
  final Pelanggan pelanggan;

  const PelangganDetail({super.key, required this.pelanggan});

  @override
  State<PelangganDetail> createState() => _PelangganDetailState();
}

class _PelangganDetailState extends State<PelangganDetail> {
  Stream<Pelanggan> getData() async* {
    Pelanggan data =
        await PelangganService().getById(widget.pelanggan.id.toString());
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
                "Nama Mobil : ${snapshot.data.namaPelanggan}",
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
                          PelangganUpdateForm(pelanggan: snapshot.data)));
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
                          await PelangganService()
                              .hapus(snapshot.data)
                              .then((value) {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PelangganForm()));
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
