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

class ProjectCard extends StatefulWidget {
  String projectName = "";
  Function() isTappedOn;
  ProjectCard({required this.projectName, required this.isTappedOn, super.key});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: ListTile(
        onTap: widget.isTappedOn,
        title: Text(widget.projectName),
      ),
    );
  }
}

class ProjectInformation extends StatefulWidget {
  var choosenProject = {};
  ProjectInformation({required this.choosenProject, key});

  @override
  State<ProjectInformation> createState() => _ProjectInformationState();
}

class _ProjectInformationState extends State<ProjectInformation> {
  var projectVariables = [
    'name',
    'description',
    'version',
    'license',
    'author',
    'path',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.choosenProject.length,
      itemBuilder: (context, index) {
        return Center(
            child: Text(
          widget.choosenProject[projectVariables[index]],
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ));
      },
    );
  }
}
