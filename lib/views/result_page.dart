import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iscanbites/constants/constants.dart' as Constants;
import 'package:iscanbites/widget/pest_list.dart';

class ResultPage extends StatelessWidget {
  final String imagePath;
  final int resultIndex;
  const ResultPage(
      {Key key, @required this.imagePath, @required this.resultIndex})
      : super(key: key);

  Future<Image> _getLocalFile(String filePath) async {
    return Image.file(File(imagePath));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Result'),
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
