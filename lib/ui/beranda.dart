import 'package:flutter/material.dart';
import 'package:klinik_app_fauzan/ui/widget/sidebar.dart';

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
      body: Center(
        child: Text("Selamat Datang di beranda"),
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
