import 'package:flutter/material.dart';
import 'package:klinik_app_fauzan/ui/pelanggan_detail.dart';
import '/model/pelanggan.dart';
import 'package:klinik_app_fauzan/ui/pelanggan_form.dart';
import 'package:klinik_app_fauzan/ui/beranda.dart';
import 'package:klinik_app_fauzan/ui/poli_page.dart';
import 'pelanggan_item.dart';
import 'package:klinik_app_fauzan/ui/widget/sidebar.dart';
import '../service/pelanggan_service.dart';

class PelangganPage extends StatefulWidget {
  const PelangganPage({super.key});

  @override
  State<PelangganPage> createState() => _PelangganPageState();
}

class _PelangganPageState extends State<PelangganPage> {
  Stream<List<Pelanggan>> getList() async* {
    List<Pelanggan> data = await PelangganService().listData();
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: const Text("Data Pelanggan"),
        backgroundColor: const Color.fromRGBO(237, 5, 63, 0.612),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Action to be performed when the search icon is pressed
              showSearch(
                context: context,
                delegate: PelangganSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: getList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return const Center(child: Text('Data Kosong'));
          }

          return Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    left: 0,
                    child: IconButton(
                      icon: const Icon(Icons.home),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Beranda(),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    left: 90,
                    child: IconButton(
                      icon: const Icon(Icons.car_rental_rounded),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PoliPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    left: 15,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: const Text(
                        "BERANDA",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 105,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: const Text(
                        "DATA MOBIL",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: const Text(
                        "DAFTAR PELANGGAN",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return PelangganItem(pelanggan: snapshot.data[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PelangganForm()));
        },
        icon: const Icon(Icons.add),
        label: const Text("Tambah Pelanggan"),
        backgroundColor: const Color.fromRGBO(237, 5, 63, 0.612),
      ),
    );
  }
}

class PelangganSearchDelegate extends SearchDelegate {
  List<Pelanggan> pelanggans = [];

  PelangganSearchDelegate() {
    _loadPolies();
  }

  Future<void> _loadPolies() async {
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
        .where((Pelanggan) =>
            Pelanggan.namaPelanggan.toLowerCase().contains(query.toLowerCase()))
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
