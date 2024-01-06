import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:project_manager/search/search_tag_bar.dart';
import 'package:project_manager/search/search_results.dart';

import 'package:project_manager/choreographer/choreographer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SearchResults searchResults = SearchResults();
  var searchTextController = TextEditingController();
  List<String> searchTags = [];
  double screenPortion = 0.6;
  String searchQuery = "";

  void setSearchQuery(String query, List<String> tags) {
    setState(() {
      searchQuery = query;
      searchResults = SearchResults(data: {
        '[Project ID 1]': {'name': 'Project A'},
        '[Project ID 2]': {'name': 'Project B'},
        '[Project ID 3]': {'name': 'Project C'},
        '[Project ID 4]': {'name': 'Project D'},
        '[Project ID 5]': {'name': 'Project E'},
        '[Project ID 6]': {'name': 'Project F'},
        '[Project ID 7]': {'name': 'Project AA'},
      }, query: query, tags: tags);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Choreographer.register("Test", setSearchQuery);
    return Scaffold(
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            color: Colors.grey[0],
            width: MediaQuery.of(context).size.width * (screenPortion),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Projects',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SearchTagBar(
                    onChanged: setSearchQuery,
                  ),
                ),
                Expanded(child: searchResults)
              ],
            ),
          ),
          Container(),
        ],
      )),
    );
  }
}
