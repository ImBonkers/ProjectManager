import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Config {
  static Future<Map<String, dynamic>> _loadConfig(String configFile) async {
    final configString = await rootBundle.loadString('config/$configFile');
    return json.decode(configString);
  }

  static Future<Map<String, dynamic>> get generalSettings async {
    return await _loadConfig('general_settings.json');
  }

  static Future<Map<String, dynamic>> get apiSettings async {
    return await _loadConfig('api_settings.json');
  }
}

// child: FutureBuilder(
//   future: getConfig(),
//   builder: (context, snapshot) {
//     if (snapshot.hasData) {
//       print(snapshot.data.toString());
//       return Text(snapshot.data.toString());
//     } else if (snapshot.hasError) {
//       return Text("${snapshot.error}");
//     }
//     return CircularProgressIndicator();
//   }
// )

class ShowCard extends StatefulWidget {

  String Text = "";
  Function() isTappedOn;
  double? elevation = 0;
  double? margin = 0;
  ShowCard({required this.Text, required this.isTappedOn, super.key, this.elevation, this.margin});

  @override
  State<ShowCard> createState() => _ShowCardState();
}

class _ShowCardState extends State<ShowCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: widget.elevation,
      shadowColor: Colors.black,
      color: Colors.white,
      margin: EdgeInsets.all(widget.margin ?? 0),
      child: ListTile(
        onTap: widget.isTappedOn,
        title: Text(widget.Text),
      ),
    );
  }
}


class TextCard extends StatefulWidget {

  String text = "";
  Function() isTappedOn;
  double? elevation = 0;
  double? margin = 0;
  TextCard({required this.text, required this.isTappedOn, super.key, this.elevation, this.margin});

  @override
  State<TextCard> createState() => _TextCardState();
}

class _TextCardState extends State<TextCard> {

  final TextEditingController _controller = TextEditingController();
  String text = widget.text;


  static const paddingSize = 10.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    print('build');



    return Card(
      elevation: widget.elevation,
      shadowColor: Colors.black,
      color: Colors.white,
      margin: EdgeInsets.all(widget.margin ?? 0),

      child: Padding(
        padding: const EdgeInsets.fromLTRB(paddingSize, 0, paddingSize, 0),

        child: TextFormField(
          controller: _controller,

          onChanged: (value) => widget.isTappedOn(),

          // initialValue: widget.Text,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      )
    );
  }
}


class ListProjectInformation extends StatefulWidget {
  var choosenProject = {};
  ListProjectInformation({required this.choosenProject, key});

  @override
  State<ListProjectInformation> createState() => _ListProjectInformationState();
}

class _ListProjectInformationState extends State<ListProjectInformation> {
  var projectVariables = [
    'name',
    'description',
    'version',
    'license',
    'author',
    'path',
  ];

  void changedValues() {
    setState(() {
      print('changed');
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.choosenProject);
    return ListView.builder(
      itemCount: widget.choosenProject.length,
      itemBuilder: (context, index){
        return Center(
          child: Text(
            widget.choosenProject[projectVariables[index]],
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          )
        );
      },
    );
  }
}