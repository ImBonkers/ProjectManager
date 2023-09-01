// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:project_manager/classes.dart';
import 'package:project_manager/Search/search_main.dart';
import 'package:project_manager/Pages/projectInformationPage.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var projectsList = [];

  var choosenProject = {};

  double screenPortion = 0.6;

  var _controller = TextEditingController();

  int colorIndex = 100;

  Future<List> getConfig() async {
    WidgetsFlutterBinding.ensureInitialized();
    var projectsJSON = await Config.generalSettings;
    if (mounted) {
      setState(() {
        projectsList = projectsJSON['projects'];
      });
    }
    print(projectsList.toString());
    print(projectsList[1]['name']);
    return projectsList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            color: Colors.grey[colorIndex],
            width: (choosenProject.length == 0
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width * (screenPortion)),
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
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: SearchTagBar(),

                  // child: TextField(
                  //   controller: _controller,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       print('press');
                  //     });
                  //   },
                  //   cursorColor: Colors.black,
                  //   keyboardType: TextInputType.text,
                  //   style: TextStyle(fontSize: 30.0, color: Colors.black),

                  // decoration: InputDecoration(
                  //   prefixIcon: Icon(Icons.search, color: Colors.black),
                  //   // label: Text('Search', style: TextStyle(color: Colors.white),),
                  //   filled: true,
                  //   iconColor: Colors.red,
                  //   fillColor: Colors.white,
                  //   border: OutlineInputBorder(
                  //       borderSide: BorderSide.none,
                  //       borderRadius: BorderRadius.circular(50)),
                  //   hintText: 'Search',
                  //   hintStyle: TextStyle(
                  //     color: Colors.black,
                  //   ),
                  // )
                  // ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: projectsList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 4.0),
                        child: ShowCard(
                          Text: projectsList[index]['name'],
                          isTappedOn: () {
                            setState(() {
                              choosenProject = projectsList[index];
                              print(choosenProject.toString());
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: (choosenProject.length == 0
                ? 0
                : MediaQuery.of(context).size.width * (1 - screenPortion)),
            height: MediaQuery.of(context).size.height,
            color: Colors.grey[colorIndex],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProjectInformationPage(
                choosenProject: choosenProject,
                closeProject: () {
                  setState(() {
                    choosenProject = {};
                  });
                },
              ),
            )
          ),
        ],
      )),
    );
  }
}
