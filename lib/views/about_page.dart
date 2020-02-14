import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(17, 198, 67, 1),
        centerTitle: true,
        title: Text("About"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
          splashColor: Colors.white,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15.0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Project Purpose \n\n     The main purpose of this project is to make an android application that will help the farmers to easily identifies the pest that attacks in the rice fields. In these case the significance of creating Rice Pest - Identification through leaf Aesthetic Analysis towards Sustainable Rice Production application  is to control the farmers to use pesticides which is not good to the crops and to Environment. The following will directly benefit the project: \n\nFarmers. The will be the benifitial of  this applications, it will easy to use by the farmers to diagnosed the pest and control and provide actionable advice to manage their crop. \n\nCommunity. The project will be beneficial to the community to give them awareness if the users wants to learn and diagnosed pest, deases and other problem that can occur in rice. \n\nFuture Researcher. With this Android applications it will  help the farmers to diagnosed the pest that occurs in the leaves and it will lessen the work of the farmers. This Sytem will help the future researcher to focus on study on how to more enhance the system.',
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
