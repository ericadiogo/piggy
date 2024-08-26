import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class PiggyListScreen extends StatefulWidget {
  const PiggyListScreen({super.key});

  @override
  State<PiggyListScreen> createState() => _PiggyListScreenState();
}

class _PiggyListScreenState extends State<PiggyListScreen> {
  late DatabaseReference _piggysRef;
  late User _currentUser;
  List<Map<dynamic, dynamic>> _piggys = [];

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser!;
    _piggysRef = FirebaseDatabase.instance.ref().child('users/${_currentUser.uid}/piggys');
    _fetchPiggys();
  }

  Future<void> _fetchPiggys() async {
    DataSnapshot snapshot = await _piggysRef.get();

    if (snapshot.exists) {
      setState(() {
        final piggysMap = snapshot.value as Map<dynamic, dynamic>;
        _piggys = piggysMap.values.map((piggy) => Map<dynamic, dynamic>.from(piggy)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Piggys'),
      ),
      body: _piggys.isEmpty
          ? const Center(child: Text('No piggys found'))
          : ListView.builder(
        itemCount: _piggys.length,
        itemBuilder: (context, index) {
          final piggy = _piggys[index];
          return ListTile(
            title: Text(piggy['name']),
            subtitle: Text('Need to Save: \$${piggy['needToSave']}, Saved: \$${piggy['saved']}'),
            trailing: Text('Time: ${piggy['time']} months'),
          );
        },
      ),
    );
  }
}
