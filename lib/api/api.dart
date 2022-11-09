

import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'api_interface.dart';
import 'package:http/http.dart' as http;

class API{
  static String base_url = "http://hitechbike.online/";
  static String base_Image = "http://hitechbike.online/hinhanh/";
  IAPI? callback;
  API.init(IAPI iapi){
    this.callback = iapi;
  }
  Future<void> addData(String description,String url,String dateCreate,String nameImage,File file)async{
    Map<String,dynamic> map = HashMap();

    map.putIfAbsent("NAME", () => description);
    map.putIfAbsent("URL", () => url);
    map.putIfAbsent("DATECREATE", () => dateCreate);
    List<int> imageBytes = file.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    print(base64Image);
    Map<String,String> mapURL = HashMap();
    mapURL.putIfAbsent("image", () => base64Image);
    mapURL.putIfAbsent("image_name", () => nameImage);

    final responsiveImage = await http.post(Uri.parse(base_Image+"upload.php"),body: mapURL);
    final responsive = await http.post(Uri.parse(base_url+"addData.php"),body: map);
    String status = responsive.body;
     if(status == "OK"){
       callback?.onSucess();
     }else{
       callback?.onFail();
     }

  }


}