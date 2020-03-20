import 'package:flutter/material.dart';

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
                    borderRadius: BorderRadius.circular(18)
                  ),
                  child: TextFormField(
                    controller: _controller,
                    onChanged: (String text) {},
                    decoration: InputDecoration(
                   
                        hintText: 'Search for a word',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: const EdgeInsets.only(left:24),
                        border: InputBorder.none
                        ),
                  ),
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: ()=>null
                    
                  
                  )
            ],
          ),
        ),
      ),
    );
  }
}
