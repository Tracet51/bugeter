import 'package:flutter/material.dart';

class InkWellNavigator extends StatelessWidget {

  InkWellNavigator({@required this.newPage, @required this.child});

  final Widget newPage;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.deepOrange.withAlpha(50),
        child: child,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => newPage));
        });
  }
}
