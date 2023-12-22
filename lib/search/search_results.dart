import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

String assignIfContains(Map? data, String key) {
  if (data == null) {
    return "[Missing data]";
  }

  if (data.containsKey(key)) {
    return data[key];
  }

  return "[Missing key]";
}

bool containsString(Map projInfo, String category, String comp) {
  if (projInfo.containsKey(category)) {
    return projInfo[category]!.contains(comp);
  }
  return false;
}

bool containsTags(Map projInfo, String category, List<String> tags) {
  if (projInfo.containsKey(category)) {
    bool invalid = false;
    for (var element in tags) {
      if (projInfo[category]!.contains(element)) {
        invalid = true;
      }
    }
    return invalid;
  }
  return false;
}

Map<String, Map> applySearchQuery(
    Map<String, Map> data, String query, List<String> tags) {
  if (query.isNotEmpty) {
    data.removeWhere((key, value) {
      return !containsString(value.cast(), "name", query);
    });
  }

  if (tags.isNotEmpty) {
    data.removeWhere((key, value) {
      return !containsTags(value.cast(), "tags", tags);
    });
  }

  return data;
}

class SearchResult extends StatefulWidget {
  SearchResult({super.key, this.name, this.onTapped, this.data});

  Map? data;
  String? name;

  Function()? onTapped;

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(widget.name ?? ""),
    );
  }
}

class SearchResults extends StatefulWidget {
  SearchResults(
      {super.key,
      Map<String, Map>? data,
      String query = "",
      List<String> tags = const []}) {
    if (data != null) {
      data = applySearchQuery(data, query, tags);
      data.forEach((key, value) {
        var newValue = value;
        newValue["_keyName"] = key;
        this.data.add(newValue);
      });
    }
  }

  List data = [];

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        var subData = widget.data[index];
        String name = assignIfContains(subData, "name");
        return SearchResult(
          name: name,
          data: {},
        );
      },
    );
  }
}
