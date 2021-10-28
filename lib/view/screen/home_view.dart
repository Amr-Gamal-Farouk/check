import 'dart:io';

import 'package:check/view/screen/dataView.dart';
import 'package:check/view/screen/team_view.dart';
import 'package:check/view/screen/uploadImageView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

final Reference storageRef = FirebaseStorage.instance.ref();
final dataRef = FirebaseFirestore.instance.collection("Data");
DatabaseReference employeeData =
    FirebaseDatabase.instance.reference().child('employe');
final timesTemp = DateTime.now();

class _HomeViewState extends State<HomeView> {
  late File file;
  List category = [
    {"text": "Add\nRequest", "icon": Icons.add_business},
    {"text": "History", "icon": Icons.history},
    {"text": "Our\nTeam", "icon": Icons.supervised_user_circle_outlined},
  ];

  pageView(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                height: 130,
                width: MediaQuery.of(context).size.width,
                color: Colors.indigo,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Image.asset(
                          "asset/logo.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "GAC",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          " EGYPT",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      "Delivering your strategy",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                      ),
                      Container(),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 157,
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: GridView.builder(
                        itemCount: category.length,
                        // physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: (MediaQuery.of(context).size.width /
                                  MediaQuery.of(context).size.height) +
                              0.3 /*0.8*/,
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 25),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    category[index]["icon"],
                                    color: Colors.indigo,
                                    size: 35,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    category[index]["text"],
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              selectAction(context, index);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }

  void selectAction(BuildContext context, int index) {
    if (index == 0) {
      selectImage(context);
    } else if (index == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DataView(position: "manager"),
          ));
    } else if (index == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TeamView(),
          ));
    }
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text("Create Post"),
            children: [
              SimpleDialogOption(
                child: Text("Photo with camera"),
                onPressed: cameraImageAction,
              ),
              SimpleDialogOption(
                child: Text("Image From Gallery"),
                onPressed: galleryImageAction,
              ),
              SimpleDialogOption(
                child: Text("Cancel"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  cameraImageAction() async {
    Navigator.of(context).pop();

    PickedFile? file = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxHeight: 675,
        maxWidth: 960,
        imageQuality: 85);
    if (file != null) {
      print(file.path);
      setState(() {
        this.file = File(file.path);
      });
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UploadImageView(this.file),
          ));
    }
  }

  galleryImageAction() async {
    Navigator.of(context).pop();

    PickedFile? file = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 675, maxWidth: 960);
    if (file != null) {
      print(file.path);
      setState(() {
        this.file = File(file.path);
      });
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UploadImageView(this.file),
          ));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    print(
        MediaQuery.of(context).size.width / MediaQuery.of(context).size.height);
    return pageView(context);
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
