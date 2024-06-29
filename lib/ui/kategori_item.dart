import 'package:flutter/material.dart';
import 'package:klinik_app_fauzan/model/kategori.dart';
import 'kategori_detail.dart';
//filepoliitem6a

class KategoriItem extends StatelessWidget {
  final Kategori kategori;

  const KategoriItem({super.key, required this.kategori});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          title: Text("${kategori.namaKategori}"),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => KategoriDetail(kategori: kategori)));
      },
    );
  }
}
