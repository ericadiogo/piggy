import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:piggy/screens/planning_screen.dart';

class NewPiggyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewPiggyScreenState();
}


class _NewPiggyScreenState extends State<NewPiggyScreen> {
  late String userName = '';
  int _currentSliderValue = 0;
  int _months = 0;
  bool isFixed = false;
  final TextEditingController _goalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }


   // Function to fetch user data from the DB
   // Here we are only fetching "Name" from the table "Users"
  Future<void> _fetchUserName() async {
    final User user = FirebaseAuth.instance.currentUser!;
    final DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('users/${user.uid}');

    DataSnapshot snapshot = await dbRef.get();
    if (snapshot.exists) {
      final userData = snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        userName = userData['name'] ?? 'User';
      });
    }
  }



    // Function to insert a New Piggy on the DB
    // Here, we insert a new Piggy to the "List of Piggys" of the user on the table "Users"
  Future<void> _savePiggyToDatabase() async {
    final User user = FirebaseAuth.instance.currentUser!;
    final DatabaseReference dbRef =
    FirebaseDatabase.instance.ref().child('users/${user.uid}/piggys');

    DataSnapshot snapshot = await dbRef.get();
    int newId = 1;

    // Assigning custom ID for each Piggy
    // So first we check if that ID already exists
    // If it doesn't, that is the Piggy ID
    // If it does, we add "1" to the "current ID" and create a new one
    if (snapshot.exists) {
      final piggys = snapshot.value as Map<dynamic, dynamic>;
      final highestId = piggys.values
          .map((piggy) => piggy['id'] as int)
          .reduce((value, element) => value > element ? value : element);
      newId = highestId + 1;
    }

    // This is the Constructor for the Piggy
    final newPiggy = {
      'id': newId,
      'name': _goalController.text,
      'needToSave': _currentSliderValue,
      'saved': 0.0,
      'time': _months,
      'fixed': isFixed,
      'installments': [],
    };

    await dbRef.push().set(newPiggy);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlanningScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFA3B2),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(40),
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hey, $userName!',
                      style: TextStyle(
                        fontSize: 36,
                        fontFamily: 'Lilita One',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Text(
                'New Piggy',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Lilita One',
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Goal',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 21,
                        fontFamily: 'Lilita One',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: TextField(
                  controller: _goalController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 1.0),
                    ),
                    hintText: 'Name your goal!',
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'How much do you need to save?',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 21,
                        fontFamily: 'Lilita One',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // We are using a Slider for the user to assign the amount they want to save
              // Here, the maximum amount is 100k and it increments by 100
              Slider(
                value: _currentSliderValue.toDouble(),
                max: 100000,
                min: 0,
                divisions: 1000,
                label: _currentSliderValue.toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = (value / 100).round() * 100;
                  });
                },
                activeColor: Colors.black,
                inactiveColor: Colors.grey[500],
              ),
              SizedBox(height: 20),
              Text(
                '\$ ${_currentSliderValue.toString()}',
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'Lilita One',
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.black,
                            size: 20.0,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Months',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 21,
                              fontFamily: 'Lilita One',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 1.0),
                          ),
                          hintText: '$_months',
                        ),
                        onChanged: (text) {
                          _months = int.tryParse(text) ?? 0;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _savePiggyToDatabase,
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                    ),
                    child: Text(
                      'Create',
                      style: TextStyle(
                        fontFamily: 'Lilita One',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontFamily: 'Lilita One',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
