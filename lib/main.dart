import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'secrets.dart' as sec;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mysql test Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future _connect() {
    var settings = new ConnectionSettings(
      host: sec.host, 
      port: 22,
      user: sec.user,
      password: sec.pass,
      db: sec.db
    );
    return MySqlConnection.connect(settings);
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("connection status"),
            FutureBuilder(
              future: _connect(),
              builder:(BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  return Text('connected');
                }else if(snapshot.hasError){
                  print(snapshot.error);
                  return Text('error');                
                } else{
                  return Text('waiting');
                }
              }

            ),
          ],
        ),
      ),
    );
  }
}
