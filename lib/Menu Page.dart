import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motivstion_sc/main.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("lists"),
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
                    Navigator.pop(
                      context,
                    );
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
      body: Center(
        child: Column(
          children: [
            Spacer(flex: 4,),
            Card(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton.icon(
                  onPressed: () {
                    print("actions list ");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ActionListBuilder()),
                    );
                  },
                  icon: Icon(Icons.accessibility_new,color: Colors.white),
                  label: Text("Actions List",style: Theme.of(context).textTheme.bodyText2),
                ),
              ),
            ),
            Spacer(flex: 1,),
            Card(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton.icon(
                  onPressed: () {
                    print("liked list ");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LikedListBuilder()),
                    );
                  },
                  icon: Icon(Icons.favorite,color: Colors.red,),
                  label: Text("Liked Quotes List",style: Theme.of(context).textTheme.bodyText2,),
                ),
              ),
            ),
            Spacer(flex: 4,),
          ],
        ),
      ),
    );
  }
}

class ActionListBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Actions List"),
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
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
              ),
              Spacer(
                flex: 2,
              ),
              IconButton(
                  icon: Icon(Icons.home),
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.pop(context, 1);
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
      body: Container(
        //color: Colors.red,
        child: StreamBuilder(
          stream: MyApp.actionList.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            if (!snapshot.hasData) {
              print('test phrase');
              return Center(child: Text("Loading....."));
            }

            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return Card(
                  color: Colors.grey.shade400,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(document.data()['action'],style: Theme.of(context).textTheme.headline6,),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class LikedListBuilder extends StatelessWidget {

  Future<void> deleteQuote(String id) {
    return MyApp.liked
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liked quote list"),
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
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
              ),
              Spacer(
                flex: 2,
              ),
              IconButton(
                  icon: Icon(Icons.home),
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.pop(context, 1);
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
      body: Container(
        //color: Colors.red,
        child: StreamBuilder(
          stream: MyApp.liked.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            if (!snapshot.hasData) {
              print('test phrase');
              return Center(child: Text("Loading....."));
            }

            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return Card(
                  color: Colors.grey.shade400,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(document.data()['Author'],style: Theme.of(context).textTheme.headline5),
                      subtitle: Text(document.data()['quote'],style: Theme.of(context).textTheme.headline6),
                      trailing: IconButton(
                        icon: Icon(Icons.remove,color: Colors.white,),
                        onPressed: (){
                          {
                            deleteQuote(document.id);
                            print("remove");
                          }
                        },
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
