import 'package:flutter/material.dart';
import 'src/di.dart' as di;
import 'src/app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}
