import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:scantranslate/app_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scantranslate/view/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.myAppName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyPage()
    );
  }
}
class MyPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => _MyPage();
}
class _MyPage extends State<MyPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            margin: const EdgeInsets.only(top: 100),
            alignment: Alignment.center,
            child: Image.asset("assets/qr-code-scan.png"),
          ),
          Container(
            width: double.infinity,
            height: 50,
            alignment: Alignment.center,
            child: Text(AppConfig.myAppName,style: GoogleFonts.oswald(
              fontWeight: FontWeight.w700,
              fontSize: 32,
              color: Colors.black
            ),),
          )

        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gotoPage();
  }
  void gotoPage(){
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

}
