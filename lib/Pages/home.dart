

// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:project_manager/classes.dart';
import 'package:project_manager/classes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var projectsList = [];

  double screenPortion = 0.6;

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
        child : Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
              
            Container(

              child: ListView.builder(
                shrinkWrap: true,
                itemCount: projectsList.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                    child: ProjectCard(
                      projectName: projectsList[index]['name'], 
                      isTappedOn: () {
                        print('ÖÖÖÖ');
                      },
                    ),
                  );
                },
              ),

              color: Colors.grey,
              width: MediaQuery.of(context).size.width*screenPortion,
              height: MediaQuery.of(context).size.height,
            ),

            Container(
              color: Colors.blue,
              width: MediaQuery.of(context).size.width*(1-screenPortion),
              height: MediaQuery.of(context).size.height,
            ),
          ],
        )

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
        
      ),
    );
  }
}