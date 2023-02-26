import 'package:flutter/material.dart';

class NoActivityWidget extends StatelessWidget {
  final String? title;
  const NoActivityWidget({Key? key,this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? "No Activities for now\nTry adding one!",
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 15,
        color: Color(0xff172735),
        letterSpacing: 0.42,
      ),
    );
  }
}
