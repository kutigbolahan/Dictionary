import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Center(
            child: Text(
          'Check Favourite Words',
          style: TextStyle(color: Colors.black),
        )),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  onChanged: (String text){

                  },
                  decoration: InputDecoration(
                    hintText: 'Search for a word'
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
