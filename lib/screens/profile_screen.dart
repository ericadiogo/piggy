import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart'; // Import for Firebase Realtime Database
import '../services/firebase_auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'home_screen.dart';
import 'launcher_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final imagePicker = ImagePicker();
  File? imageFile;
  final user = FirebaseAuth.instance.currentUser;
  String _nameHint = '';
  String _incomeHint = '';
  String _expensesHint = '';

  // Controllers for TextFields
  final _nameController = TextEditingController();
  final _incomeController = TextEditingController();
  final _expensesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (user != null) {
      final DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('users/${user!.uid}');
      final snapshot = await dbRef.once();

      if (snapshot.snapshot.value != null) {
        final userData = snapshot.snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          _nameHint = userData['name']?.toString() ?? '';
          _incomeHint = userData['income']?.toString() ?? '';
          _expensesHint = userData['expenses']?.toString() ?? '';

          // Initialize controllers with fetched values
          _nameController.text = _nameHint;
          _incomeController.text = _incomeHint;
          _expensesController.text = _expensesHint;
        });
      }
    }
  }

  Future<void> _updateUserData() async {
    if (user != null) {
      final DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('users/${user!.uid}');

      await dbRef.update({
        'name': _nameController.text,
        'income': double.tryParse(_incomeController.text) ?? 0.0,
        'expenses': double.tryParse(_expensesController.text) ?? 0.0,
      });
    }
  }

  pick(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFA3B2),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              Text(
                'Set Your Profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'Lilita One',
                ),
              ),
              SizedBox(height: 30),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.grey[200],
                    child: CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: imageFile != null ? FileImage(imageFile!) : null,
                    ),
                  ),
                  Positioned(
                    right: 5,
                    bottom: 5,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child: IconButton(
                        onPressed: _showOptionsBottomSheet,
                        icon: Icon(
                          Icons.edit_outlined,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Your First Name',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1.0,
                      ),
                    ),
                    hintText: _nameHint.isEmpty ? 'Name' : _nameHint,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'My Monthly Income',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: TextField(
                  controller: _incomeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1.0,
                      ),
                    ),
                    hintText: _incomeHint.isEmpty ? '\$' : '\$${_incomeHint}',
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'My Monthly Expenses',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: TextField(
                  controller: _expensesController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1.0,
                      ),
                    ),
                    hintText: _expensesHint.isEmpty ? '\$' : '\$${_expensesHint}',
                  ),
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _updateUserData(); // Update the user data in Firebase
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
                      fixedSize: MaterialStateProperty.all<Size>(Size(150.0, 60.0)),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      FirebaseAuth.instance.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LauncherScreen(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
                      fixedSize: MaterialStateProperty.all<Size>(Size(150.0, 60.0)),
                    ),
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void _showOptionsBottomSheet() {
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
                title: Text('Gallery'),
                onTap: () {
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
                title: Text('Camera'),
                onTap: () {
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
                title: Text('Remove'),
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() {
                    imageFile = null;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
