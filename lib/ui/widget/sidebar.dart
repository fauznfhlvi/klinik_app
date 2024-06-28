import 'package:flutter/material.dart';
import 'package:klinik_app_fauzan/ui/mobil.dart';
import 'package:klinik_app_fauzan/ui/pelanggan.dart';
import '/ui/beranda.dart';
import '/ui/login.dart';
import '/ui/poli_page.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text("Admin"),
              accountEmail: Text("admin@admin.com")),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Beranda"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Beranda()));
            },
          ),
          ListTile(
            leading: Icon(Icons.car_rental_rounded),
            title: Text("Data Mobil"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => PoliPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.people_alt_rounded),
            title: Text("Pegawai"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.account_box_sharp),
            title: Text("Pelanggan"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Pelanggan()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_rounded),
            title: Text("Keluar"),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  (Route<dynamic> route) => false);
            },
          )
        ],
      ),
    );
  }
}
