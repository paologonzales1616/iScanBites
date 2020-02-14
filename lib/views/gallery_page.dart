import 'dart:io';
import 'package:iscanbites/constants/constants.dart' as Constants;

import 'package:flutter/material.dart';
import 'package:iscanbites/data/gallery_data.dart';
import 'package:iscanbites/helper/database_helper.dart';
import 'package:iscanbites/views/display_page.dart';
import 'package:iscanbites/views/home_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqlite_api.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<Gallery> galleryList;
  String appDocDir;

  Future<void> _getGalleryList() async {
    Database db = await DatabaseHelper.instance.database;
    var jsondata = await db.query(DatabaseHelper.table);
    List<Gallery> temps = [];

    for (var x in jsondata) {
      print(x);
      Gallery temp = Gallery(x["id"], x["place"], x["path_image"], x["result"]);
      temps.add(temp);
    }
    if (mounted) {
      setState(() {
        galleryList = temps.reversed.toList();
      });
    }
  }

  Future<void> _returnImage() async {
    Directory temp = await getApplicationDocumentsDirectory();
    setState(() {
      appDocDir = temp.path;
    });
  }

  @override
  void initState() {
    _returnImage();
    _getGalleryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromRGBO(17, 198, 67, 1),
          centerTitle: true,
          title: Text("Gallery"),
          leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            ),
          ),
        ),
        body: Container(
          child: galleryList == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  itemCount: galleryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: RotatedBox(
                            quarterTurns: 5,
                            child: Image.file(
                              File(
                                  '$appDocDir/${galleryList[index].pathImage}'),
                            ),
                          ),
                          title: Text(
                              Constants.COMPARE_NAME[galleryList[index].place]),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DisplayPage(
                                imagePath:
                                    '$appDocDir/${galleryList[index].pathImage}',
                                resultIndex: galleryList[index].place,
                                id: galleryList[index].id,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
