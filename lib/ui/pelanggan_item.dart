import 'package:flutter/material.dart';
import '../model/poli.dart';
import 'pelanggan_detail.dart';
//filepoliitem6a

class PelangganItem extends StatelessWidget {
  final Poli poli;

  const PelangganItem({super.key, required this.poli});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          title: Text("${poli.namaPoli}"),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PelangganDetail(poli: poli)));
      },
    );
  }
}
