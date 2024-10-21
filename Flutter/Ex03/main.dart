import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Cat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
      routes: {
        '/second': (context) => SecondPage(),
      },
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool is_cat = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Page"),
        leading: Icon(Icons.pets),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/second',
                  arguments: is_cat,
                );
              },
              child: Text("Next"),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                print("is_cat: $is_cat");
              },
              child: Image.network(
                'https://cdn.pixabay.com/photo/2024/02/17/00/18/cat-8578562_1280.jpg',
                width: 300,
                height: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool is_cat = ModalRoute.of(context)?.settings.arguments as bool;

    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
      body: Center(
        child: Text(
          is_cat ? "It's a cat!" : "It's not a cat!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
