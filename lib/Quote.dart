import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';


class Quote {
  int quoteId;
  String quoteText;
  String quoteAuthor;
  Quote({this.quoteId, this.quoteText, this.quoteAuthor});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      quoteText: json['quote']['body'],
      quoteAuthor: json['quote']['author'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': quoteId,
      'quote_text': quoteText,
      'quote_author': quoteAuthor,
    };
  }

  Quote.fromMap(Map<String, dynamic> map) {
    quoteId = map['id'];
    quoteText = map['quote_text'];
    quoteAuthor = map['quote_author'];
  }

  Future<Quote> getQuoteData() async {
    final response = await http.get('https://favqs.com/api/qotd');
    if (response.statusCode == 200) {
      return Quote.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Quote');
    }
  }
}


