
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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

          bottom: TabBar(
            tabs: <Widget>[
              Tooltip(
                message: 'Daily Quotes',
                child: Tab(
                  icon: Icon(
                    Icons.accessibility_new_sharp,
                  ),
                ),
              ),
              Tab(
                icon: Icon(Icons.favorite),
              ),
            ],
          ),
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
                Icon(Icons.menu),
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


        body: TabBarView(
          children: [
            Container(
              //Todo make a list of the actions
              color: Colors.red,
            ),

            Container(
              //Todo make a list of the quotes that has been liked
              color: Colors.yellow,
            ),
          ],
        ),
      ),
    );

  }
}

