import 'package:flutter/material.dart';
import 'package:klinik_app_fauzan/model/poli.dart';
import 'package:klinik_app_fauzan/model/pelanggan.dart';
import 'package:klinik_app_fauzan/ui/pelanggan_page.dart';
import 'package:klinik_app_fauzan/ui/poli_form.dart';
import 'package:klinik_app_fauzan/ui/widget/sidebar.dart';
import 'poli_page.dart';
import 'package:klinik_app_fauzan/ui/pelanggan_detail.dart';
import '../service/poli_service.dart';
import 'poli_detail.dart';
import '../service/pelanggan_service.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  String _selectedSearchType = 'Poli'; // Default search type

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text("Beranda"),
        backgroundColor: const Color.fromRGBO(237, 5, 63, 0.612),
        actions: [
          DropdownButton<String>(
            value: _selectedSearchType,
            onChanged: (String? newValue) {
              setState(() {
                _selectedSearchType = newValue!;
              });
            },
            items: <String>['Poli', 'Pelanggan']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            iconSize: 18.0,
            onPressed: () {
              showSearch(
                context: context,
                delegate: _selectedSearchType == 'Poli'
                    ? PoliSearchDelegate()
                    : PelangganSearchDelegate(),
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
          const SizedBox(height: 5),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(300.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 100.0,
              mainAxisSpacing: 100.0,
            ),
            itemCount: dataMobil.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.red,
                child: InkWell(
                  onTap: () {
                    switch (index) {
                      case 0: // DATA MOBIL
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PoliPage()));
                        break;
                      case 1: // PEGAWAI
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PelangganPage()));
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

class PoliSearchDelegate extends SearchDelegate {
  List<Poli> polies = [];

  PoliSearchDelegate() {
    _loadPolies();
  }

  Future<void> _loadPolies() async {
    polies = await PoliService().listData();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
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
    final results = polies
        .where(
            (poli) => poli.namaPoli.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index].namaPoli),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PoliDetail(poli: results[index]),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = polies
        .where(
            (poli) => poli.namaPoli.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index].namaPoli),
          onTap: () {
            query = suggestions[index].namaPoli;
            showResults(context);
          },
        );
      },
    );
  }
}

class PelangganSearchDelegate extends SearchDelegate {
  List<Pelanggan> pelanggans = [];

  PelangganSearchDelegate() {
    _loadPelanggans();
  }

  Future<void> _loadPelanggans() async {
    pelanggans = await PelangganService().listData();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
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
    final results = pelanggans
        .where((pelanggan) =>
            pelanggan.namaPelanggan.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index].namaPelanggan),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PelangganDetail(pelanggan: results[index]),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = pelanggans
        .where((pelanggan) =>
            pelanggan.namaPelanggan.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index].namaPelanggan),
          onTap: () {
            query = suggestions[index].namaPelanggan;
            showResults(context);
          },
        );
      },
    );
  }
}
