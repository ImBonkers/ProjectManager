import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as dev;

import 'package:project_manager/settingClasses.dart';

import 'dart:io';
import 'dart:convert';

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

  bool saveConfig(List jsonList)  {
    try{
      Map savingJSON = {};
      savingJSON['projects'] = jsonList;
      String updatedJson = json.encode(savingJSON);
      File('config/general_settings.json').writeAsStringSync(updatedJson);
      return true; 
    }
    catch(e) {
      print(e);
      return false;
    }
    // await rootBundle.loadString('config/general_settings.json');
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
  var choosenProject = {};
  var mapKey = '';
  
  TextCard({
    required this.text, 
    required this.isTappedOn, 
    required this.choosenProject,
    required this.mapKey,
    super.key, 
    this.elevation, 
    this.margin
  });

  @override
  State<TextCard> createState() => _TextCardState();
}

class _TextCardState extends State<TextCard> {

  final TextEditingController _controller = TextEditingController();
  // String text = widget.text;
  String currentText = "";
  var currentChoosenProject = {};
  int samePress = 0;

  static const paddingSize = 10.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    currentChoosenProject = widget.choosenProject;
    currentText = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    if (currentChoosenProject != widget.choosenProject || samePress == 0) {
      currentChoosenProject = widget.choosenProject;
      _controller.text = widget.text;
      samePress = 0;
    }
    if (currentChoosenProject == widget.choosenProject) {
      samePress += 1;
    }


    return Card(
      elevation: widget.elevation,
      shadowColor: Colors.black,
      color: Colors.white,
      margin: EdgeInsets.all(widget.margin ?? 0),

      child: Padding(
        padding: const EdgeInsets.fromLTRB(paddingSize, 0, paddingSize, 0),

        child: TextFormField(
          controller: _controller,
          keyboardType: TextInputType.multiline,
          minLines: 1,//Normal textInputField will be displayed
          maxLines: 10,// when user presses enter it will adapt to it
          

          onChanged: (value) {
            widget.choosenProject[widget.mapKey] = value;
            widget.isTappedOn();
          },

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
  int choosenIndex = -1;
  ListProjectInformation({
    required this.choosenProject,
    required this.choosenIndex,
    super.key
  });

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

  bool isChanged = false;
  bool isSaved = false;
  bool correctSave = false;
  var oldProjectVariables;
  

  void changedValues() {
    setState(() {
      isChanged = true;
      if (isSaved) {
        isSaved = false;
      }
    });
  }
  

  void saveChanges() async{
    dev.log(widget.choosenProject.toString());
    setState(() {
      ProgramSettings.instance.allPerojects[widget.choosenIndex] = widget.choosenProject;
      isSaved = true;
      correctSave = Config().saveConfig(ProgramSettings.instance.allPerojects);
      // correctSave = false;
    });

    dev.log(ProgramSettings.instance.allPerojects.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('init');
  }

  @override
  Widget build(BuildContext context) {

    if (oldProjectVariables != widget.choosenProject) {
      oldProjectVariables = widget.choosenProject;
      isChanged = false;
      isSaved = false;
      correctSave = false;
    }
    


    return SingleChildScrollView(
      child: Column(
        children: [
          isChanged ? SizedBox(
            child: TextButton.icon(
              onPressed: () {
                print('Saving...');
                saveChanges();
              }, 
              icon: Icon(
                isSaved ? (correctSave ? Icons.file_download_done_outlined : Icons.file_download_off_outlined) : Icons.file_download_outlined,
                size: 20,
              ),
              label: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  isSaved ? (correctSave ? 'Changes saved' : 'Error Saving') : 'Save Changes',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  isSaved ? (correctSave ? Colors.green : Colors.red) : Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              
            ),
          ): Container(),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.choosenProject.length,
            itemBuilder: (context, index){
              return TextCard(
                elevation: 2,
                margin: 3,
                choosenProject: widget.choosenProject,
                text: widget.choosenProject[projectVariables[index]],
                mapKey: projectVariables[index],
                isTappedOn: changedValues,
              );
            },
          ),
        ],
      ),
    );
  }
}