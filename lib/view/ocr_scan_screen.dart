

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scantranslate/api/api.dart';
import 'package:scantranslate/api/api_interface.dart';
import 'package:intl/intl.dart';

class OCRScanScreen extends StatefulWidget{
  File file;
  OCRScanScreen(this.file, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState()  => _OCRScanScreen();

}
class _OCRScanScreen extends State<OCRScanScreen> implements IAPI{
  String transtext = "";
  bool scanText = false;
  API? api;
  @override
  void initState() {
    initTransText();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return WillPopScope(child: Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.indigo,
         elevation: 0,
         actions: [
           transtext.length>0 ?  IconButton(onPressed: (){
             saveData();
           }, icon: Icon(Icons.save_alt)) : Container()
         ],
         leading: IconButton(onPressed: (){
           Navigator.pop(context);
         }, icon: const Icon(Icons.arrow_back)),
       ),
       body:  SingleChildScrollView(
         child: Column(
           children: [
             Container(
               width: double.infinity,
               height: 350,
               child: Image.file(widget.file,),
             ),
             ConstrainedBox(constraints: BoxConstraints(
               minHeight: 350
             ),child: Container(
               width: double.infinity,
               padding: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
               child: Text(transtext,style: GoogleFonts.oswald(
                 fontSize: 18,
                 color: Colors.black
               ),textAlign: TextAlign.justify,),
             ),)

           ],
         ),
       ),
     ), onWillPop: ()async=>false);
  }

  void initTransText() async{
    api = API.init(this);

    final inputImage = await InputImage.fromFile(widget.file);
    final textDetect =  GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textDetect.processImage(inputImage);
    for(var text in recognisedText.blocks){
       transtext += "${text.text}\n";
    }
    setState(() {
      scanText = true;
    });

  }

  void saveData()async{
    DateFormat format = DateFormat("dd/MM/yyyy, HH:mm:ss");
    String dateCreate = format.format(DateTime.now());
    String pathImage = widget.file.path;
    String nameImage = "";
    for(final i in pathImage.split("/")){
       nameImage = i;
    }

     api?.addData(transtext, API.base_Image+nameImage, dateCreate,nameImage,widget.file);

  }

  @override
  void onFail() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Thêm thất bại ! vui lòng kiểm tra internet !")));
  }

  @override
  void onSucess() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Thêm  thành công !")));
    Navigator.pop(context);
  }

}