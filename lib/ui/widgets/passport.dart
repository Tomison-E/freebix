import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freebix/core/repositories/user.dart';
import 'package:freebix/core/services/api_result.dart';
import 'package:freebix/ui/screens/profile.dart';
import 'package:freebix/utils/colors.dart';
import 'package:freebix/utils/theme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:freebix/utils/uiData.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Passport extends StatefulWidget {
  final email;
  Passport({this.email = "unkwnown"});

  @override
  State<StatefulWidget> createState() {
    return _PassportState();
  }
}

class _PassportState extends State<Passport>{

  final loading = false;
  File file;

  firebase_storage.UploadTask uploadFile(File file) {
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No file was selected")));
      return null;
    }
    String doc = context.read(docID).data.value;

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('passport')
        .child('/${doc}.png');

    return ref.putFile(file);
  }

  Future<ApiResult<bool>> upgrade(){
    String doc = context.read(docID).data.value;
    return context.read(userRepositoryProvider).updateLevel(doc, {
      'level' : 2,
      'stage' : 3
    });
  }

  void upload() async{
    if(file!= null) {
      bool val;
      try {
        final value = uploadFile(file);
        val = value!= null ? true: false;
        if(val){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Upload Successful")));
          final update = await upgrade();
          update.maybeWhen(
              success: (bool data) {
                //context.read(userRepositoryProvider).refresh();
               Navigator.pop(context, true);
               // Navigator.of(context)
               //     .pushNamedAndRemoveUntil(UIData.homeRoute, (Route<dynamic> route) => false);
              },
              orElse: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Upload Successful"))));
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Unable to upload file")));
        }
      }
      catch(e){
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Unable Error")));
      }
    }
  }

  void getFile() async{
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png']);
    if (result != null) {
      file = File(result.files.single.path);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        appBar: AppBar(elevation: 0.0, backgroundColor: Colors.transparent,automaticallyImplyLeading: true,iconTheme: IconThemeData(color: Colors.black),),
        body: SingleChildScrollView(
            child:Padding(
                padding: EdgeInsets.all(30),
                child:Column(
                  children: [
                    Text("Passport Verification",style: TextStyle(color: Colours.navBarText,fontSize: 18,fontWeight: FontWeight.bold)),
                    const SizedBox(height:20),
                    Text("Upload Passport and proof of address to continue", style: Style.regText),
                    const SizedBox(height:35),
                    DottedBorder(
                      dashPattern: [4, 4],
                      strokeWidth: 1,
                      color: Colors.grey,
                      child: Container(
                        child: Column(
                          children: [
                            Expanded(
                              child:Column(
                        children: [
                          GestureDetector(
                            child:Icon(Icons.photo,color: Colours.regText,size:100),onTap:()=>getFile()),
                          const SizedBox(height:20),
                        FlatButton(
                            onPressed: file == null ?()=>getFile():null, child:Text(file == null ?"Click to upload passport":file.absolute.path, style:Style.regText)),
                            ],mainAxisAlignment: MainAxisAlignment.center)),
                            const SizedBox(height:20),
                            Divider(),
                            const SizedBox(height:20),
                            Expanded(
                                child:Column(
                                    children: [
                                      Icon(Icons.cloud_upload,color: Colours.regText,size:100),
                                      const SizedBox(height:20),
                                      Text("Click to upload utility bill", style:Style.regText),
                                    ],mainAxisAlignment: MainAxisAlignment.center,))
                          ]
                        ),
                        height: 600,
                      ),
                    ),
                    const SizedBox(height:35),
                    SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: RaisedButton(onPressed: ()=> upload(),
                          child: loading ? CupertinoActivityIndicator() : Text("Confirm", style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.0)),
                          color: Color.fromRGBO(87, 165, 244, 1.0),
                          highlightColor: Colors.white,
                          hoverColor: Colors.black,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.only(left: 60.0, right: 60.0),)
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                )))
    );
  }



}

