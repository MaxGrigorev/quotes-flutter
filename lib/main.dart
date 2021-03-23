import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Quotes'),
    );
  }
}

Future<List<Quote>> getQuotes() async {
  http.Response response = await http.get(
      Uri.https("poloniex.com", "/public", {'command': 'returnTicker'}),
      headers: {"Accept": "application/json"});
  var result = json.decode(response.body) as Map<String, dynamic>;
  var quotes = <Quote>[];

  result.forEach((k, v) => quotes.add(Quote(k, v['last'], v['percentChange'])));
  print('result');
  return quotes;
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: getQuotes(),
          builder: (BuildContext context, AsyncSnapshot<List<Quote>> snapshot) {
            print('snapshot $snapshot');
            if (snapshot.hasData) {
              print('snapshot.hasData');
              final List<Quote> data = snapshot.data;
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) =>
                      QuoteWidget(quote: data[index]));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class Quote {
  String pairName;
  String last;
  String percentChange;

  Quote(this.pairName, this.last, this.percentChange);

  @override
  String toString() {
    return '{Quote ${this.pairName}, ${this.last} ${this.percentChange}}';
  }
}

class QuoteWidget extends StatelessWidget {
  QuoteWidget({Key key, @required this.quote}) : super(key: key);
  final Quote quote;

  Function onPress(String name) =>
      (bool pressed) => print('name $name pressed $pressed');

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: ListTile(
          title: Text(quote.pairName,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600)),
          subtitle: Text(
            '${quote.last} ${quote.percentChange}%',
            style: TextStyle(fontSize: 16.0),
          ),
          trailing: StarButton(onPress: onPress(quote.pairName)),
        ));
  }
}

class StarButton extends StatefulWidget {
  StarButton({@required this.onPress});
  final Function onPress;

  @override
  _StarButton createState() => _StarButton();
}

class _StarButton extends State<StarButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.star_border),
        tooltip: 'Add to favorit',
        onPressed: () {
          setState(() {
            pressed = !pressed;
          });
          widget.onPress(pressed);
        },
        iconSize: 30,
        color: pressed ? Colors.yellow : null);
  }
}
