import 'package:flutter/material.dart';
import 'package:movie_app/pages/home_page.dart';
import 'network/dataagents/retrofit_data_agent_impl.dart';

void main() {
  RetrofitDataAgentImpl().getNowPlayingMovie(1);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}


