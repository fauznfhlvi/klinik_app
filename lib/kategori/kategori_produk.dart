import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:klinik_app_fauzan/ui/kategori_form.dart';
import '/model/kategori.dart';
import 'package:klinik_app_fauzan/ui/pelanggan_form.dart';
import 'pelanggan_item.dart';
import 'package:klinik_app_fauzan/ui/widget/sidebar.dart';
import '../service/kategori_service.dart';

class KategoriProduk extends StatefulWidget {
  const KategoriProduk({super.key});

  @override
  State<KategoriProduk> createState() => _KategoriprodukState();
}

class _KategoriprodukState extends State<KategoriProduk> {
  Stream<List<Kategori>> getList() async* {
    List<Kategori> data = await KategoriService().listData();
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: const Text("Data Pelanggan"),
        backgroundColor: Color.fromRGBO(237, 5, 63, 0.612),
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
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return const Text('Data Kosong');
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return PelangganItem(pelanggan: snapshot.data[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => KategoriForm()));
        },
        icon: const Icon(Icons.add),
        label: const Text("Tambah Pelanggan"),
        backgroundColor: Color.fromRGBO(237, 5, 63, 0.612),
      ),
    );
  }
}

class PelangganSearchDelegate extends SearchDelegate {
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
    // You can implement search suggestions here if needed
    return Center(
      child: Text('Search suggestion for: $query'),
    );
  }
}
