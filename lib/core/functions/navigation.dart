import 'package:flutter/material.dart';

pushReplacement(context, Widget newScreen) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => newScreen));
}

push(context, Widget newScreen) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => newScreen));
}
