import 'package:flutter/material.dart';
import '/model/pelanggan.dart';
import 'package:klinik_app_fauzan/ui/pelanggan_form.dart';
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
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Daftar Pelanggan",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                  textAlign: TextAlign.center,
                ),
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
