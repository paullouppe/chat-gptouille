import 'package:flutter/material.dart';

class SearchResults extends StatelessWidget {
  final List<dynamic> results;

  const SearchResults({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Results')),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(results[index]['title']), 
          );
        },
      ),
    );
  }
}