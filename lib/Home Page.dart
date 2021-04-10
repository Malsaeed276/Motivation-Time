import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:motivstion_sc/main.dart';
import 'package:motivstion_sc/quote_data.dart';
import 'package:share/share.dart';

import 'Menu Page.dart';
import 'Quote.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// call the API and fetch the response
Future<Quote> fetchQuote() async {
  final response = await http.get('https://favqs.com/api/qotd');
  if (response.statusCode == 200) {
    return Quote.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load Quote');
  }
}

class _MyHomePageState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin {


  @override
  bool get wantKeepAlive => true;

  //
  Color favorite = Colors.grey;
  Future<Quote> quote;
  Future<List<Quote>> wholeQuotes;

  String qText;
  String qAuthor;

  //get the quote
  @override
  void initState() {
    super.initState();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    quote = fetchQuote();
  }

  Future<void> addquote() {
    // Call the user's CollectionReference to add a new user

    return MyApp.liked
        .add({
          'quote': qText,
          'Author': qAuthor,
        })
        .then((value) => print("quote Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  //Liked function
  //Todo add the liked quote into the firebase
  void _liked() {

    setState(() {
      if (favorite == Colors.grey) {
        addquote();
        quote = fetchQuote();
      }

    });

    final snackBar = SnackBar(
      content: Text('It has been saved in your list'),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Motivation time"),
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
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MenuPage()),
                    );
                  }),
              Spacer(
                flex: 2,
              ),
              Icon(Icons.home),
              Spacer(
                flex: 4,
              ),
              IconButton(
                icon: Icon(Icons.share),
                color: Colors.grey,
                onPressed: () {
                  print(qText);
                  Share.share('$qText \n\n--$qAuthor');
                },
              ),
              Spacer(
                flex: 5,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              Spacer(
                flex: 3,
              ),
              quoteCard(),
              Spacer(
                flex: 2,
              ),
              ActionCard(),
              Spacer(
                flex: 4,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: _liked,
        tooltip: 'like',
        child: Icon(
          Icons.favorite,
          color: favorite,
        ),
        elevation: 4,
      ),
    );
  }



  Card quoteCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<Quote>(
          future: quote,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              qText = snapshot.data.quoteText;
              qAuthor = snapshot.data.quoteAuthor;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      snapshot.data.quoteText,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontFamily: 'quoteScript'),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '-${snapshot.data.quoteAuthor}',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontFamily: 'quoteScript'),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class ActionCard extends StatefulWidget {
  @override
  _ActionCardState createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'If you want really to change this world you have to talk an action',
            ),
            SizedBox(height: 20,),
            //Todo random ID
            FutureBuilder<DocumentSnapshot>(
              future: MyApp.actionList.doc("C1XvHQ1zvaFFFbqDMj9w").get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data.data();
                  return Text("${data['action']}",);
                }

                return Text("loading");
              },
            ),
          ],
        ),
      ),
    );
  }
}

