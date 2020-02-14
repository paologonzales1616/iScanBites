import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iscanbites/model/pest.dart';
import 'package:iscanbites/views/pest_page.dart';

class PestList extends StatelessWidget {
  final String asset;
  final String title;
  PestList({Key key, @required this.asset, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: FutureBuilder(
        future: _loadPestList(context: context, asset: asset),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView.builder(
            itemCount: snapshot.hasData ? snapshot.data.length : 0,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Card(
                  child: Container(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            snapshot.data[index].name,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    padding: EdgeInsets.all(15.0),
                  ),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PestPage(
                      title: snapshot.data[index].name,
                      image: snapshot.data[index].image,
                      desc: snapshot.data[index].desc,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Pest>> _loadPestList({BuildContext context, String asset}) async {
    List<Pest> pests = [];

    try {
      String data = await DefaultAssetBundle.of(context).loadString(asset);
      var jsondata = json.decode(data);
      for (var x in jsondata) {
        Pest pest = Pest(name: x['name'], image: x['image'], desc: x['desc']);
        pests.add(pest);
      }
    } catch (e) {
      return pests;
    }
    return pests;
  }
}
