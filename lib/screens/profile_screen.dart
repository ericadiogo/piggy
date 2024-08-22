import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'goals_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  final imagePicker = ImagePicker();
  File? imageFile;

  pick(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);
    if(pickedFile != null){
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFA3B2),
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Set Your Profile',
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'Lilita One',
                ),
            ),
            SizedBox(height: 40,),
            Stack(
              children: [
                CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.grey[200],
                  child: CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: imageFile != null? FileImage(imageFile!) : null,
                  ),
                ),
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: IconButton(onPressed: _showOptionsBottomSheet,
                      icon: Icon(
                        Icons.edit_outlined,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40,),
            Text('My Monthly Income',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.fromLTRB(60,5,60,5),
              child:
              TextField(decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 1.0,
                  ),
                ),
                hintText: '\$',
              ),
              ),
            ),
            SizedBox(height: 30,),
            Text('My Monthly Fixed Expenses',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.fromLTRB(60,5,60,5),
              child:
              TextField(decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 1.0,
                  ),
                ),
                hintText: '\$',
              ),
              ),
            ),
            SizedBox(height: 30,),
            Text('Monthly Variable Expenses (Approximately)',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.fromLTRB(60,5,60,5),
              child:
              TextField(decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 1.0,
                  ),
                ),
                hintText: '\$',
              ),
              ),
            ),

            SizedBox(height: 60,),
            ElevatedButton(onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => GoalsScreen(),),);
            },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10),),
                fixedSize: MaterialStateProperty.all<Size>(Size(200.0, 60.0),),
              ),
              child: Text('Finish',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),],
        ),
      ),
    );
  }

  void _showOptionsBottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Center(
                      child: Icon(
                        Icons.image_outlined,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  title: Text('Gallery',),
                  onTap: (){
                    Navigator.of(context).pop();
                    pick(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Center(
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  title: Text('Camera',),
                  onTap: (){
                    Navigator.of(context).pop();
                    pick(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Center(
                      child: Icon(
                        Icons.delete_outlined,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  title: Text('Remove',),
                  onTap: (){
                    Navigator.of(context).pop();
                    setState(() {
                      imageFile = null;
                    });
                  },
                ),
              ],
            ),
          );
        });
  }
}