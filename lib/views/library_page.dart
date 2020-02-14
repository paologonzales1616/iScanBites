import 'package:flutter/material.dart';
import 'package:iscanbites/widget/pest_list.dart';

class LibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(17, 198, 67, 1),
        centerTitle: true,
        title: Text("Library"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            GestureDetector(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Early Vegetative Pests',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PestList(
                    title: 'Early Vegetative Pests',
                    asset: 'assets/data/early_vegetative_pests.json',
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'General Defoliators',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PestList(
                    title: 'General Defoliators',
                    asset: 'assets/data/general_defoliators.json',
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Stem Borers',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PestList(
                    title: 'Stem Borers',
                    asset: 'assets/data/stem_borers.json',
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Plant-Sucking Pests',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PestList(
                    title: 'Plant-Sucking Pests',
                    asset: 'assets/data/plant_sucking_pest.json',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
