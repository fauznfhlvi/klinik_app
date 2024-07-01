import 'package:flutter/material.dart';
import 'package:klinik_app_fauzan/model/poli.dart';
import 'package:klinik_app_fauzan/ui/pelanggan_page.dart';
import 'package:klinik_app_fauzan/ui/poli_form.dart';
import 'package:klinik_app_fauzan/ui/widget/sidebar.dart';
import 'poli_page.dart';

class Beranda extends StatelessWidget {
  const Beranda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text("Beranda"),
        backgroundColor: const Color.fromRGBO(237, 5, 63, 0.612),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            iconSize: 18.0,
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: DataMobilDashboard(),
    );
  }
}

class DataMobilDashboard extends StatelessWidget {
  final List<String> dataMobil = [
    "DATA MOBIL",
    "PEGAWAI",
    "PELANGGAN",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Showroom Fastmobilindo',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/beranda.jpg', // Replace with your image path
            height: 500,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return const Text(
                  'Gagal memuat gambar'); // Error message if the image fails to load
            },
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemCount: dataMobil.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.red,
                child: InkWell(
                  onTap: () {
                    switch (index) {
                      case 0: // DATA MOBIL
                      case 1: // PEGAWAI
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PoliPage()));
                        break;
                      case 2: // PELANGGAN
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PelangganPage()));
                        break;
                      default:
                        break;
                    }
                  },
                  child: Center(
                    child: Text(
                      dataMobil[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String mobil;

  const DetailPage({Key? key, required this.mobil}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mobil),
        backgroundColor: const Color.fromRGBO(237, 5, 63, 0.612),
      ),
      body: Center(
        child: Text(
          'Detail informasi tentang $mobil',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search result for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search suggestion for: $query'),
    );
  }
}
