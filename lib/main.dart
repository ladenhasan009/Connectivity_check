import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription? subscription;
  Future checkConnection() async{
    var connectivityResult= await(Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile){
      Fluttertoast.showToast(msg: "Connected with Mobile Data");
    }
    else if(connectivityResult==ConnectivityResult.wifi){
      Fluttertoast.showToast(msg: "Connected with Wi-Fi");
    }
    else{
      Fluttertoast.showToast(msg: "Network Error");
    }
  }
  @override
  void initState(){
    subscription =Connectivity().onConnectivityChanged.listen((event) {checkConnection();
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connection'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(onPressed: checkConnection, child: Text('Check Connection'),),
          ],
        ),
      ),
    );
  }
}

