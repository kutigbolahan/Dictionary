import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _url = 'https://owlbot.info/api/v4/dictionary/';
  String _token ='28de3a7189c94ff87894254d758196f0e3830a6d';
  TextEditingController _controller;
  StreamController _streamController;
  Stream _stream;

  _search() async {
    if (_controller.text == null || _controller.text.length == 0) {
      _streamController.add(null);
    }
   http.Response response= await http.get(_url, headers: {'Authorization': 'Token ' + _token});
      _streamController.add(jsonDecode(response.body));
  }

  @override
  void initState() {
    _controller = TextEditingController();
    _streamController = StreamController();
    _stream = _streamController.stream;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Center(
            child: Text(
          'Check Favourite Words',
          style: TextStyle(color: Colors.white),
        )),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12, bottom: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18)),
                  child: TextFormField(
                    controller: _controller,
                    onChanged: (String text) {},
                    decoration: InputDecoration(
                        hintText: 'Search for a word',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: const EdgeInsets.only(left: 24),
                        border: InputBorder.none),
                  ),
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () => null)
            ],
          ),
        ),
      ),
      body: StreamBuilder(
        stream: null,
        builder: (context, snapshot) {},
      ),
    );
  }
}
