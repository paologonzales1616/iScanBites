import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PestPage extends StatelessWidget {
  final String title;
  final String image;
  final String desc;
  const PestPage(
      {Key key,
      @required this.title,
      @required this.image,
      @required this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: Container(
        margin: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/image/$image',
                  width: double.maxFinite,
                ),
              ),
            ),
            SizedBox(),
            Card(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  desc,
                  textAlign: TextAlign.justify,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
