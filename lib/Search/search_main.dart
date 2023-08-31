import 'dart:developer' as dev;
import 'package:flutter/material.dart';

class TagManager extends StatefulWidget {
  TagManager({super.key, this.tags = const []});
  List<String> tags;

  @override
  State<TagManager> createState() => _TagManagerState();
}

class _TagManagerState extends State<TagManager> {
  @override
  Widget build(BuildContext context) {
    var tags = List.from(Set.from(widget.tags));
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      children: List.generate(tags.length, (index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(tags[index]),
          ),
        );
      }),
    );
  }
}

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();
  TagManager tagManager = TagManager();

  final List<String> tags = [
    "asd",
    "asd",
    "asd",
    "asd",
    "asd",
    "asd",
    "asd",
  ];

  @override
  void initState() {
    super.initState();

    tagManager = TagManager(tags: tags);

    _controller.addListener(() {
      if (_controller.text.length == 0) return;
      var last_char = _controller.text[_controller.text.length - 1];

      if (last_char == ",") {
        var text = _controller.text.substring(0, _controller.text.length - 1);

        setState(() {
          tags.add(text);
          tagManager = TagManager(tags: tags);
        });

        dev.log("Tag: $text");
        // dev.log("Tags: $tags");

        _controller.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 100, right: 100),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 100, right: 100),
              child: tagManager),
        ],
      ),
    );
  }
}
