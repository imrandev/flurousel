import 'package:flurousel/flurousel.dart';
import 'package:flutter/material.dart';

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
      home: MyHomePage(title: 'Flutter Carousel'),
    );
  }
}

class MyHomePage extends StatelessWidget {

  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        child: Flurousel<String>(
          items: List.generate(5, (index) => "https://thumbs.dreamstime.com/b/background-9754303$index.jpg"),
          itemWidgetBuilder: (context, data) {
            return Image.network(
              data,
              fit: BoxFit.cover,
            );
          },
          carouselHeight: 400,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

