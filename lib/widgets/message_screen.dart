import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  final String message;
  final Function function;

  const MessageScreen(
      {Key key, @required this.message, @required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _messageStyle = TextStyle(
      fontSize: 18,
      //fontWeight: FontWeight.bold,
      //fontFamily: 'Quicksand',
    );

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset(
                'lib/assets/ic_cloud_search.png',
                color: Colors.white,
                width: 80,
                height: 80,
              ),
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: _messageStyle,
            ),
            FlatButton(
              child: Text(
                'Pesquisar',
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
              onPressed: () {
                function(); //criar Dialog
              },
            )
          ],
        ),
      ),
    );
  }
}
