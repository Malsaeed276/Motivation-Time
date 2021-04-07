
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              print("Icon setting is pressed");
            },
          ),
        ],
        title: Text("Actions list"),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              Spacer(
                flex: 5,
              ),
              IconButton(
                  icon: Icon(Icons.menu),
                  color: Colors.black,
                  onPressed: () {
                  }),
              Spacer(
                flex: 2,
              ),
              IconButton(
                  icon: Icon(Icons.home),
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.pop(context,1);
                  }),
              Spacer(
                flex: 4,
              ),
              IconButton(
                  icon: Icon(Icons.share),
                  color: Colors.grey,
                  onPressed: () {}),
              Spacer(
                flex: 5,
              ),
            ],
          ),
        ),
      ),
    );

  }
}

