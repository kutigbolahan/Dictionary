import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  Timer _debounce;

  _search() async {
    if (_controller.text == null || _controller.text.length == 0) {
      _streamController.add(null);
      return;
    }
    _streamController.add('waiting');
   Response response= await http.get(_url + _controller.text.trim(), headers: {'Authorization': 'Token ' + _token});
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
          'Search Favourite Words',
          style: TextStyle(color: Colors.white),
        )),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12, bottom: 8,right: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18)),
                  child: TextFormField(
                    controller: _controller,
                    onChanged: (String text) {
                      if (_debounce?.isActive ?? false) _debounce.cancel();
                      _debounce = Timer(const Duration(milliseconds: 1000), (){
                        _search();
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'Search for a word',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: const EdgeInsets.only(left: 24,right: 24),
                        border: InputBorder.none),
                  ),
                ),
              ),
              // IconButton(
              //     icon: Icon(
              //       Icons.search,
              //       color: Colors.white,
              //     ),
              //     onPressed: () => _search())
            ],
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Text('Enter a search word'),
              );
            }
            if (snapshot.data == 'waiting') {
              return Center(
                child: SpinKitFoldingCube(
          color: Colors.black,
          size: 100,
        ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data['definitions'].length,
              itemBuilder: (context , int index){
                  return ListBody(
                    children: <Widget>[
                      Container(
                        color: Colors.grey[300],
                        child: ListTile(
                   leading:snapshot.data['definitions'][index]['image_url']==null? null: CircleAvatar(
                     backgroundImage: NetworkImage(snapshot.data['definitions'][index]['image_url']),
                   ),
                   title: Text(_controller.text.trim() + '(' + snapshot.data['definitions'][index]['type']+ ')')

                   
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(snapshot.data['definitions'][index]['definition']),
                      )
                    ],
                  );
              }
            );
          },
        ),
      ),
    );
  }
}
