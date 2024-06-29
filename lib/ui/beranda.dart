import 'package:flutter/material.dart';
import 'package:klinik_app_fauzan/model/poli.dart';
import 'package:klinik_app_fauzan/ui/pelanggan_page.dart';
import 'package:klinik_app_fauzan/ui/poli_form.dart';
import 'package:klinik_app_fauzan/ui/widget/sidebar.dart';
import 'poli_page.dart';

// file beranda9b
class Beranda extends StatelessWidget {
  const Beranda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: Text("Beranda"),
        backgroundColor: Color.fromRGBO(237, 5, 63, 0.612),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 18.0, // Set the icon size
            onPressed: () {
              // Action to be performed when the search icon is pressed
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
          SizedBox(height: 20),
          Text(
            'Showroom Fastmobilindo',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Image.network(
            'https://www.canva.com/design/DAGE2c5i0Wc/XgEMiZjBzPwGf8kd7Y5QTA/edit?utm_content=DAGE2c5i0Wc&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton', // Ganti URL ini dengan URL gambar mobil Anda
            height: 200,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Text(
                  'Gagal memuat gambar'); // Pesan error jika gambar gagal dimuat
            },
          ),
          SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(100.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of columns
              crossAxisSpacing: 100.0,
              mainAxisSpacing: 100.0,
            ),
            itemCount: dataMobil.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.red,
                child: InkWell(
                  onTap: () {
                    // Action to be performed when the card is tapped
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
                      style: TextStyle(color: Colors.black),
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
        backgroundColor: Color.fromRGBO(237, 5, 63, 0.612),
      ),
      body: Center(
        child: Text(
          'Detail informasi tentang $mobil',
          style: TextStyle(fontSize: 18),
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
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
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
    // Implement search suggestions here if needed
    return Center(
      child: Text('Search suggestion for: $query'),
    );
  }
}
