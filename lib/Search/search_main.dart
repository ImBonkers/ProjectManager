import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ordered_set/ordered_set.dart';

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

class SearchTagBar extends StatefulWidget {
  SearchTagBar({super.key, this.onChanged});

  Function(String, List<String>)? onChanged;

  @override
  State<SearchTagBar> createState() => _SearchTagBarState();
}

class _SearchTagBarState extends State<SearchTagBar> {
  final TextEditingController _controller = TextEditingController();
  TagManager tagManager = TagManager();

  final List<String> tags = [];

  void handleArrowKeyPress(KeyEvent event) {
    if (event is! KeyDownEvent) {
      return;
    }

    if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      if (_controller.text.isEmpty && tags.isNotEmpty) {
        var mostRecentTag = tags.last;

        setState(() {
          tags.remove(tags.last);
          tagManager = TagManager(tags: List.from(tags));
        });

        _controller.text = mostRecentTag;
        _controller.selection =
            TextSelection.collapsed(offset: _controller.text.length);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    tagManager = TagManager(tags: List.from(tags));

    _controller.addListener(() {
      if (_controller.text.isNotEmpty) {
        var lastChar = _controller.text[_controller.text.length - 1];

        if (lastChar == ",") {
          var text = _controller.text.substring(0, _controller.text.length - 1);

          setState(() {
            if (tags.contains(text)) return;
            tags.add(text);
            tagManager = TagManager(tags: List.from(tags));
          });

          _controller.clear();
        }
      }
      if (widget.onChanged != null) {
        widget.onChanged!(_controller.text, tags);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // margin: const EdgeInsets.only(left: 100, right: 100),
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: handleArrowKeyPress,
            child: TextField(
                controller: _controller,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  // label: Text('Search', style: TextStyle(color: Colors.white),),
                  filled: true,
                  hoverColor: Colors.white,
                  iconColor: Colors.red,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50)),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                )),
          ),
        ),
        Container(
            // margin: const EdgeInsets.only(left: 100, right: 100),
            child: tagManager),
      ],
    );
  }
}
