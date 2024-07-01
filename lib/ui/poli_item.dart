import 'package:flutter/material.dart';
import '../model/poli.dart';
import 'poli_detail.dart';

class PoliItem extends StatelessWidget {
  final Poli poli;

  const PoliItem({Key? key, required this.poli}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PoliDetail(poli: poli)),
        );
      },
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.directions_car), // Icon representing a car
          title: Text(poli.namaPoli),
        ),
      ),
    );
  }
}
