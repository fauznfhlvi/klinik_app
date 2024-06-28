import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:klinik_app_fauzan/model/poli.dart';
import 'package:klinik_app_fauzan/ui/poli_form.dart';
import 'poli_item.dart';
import 'package:klinik_app_fauzan/ui/widget/sidebar.dart';
import '../service/poli_service.dart';

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
      drawer: Sidebar(),
      appBar: AppBar(
        title: const Text("Data Mobil"),
        backgroundColor: Color.fromRGBO(237, 5, 63, 0.612),
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

          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "SHOWROOM FASTMOBILINDO",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Number of columns in the grid
                    crossAxisSpacing: 50.0,
                    mainAxisSpacing: 50.0,
                    childAspectRatio:
                        3, // Adjust this to make each item take up more vertical space
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return PoliItem(poli: snapshot.data[index]);
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
        backgroundColor: Color.fromRGBO(237, 5, 63, 0.612),
      ),
    );
  }
}

class PoliSearchDelegate extends SearchDelegate {
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
