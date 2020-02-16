import 'dart:io';

import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:iscanbites/helper/database_helper.dart';
import 'package:iscanbites/views/about_page.dart';
import 'package:iscanbites/views/display_page.dart';
import 'package:iscanbites/views/library_page.dart';
import 'package:iscanbites/views/result_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tflite/tflite.dart';
import 'package:uuid/uuid.dart';

import 'gallery_page.dart';

class HomePage extends StatelessWidget {
  Future<List<dynamic>> _classify(String filepath) async {
    await Tflite.loadModel(
      model: "assets/model/model.lite",
      labels: "assets/model/labels.txt",
      numThreads: 2,
    );
    List<dynamic> recognitions = await Tflite.runModelOnImage(
        path: filepath, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 1, // defaults to 5
        threshold: 0.8, // defaults to 0.1
        asynch: true // defaults to true
        );
    Tflite.close();
    print(recognitions);
    return recognitions;
  }

  _insert(String pathImage, String result, int place) async {
    Database db = await DatabaseHelper.instance.database;
    await db.insert(DatabaseHelper.table,
        {"path_image": pathImage, "result": result, "place": place});
  }

  _getCamera(BuildContext context) async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      // getting a directory path for saving
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      String uuid = Uuid().v1();
      await image.copy('${appDocDir.path}/$uuid.png');
      List<dynamic> conditionResult = await _classify(image.path);
      if (conditionResult.isEmpty) {
        await _insert("$uuid.png", "No Result", 4);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
              imagePath: image.path,
              resultIndex: 4,
            ),
          ),
        );
      } else {
        if (conditionResult[0]["confidence"] < .80) {
          await _insert("$uuid.png", "No Result", 4);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ResultPage(imagePath: image.path, resultIndex: 4),
            ),
          );
        } else {
          await _insert("$uuid.png", conditionResult[0]["label"],
              conditionResult[0]["index"]);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(
                  imagePath: image.path,
                  resultIndex: conditionResult[0]["index"]),
            ),
          );
        }
      }
    }
  }

  _getImport(BuildContext context) async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // getting a directory path for saving
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      String uuid = Uuid().v1();
      await image.copy('${appDocDir.path}/$uuid.png');
      List<dynamic> conditionResult = await _classify(image.path);
      if (conditionResult.isEmpty) {
        await _insert("$uuid.png", "No Result", 4);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
              imagePath: image.path,
              resultIndex: 4,
            ),
          ),
        );
      } else {
    if (conditionResult[0]["confidence"] < .80) {
          await _insert("$uuid.png", "No Result", 4);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ResultPage(imagePath: image.path, resultIndex: 4),
            ),
          );
        } else {
          await _insert("$uuid.png", conditionResult[0]["label"],
              conditionResult[0]["index"]);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(
                  imagePath: image.path,
                  resultIndex: conditionResult[0]["index"]),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(17, 198, 67, 1),
      body: Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Image.asset("assets/image/camera_logo.png"),
              onTap: () => _getCamera(context),
            ),
            SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ButtonTheme(
                splashColor: Colors.white,
                buttonColor: Color.fromRGBO(173, 240, 189, 1.0),
                height: 55.0,
                minWidth: double.infinity,
                child: RaisedButton(
                    child: Text(
                      'Import',
                      style: TextStyle(
                        fontFamily: "Times New Roman",
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4.0,
                      ),
                    ),
                    onPressed: () => _getImport(context)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ButtonTheme(
                splashColor: Colors.white,
                buttonColor: Color.fromRGBO(173, 240, 189, 1.0),
                height: 55.0,
                minWidth: double.infinity,
                child: RaisedButton(
                  child: Text(
                    'Gallery',
                    style: TextStyle(
                      fontFamily: "Times New Roman",
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4.0,
                    ),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GalleryPage()),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ButtonTheme(
                splashColor: Colors.white,
                buttonColor: Color.fromRGBO(173, 240, 189, 1.0),
                height: 55.0,
                minWidth: double.infinity,
                child: RaisedButton(
                  child: Text(
                    'Library',
                    style: TextStyle(
                      fontFamily: "Times New Roman",
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4.0,
                    ),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LibraryPage()),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonTheme(
                splashColor: Colors.white,
                buttonColor: Color.fromRGBO(173, 240, 189, 1.0),
                height: 55.0,
                minWidth: double.infinity,
                child: RaisedButton(
                  child: Text(
                    'About',
                    style: TextStyle(
                      fontFamily: "Times New Roman",
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4.0,
                    ),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
