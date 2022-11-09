import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scantranslate/view/ocr_scan_screen.dart';
class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => _HomeScreen();

}
class _HomeScreen extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
     return WillPopScope(child: Scaffold(
       appBar: AppBar(
         backgroundColor:  Colors.indigo,
         elevation: 0,
         leading:  Container(),
         actions: [
           IconButton(onPressed: (){
             showDialogAdd();
           }, icon: Icon(Icons.add))
         ],


       ),
       body:  Column(
         children: [

         ],
       ),
     ), onWillPop: ()async=>false);
  }

  void showDialogAdd() {
     showDialog(context: context, builder: (context){
       return Dialog(
         child:  Container(
           width: 320,
           height: 250,
           child: Column(
             children: [
               Container(
                 width: 220,
                 height: 50,
                 margin: EdgeInsets.only(top: 50),
                 child: ElevatedButton(
                   onPressed: (){
                     showCamera();
                   },
                   style: ElevatedButton.styleFrom(
                     primary: Colors.indigo
                   ),
                   child: Text("Máy Ảnh",style: GoogleFonts.oswald(
                     fontSize: 18,
                     color: Colors.white
                   ),),
                 ),
               ),
               Container(
                 width: 220,
                 height: 50,
                 margin: EdgeInsets.only(top: 30),
                 child: ElevatedButton(
                   onPressed: (){
                     showGallary();
                   },
                   style: ElevatedButton.styleFrom(
                     primary: Colors.indigo
                   ),
                   child: Text("Thư viện",style: GoogleFonts.oswald(
                     fontSize: 18,
                     color: Colors.white
                   ),),
                 ),
               ),

             ],
           ),
         ),
       );
     });
  }

  void showCamera() async{
    var picker = await ImagePicker();
    final image = await  picker.pickImage(source: ImageSource.camera,imageQuality: 99);
    if(image!=null){
      File file = File(image.path);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> OCRScanScreen(file)));
    }

  }
  void showGallary() async{
    var picker = await ImagePicker();
    final image = await  picker.pickImage(source: ImageSource.gallery,imageQuality: 99);
    if(image!=null){
      File file = File(image.path);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> OCRScanScreen(file)));
    }

  }

}