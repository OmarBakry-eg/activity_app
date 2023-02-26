
import 'package:flutter/material.dart';

extension Updates on Widget {
  GestureDetector removeFocus(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: this,
    );
  }
}