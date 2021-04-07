/*
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './Quote.dart';


class QuoteData extends StatefulWidget {
  @override
  _QuoteDataState createState() => _QuoteDataState();
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

class _QuoteDataState extends State<QuoteData>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<Quote> quote;
  Future<List<Quote>> wholeQuotes;
  @override
  void initState() {
    super.initState();
    quote = fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return  Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder<Quote>(
            future: quote,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
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
*/
