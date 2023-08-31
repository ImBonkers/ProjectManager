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
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      children: List.generate(widget.tags.length, (index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.tags[index]),
          ),
        );
      }),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  TagManager tagManager = TagManager();

  final Set<String> tags = {
    "asd",
    "asd",
    "asd",
    "asd",
    "asd",
    "asd",
    "asd",
  };

  @override
  void initState() {
    super.initState();

    tagManager = TagManager(tags: List.from(tags));

    _controller.addListener(() {
      if (_controller.text.length == 0) return;
      var last_char = _controller.text[_controller.text.length - 1];

      if (last_char == ",") {
        var text = _controller.text.substring(0, _controller.text.length - 1);

        setState(() {
          tags.add(text);
          tagManager = TagManager(tags: List.from(tags));
        });

        dev.log("Tag: $text");
        // dev.log("Tags: $tags");

        _controller.clear();
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 100, right: 100),
            child: TextField(
              controller: _controller,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.black),
                // label: Text('Search', style: TextStyle(color: Colors.white),),
                filled: true,
                hoverColor: Colors.white,
                iconColor: Colors.red,
                fillColor: Colors.white ,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50)),
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
              )
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 100, right: 100),
              child: tagManager),
        ],
    );
  }
}
