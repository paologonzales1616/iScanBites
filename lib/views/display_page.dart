import 'dart:io';

import 'package:iscanbites/constants/constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iscanbites/helper/database_helper.dart';
import 'package:iscanbites/views/gallery_page.dart';
import 'package:iscanbites/widget/pest_list.dart';
import 'package:sqflite/sqlite_api.dart';

class DisplayPage extends StatelessWidget {
  final String imagePath;
  final int resultIndex;
  final int id;
  const DisplayPage(
      {Key key, @required this.imagePath, @required this.resultIndex, @required this.id})
      : super(key: key);

  Future<Image> _getLocalFile(String filePath) async {
    return Image.file(File(imagePath));
  }

  void _delete(BuildContext context) async {
    Database db = await DatabaseHelper.instance.database;
    await db
        .delete(DatabaseHelper.table, where: "id = ?", whereArgs: [id]);
    await File(imagePath).delete().then(
      (onValue) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GalleryPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Result'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () => _delete(context),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FutureBuilder(
                    future: _getLocalFile("flutter_assets/image.png"),
                    builder:
                        (BuildContext context, AsyncSnapshot<Image> snapshot) {
                      return snapshot.data != null
                          ? snapshot.data
                          : Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                    },
                  ),
                ),
              ),
              resultIndex < 4
                  ? Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              Constants.COMPARE_NAME[resultIndex],
                              style: TextStyle(fontSize: 18.0),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PestList(
                                    title: Constants.COMPARE_NAME[resultIndex],
                                    asset: Constants.ASSET_LIST[resultIndex],
                                  ),
                                ),
                              ),
                              child: Text(
                                "Read More",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "No Result",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
