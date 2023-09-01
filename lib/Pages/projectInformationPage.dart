import 'package:project_manager/classes.dart';
import 'package:flutter/material.dart';

class ProjectInformationPage extends StatefulWidget {
  Function() closeProject;
  var choosenProject;
  ProjectInformationPage({required this.closeProject, required this.choosenProject, super.key});


  @override
  State<ProjectInformationPage> createState() => _ProjectInformationPageState();
}

class _ProjectInformationPageState extends State<ProjectInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        border: Border.all(
          color: Colors.white!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
                onPressed: () => setState(() {
                      widget.closeProject();
                    }),
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 40,
                ),
                label: Text(
                  'Close Project',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )),
                
            SizedBox(
              height: 50,
            ),
            Expanded(
                child: ListProjectInformation(
              choosenProject: widget.choosenProject,
            )),
          ],
        ),
      ),
    );
  }
}