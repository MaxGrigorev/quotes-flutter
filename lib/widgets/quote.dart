import 'package:flutter/material.dart';

class QuoteWidget extends StatelessWidget {
  QuoteWidget(
      {Key key,
      @required this.quote,
      @required this.onPress,
      this.favorite = false})
      : super(key: key);
  final Quote quote;
  final Function onPress;
  final bool favorite;
  @override
  Widget build(BuildContext context) {
    print(quote);
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: ListTile(
          title: Text(quote?.pairName,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600)),
          subtitle: Text(
            '${quote?.last} ${quote?.percentChange}%',
            style: TextStyle(fontSize: 16.0),
          ),
          trailing: StarButton(
              pressed: favorite,
              onPress: (bool pressed) {
                onPress(quote?.pairName, pressed);
              }),
        ));
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

class StarButton extends StatelessWidget {
  StarButton({@required this.onPress, this.pressed = false});
  final Function onPress;
  final bool pressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.star_border),
        tooltip: 'Add to favorit',
        onPressed: () {
          onPress(!pressed);
        },
        iconSize: 30,
        color: pressed ? Colors.yellow : null);
  }
}
