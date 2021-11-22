import 'package:flutter/material.dart';
class GecisliRenkContainer extends StatelessWidget {
  final Widget child;
  final MaterialColor renk;

  GecisliRenkContainer({@required this.child, @required this.renk});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [renk[700], renk[500], renk[200]],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.33,0.66,1]
        )
      ),
    );
  }
}
