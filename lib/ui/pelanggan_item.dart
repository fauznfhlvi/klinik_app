import 'package:flutter/material.dart';
import 'package:klinik_app_fauzan/model/pelanggan.dart';
import 'pelanggan_detail.dart';
//filepoliitem6a

class PelangganItem extends StatelessWidget {
  final Pelanggan pelanggan;

  const PelangganItem({super.key, required this.pelanggan});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          title: Text("${pelanggan.namaPelanggan}"),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PelangganDetail(pelanggan: pelanggan)));
      },
    );
  }
}
