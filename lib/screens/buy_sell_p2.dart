// // import 'dart:html';
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:uniconnect/resources/firestore_methods.dart';
// import 'package:uniconnect/util/colors.dart';
// import 'package:uniconnect/util/utils.dart';
//
// import '../models/user.dart' as model;
// import '../providers/providers.dart';
// import '../widgets/text_field_input.dart';
//
// class Carpool_upload_post extends StatefulWidget {
//   const Carpool_upload_post({super.key});
//
//   @override
//   State<Carpool_upload_post> createState() => _Carpool_upload_postState();
// }
//
// class _Carpool_upload_postState extends State<Carpool_upload_post> {
//   final TextEditingController startController = TextEditingController();
//   final TextEditingController destinationController = TextEditingController();
//   final TextEditingController vehicleController = TextEditingController();
//   final TextEditingController timeOfDepartureController =
//       TextEditingController();
//   final TextEditingController expectedPerHeadChargeController =
//       TextEditingController();
//
//   @override
//   void dispose() {
//     super.dispose();
//     startController.dispose();
//     destinationController.dispose();
//     vehicleController.dispose();
//     timeOfDepartureController.dispose();
//     expectedPerHeadChargeController.dispose();
//   }
//
//   bool _isloading = false;
//   void uploadPost() async {
//     setState(() {
//       _isloading = true;
//     });
//     try {
//       model.User user = Provider.of<UserProvider>(context).getUser;
//
//       String res = await FirestoreMethods().uploadPost(
//         start: startController.text,
//         destination: destinationController.text,
//         timeOfDeparture: timeOfDepartureController.text,
//         vehicle: vehicleController.text,
//         expectedPerHeadCharge: expectedPerHeadChargeController.text,
//         username: user.username,
//         uid: user.uid,
//       );
//       if (res == "success") {
//         setState(() {
//           _isloading = false;
//         });
//
//         startController.clear();
//         destinationController.clear();
//         vehicleController.clear();
//         timeOfDepartureController.clear();
//         expectedPerHeadChargeController.clear();
//         showSnackBar("Uploaded", context);
//       } else {
//         setState(() {
//           _isloading = false;
//         });
//         showSnackBar(res, context);
//       }
//     } catch (e) {}
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: mobileBackgroundColor,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {},
//         ),
//         title: const Text('Post to'),
//         centerTitle: false,
//         actions: [
//           TextButton(
//             onPressed: uploadPost,
//             child: const Text(
//               'Post',
//               style: TextStyle(
//                 color: Colors.blueAccent,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           _isloading
//               ? const LinearProgressIndicator()
//               : const Padding(
//                   padding: EdgeInsets.only(top: 0),
//                 ),
//                 const Divider(),
//           TextFieldInput(
//               textEditingController: startController,
//               hintText: 'Enter the starting point of journey',
//               textInputType: TextInputType.text),
//           const SizedBox(
//             height: 24,
//           ),
//           TextFieldInput(
//               textEditingController: destinationController,
//               hintText: 'Enter the destination',
//               textInputType: TextInputType.text),
//           const SizedBox(
//             height: 24,
//           ),
//           TextFieldInput(
//             textEditingController: timeOfDepartureController,
//             hintText: 'Enter the time and Date of Departure',
//             textInputType: TextInputType.datetime,
//           ),
//           const SizedBox(
//             height: 24,
//           ),
//           TextFieldInput(
//             textEditingController: vehicleController,
//             hintText: 'Enter the vehicle ex- Cab or auto',
//             textInputType: TextInputType.text,
//           ),
//           const SizedBox(
//             height: 24,
//           ),
//           TextFieldInput(
//             textEditingController: expectedPerHeadChargeController,
//             hintText: 'Enter the Expected per Head Charge',
//             textInputType: TextInputType.number,
//           ),
//           const SizedBox(
//             height: 24,
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:html';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


import 'profile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniconnect/resources/firestore_methods.dart';
import 'package:uniconnect/util/colors.dart';
import 'package:uniconnect/util/utils.dart';

import '../models/user.dart' as model;
import '../models/user.dart';
import '../providers/providers.dart';
import '../widgets/text_field_input.dart';
import 'dart:io';

class List_Item extends StatefulWidget {
  const List_Item({super.key});

  @override
  State<List_Item> createState() => _List_Item();
}

class _List_Item extends State<List_Item> {
  final TextEditingController startController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController vehicleController = TextEditingController();
  final TextEditingController timeOfDepartureController =
  TextEditingController();
  final TextEditingController expectedPerHeadChargeController =
  TextEditingController();

  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }


  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }




  get imageUrl => null;

  @override
  void dispose() {
    super.dispose();
    startController.dispose();
    destinationController.dispose();
    vehicleController.dispose();
    timeOfDepartureController.dispose();
    expectedPerHeadChargeController.dispose();
  }

  bool _isloading = false;
  void uploadPost(
      String uid,
      String username,
      String profilepic,
      ) async {
    setState(() {
      _isloading = true;
    });
    try {

      String res = await FirestoreMethods().uploadPost(
        startController.text,
        destinationController.text,
        vehicleController.text,
        timeOfDepartureController.text,

        expectedPerHeadChargeController.text,
        uid,

        username,
        profilepic,
      );
      if (res == "success") {
        setState(() {
          _isloading = false;
        });
        //
        // startController.clear();
        // destinationController.clear();
        // vehicleController.clear();
        // timeOfDepartureController.clear();
        // expectedPerHeadChargeController.clear();
        showSnackBar("Uploaded", context);
      } else {
        setState(() {
          _isloading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }



  @override
  Widget build(BuildContext context) {
    final model.User? user =  Provider.of<UserProvider>(context).getUser;

    return Scaffold(

      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 350,
                      height: 300,

                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity((0.1)),
                          )

                        ],
                        //shape: BoxShape.circle,
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          myAlert();
                        },

                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 4, color: Colors.white),
                            color: Colors.black,
                          ),
                          child: const Icon(Icons.edit, color: Colors.white),
                        ),
                      ),
                    ),
                    image != null?
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),

                        child: Image.file(
                          //to show image, you type like this.
                          File(image!.path),
                          fit: BoxFit.cover,
                          width: 350,
                          height: 250,

                        ),
                      ),
                    )
                        : Text(
                      "",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              buildTextField("Product Name", "Product Name", false),
              buildTextField("Product Description", "Describe your product here.", false),
              buildNumberField("Selling Price", "Estimate Price", false,6),
              buildTextField("Hostel Number", "Enter your hostel number", false),
              buildNumberField("Phone Number", "Enter your phone number", false,10),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {},
                child: const Text('List Item'),
              ),
            ],

          ),

        ),

      ),

    );
  }

  Widget buildTextField(String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),

      child: TextField(
        //obscureText: isPasswordTextField ? isObscurePassword : false,


        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              icon: Icon(Icons.remove_red_eye, color: Colors.grey),
              onPressed: () {
                setState(() {
                  //isObscurePassword = !isObscurePassword;
                });
              },
            )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 5),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            )
        ),
      ),
    );
  }


  Widget buildNumberField(String labelText, String placeholder, bool isPasswordTextField,int len) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),

      child: TextField(
        //obscureText: isPasswordTextField ? isObscurePassword : false,
        keyboardType: TextInputType.number,

        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          LengthLimitingTextInputFormatter(len),
        ],

        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              icon: Icon(Icons.remove_red_eye, color: Colors.grey),
              onPressed: () {
                setState(() {
                  //isObscurePassword = !isObscurePassword;
                });
              },
            )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 5),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            )
        ),
      ),
    );
  }


}