import 'package:flutter/material.dart';
import 'package:klinik_app_fauzan/model/poli.dart';
import 'package:klinik_app_fauzan/ui/pelanggan_page.dart';
import 'package:klinik_app_fauzan/ui/poli_form.dart';
import 'package:klinik_app_fauzan/ui/beranda.dart';
import 'poli_item.dart';
import 'package:klinik_app_fauzan/ui/widget/sidebar.dart';
import '../service/poli_service.dart';
import 'poli_detail.dart';

class PoliPage extends StatefulWidget {
  const PoliPage({super.key});

  @override
  State<PoliPage> createState() => _PoliPageState();
}

class _PoliPageState extends State<PoliPage> {
  Stream<List<Poli>> getList() async* {
    List<Poli> data = await PoliService().listData();
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text("Data Mobil"),
        backgroundColor: const Color.fromRGBO(237, 5, 63, 0.612),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: PoliSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Poli>>(
        stream: getList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
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
                      icon: const Icon(Icons.account_box_sharp),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PelangganPage(),
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
                        "PELANGGAN",
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
                        "SHOWROOM FASTMOBILINDO",
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
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Jumlah kolom dalam grid
                    crossAxisSpacing: 50.0,
                    mainAxisSpacing: 50.0,
                    childAspectRatio:
                        3, // Sesuaikan ini untuk membuat setiap item mengambil lebih banyak ruang vertikal
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return PoliItem(poli: snapshot.data![index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PoliForm()));
        },
        icon: const Icon(Icons.add),
        label: const Text("Tambah Mobil"),
        backgroundColor: const Color.fromRGBO(237, 5, 63, 0.612),
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
