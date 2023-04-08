import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uniconnect/resources/firestore_methods.dart';
import 'package:uniconnect/util/colors.dart';
import 'package:uniconnect/util/utils.dart';

import '../models/user.dart' as model;
import '../models/user.dart';
import '../providers/providers.dart';
import '../widgets/text_field_input.dart';

class notes_Upload_Post extends StatefulWidget {
  const notes_Upload_Post({super.key});

  @override
  State<notes_Upload_Post> createState() => _notes_Upload_Post();
}

class _notes_Upload_Post extends State<notes_Upload_Post> {

  String _selectedSemester="Not selected yet";

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final model.User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Upload Notes'),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {
            },
            child: const Text(
              'Post',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body:
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/home_bg.png'),
              fit: BoxFit.cover,
            )
        ),
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Pursuing:", style: TextStyle(fontSize: 12),),
                  DropdownButton2<String>(
                    value: _selectedSemester,
                    items: <DropdownMenuItem<String>>[
                      if(_selectedSemester=="Not selected yet")
                        const DropdownMenuItem<String>(
                          value: 'Not selected yet',
                          child: Text('Not selected yet'),
                        ),
                      const DropdownMenuItem<String>(
                        value: '1',
                        child: Text('Semester 1'),
                      ),
                      const DropdownMenuItem<String>(
                        value: '2',
                        child: Text('Semester 2'),
                      ),
                      const DropdownMenuItem<String>(
                        value: '3',
                        child: Text('Semester 4'),
                      ),
                      const DropdownMenuItem<String>(
                        value: '5',
                        child: Text('Semester 5'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedSemester = value!;
                      });
                    },
                  ),],),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  onPressed: () async {
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: iconcolor, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20, // Horizontal padding
                      vertical: 10, // Vertical padding
                    ),
                  ),
                  child: const Text(
                    'Save Details',
                    style: TextStyle(
                      fontSize: 16, // Text size
                      fontWeight: FontWeight.bold, // Text weight
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }


}