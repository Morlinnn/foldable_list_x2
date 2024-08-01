import 'package:flutter/material.dart';

import 'example1.dart';
import 'example2.dart';
import 'example3.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) {
                            return Example1();
                          }
                      )
                  );
                },
                child: Text("Example1: Create a empty TileListView and add Item.")
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) {
                            return Example2();
                          }
                      )
                  );
                },
                child: Text("Example2: Create a TileListView by TileListViewBuilder.loadFromMapOrIterable loaded with data.")
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) {
                            return Example3();
                          }
                      )
                  );
                },
                child: Text("Example2: Create a TileListView by TileListViewBuilder.loadManually loaded with data.")
            )
          ],
        )
      ),
    );
  }
}