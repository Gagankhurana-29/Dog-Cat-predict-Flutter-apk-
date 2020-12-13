import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   @override
   void initState()
   {
     super.initState();
     loadModel().then((value)
     {
       setState(() {
       });
     });
   }
  bool _loading=true;
  File _image;
  List _output;
  final picker = ImagePicker();

  classifyImage(File image) async
  {
    var output=await Tflite.runModelOnImage(
        path: image.path
        ,numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _output=output;
      _loading=false;
    });
  }
  loadModel()async
  {
    await Tflite.loadModel(model: 'assets/model_unquant.tflite', labels: "assets/labels.txt");
  }
  pickCamImage()async
  {
    var image=await picker.getImage(source:ImageSource.camera);
    if (image==null)
      {
        return null;
      }
    setState(() {
      _image=File(image.path);
      classifyImage(_image);
    });
  }
   pickGallImage()async
   {
     var image=await picker.getImage(source:ImageSource.gallery);
     if (image==null)
     {
       return null;
     }
     setState(() {
       _image=File(image.path);
       classifyImage(_image);
     });
   }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Tflite.close();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 60.0,width: 50.0),
          Text(
            "Dog and Cat Predictable Machine",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
               fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height:30.0),
          Center(
            child: _loading? Container(
              width: 270,
              child: Image.asset("assets/dc.jpg"),
            ):Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 250,
                    child: Image.file(_image),
                  ),
                  _output!=null? Text('${_output[0]['label']}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0
                  ),
                  ):
                  Container()
                ],
                  ),
            ), 
            ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                SizedBox(height: 30.0,),
                GestureDetector(
                  onTap: pickGallImage,
                  child: Container(
                    width: MediaQuery.of(context).size.width-220,
                    alignment:Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 24.0,
                    vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Text(
                      "Gallery",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0
                      ),
                    ),
                  ),
                )
              ],
            )
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30.0,),
                  GestureDetector(
                    onTap: pickCamImage,
                    child: Container(
                      width: MediaQuery.of(context).size.width-220,
                      alignment:Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 24.0,
                          vertical: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: Text(
                        "Camera Roll",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0
                        ),
                      ),
                    ),
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}
