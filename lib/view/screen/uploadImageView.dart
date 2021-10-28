import 'dart:io';

import 'package:check/view/screen/home_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as Im;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../MyConnectivity.dart';
import '../../dialogs.dart';

class UploadImageView extends StatefulWidget {
  late File file;
  UploadImageView(this.file);
  @override
  _UploadImageViewState createState() => _UploadImageViewState(this.file);
}

Container linearProgress(context) {
  return Container(
    padding: EdgeInsets.only(bottom: 10.0),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.pink),
    ),
  );
}

class _UploadImageViewState extends State<UploadImageView> {
  late File file;
  bool isUploading = false;
  String postId = Uuid().v4();
  late String downloadUrl;
  TextEditingController infoCont = TextEditingController();

  List loginOption = ["as Employee", "as Manager"];
  _UploadImageViewState(this.file);

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image? imageFile = Im.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File("$path/img_$postId.jpg")
      ..writeAsBytesSync(Im.encodeJpg(imageFile!, quality: 85));

    setState(() {
      this.file = compressedImageFile;
    });
  }

  Future<String> uploadImage(imageFile) async {
    TaskSnapshot uploadTask =
        await storageRef.child("post_$postId.jpg").putFile(imageFile);
    return uploadTask.ref.getDownloadURL();
  }

  createPost(
    String mediaUrl,
    String title,
  ) async {
    dataRef.doc(postId).set({
      "postId": postId,
      "mediaUrl": mediaUrl,
      "title": title,
      "employee": "waiting",
      "manager": "waiting",
      "timesTemp": timesTemp
    });
  }

  postAction() async {
    setState(() {
      isUploading = true;
    });
//    compress Image
    await compressImage();
//    upload image
    String downloadUrl = await uploadImage(file);
//    create post on firestore
    await createPost(downloadUrl, infoCont.text);
//    clear
    infoCont.clear();
    setState(() {
      isUploading = false;
      file = File("");
      postId = Uuid().v4();
    });
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  uploadImageScreen() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Upload",
            style: TextStyle(),
          ),
        ),
      ),
      body: ListView(
        children: [
          isUploading ? linearProgress(context) : Container(),
          Container(
            height: 220,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
//                      fit: BoxFit.cover,
                      image: FileImage(
                        file,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.info_outline_rounded,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            title: Container(
              width: 250,
              child: TextField(
                controller: infoCont,
                decoration: InputDecoration(
                  hintText: "title",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: isUploading ? null : () => postAction(),
              child: Text(
                "Upload",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      MyConnectivity.instance.initialise();
      MyConnectivity.instance.myStream.listen((onData) {
        if (MyConnectivity.instance.isIssue(onData)) {
          if (MyConnectivity.instance.isShow == false) {
            MyConnectivity.instance.isShow = true;
            showDialogNotInternet(context).then((onValue) {
              MyConnectivity.instance.isShow = false;
            });
          }
        } else {
          if (MyConnectivity.instance.isShow == true) {
            Navigator.of(context).pop();
            MyConnectivity.instance.isShow = false;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return uploadImageScreen();
  }
}
