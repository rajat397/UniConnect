// import 'package:flutter/material.dart';
//
// class ProfileView extends StatefulWidget{
//   const ProfileView({Key? key}) : super(key: key);
//   @override
//   _ProfilePageState createState()=>_ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfileView> {
//   bool isObscurePassword = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Profile'),
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//             // Navigator.pushAndRemoveUntil(context,
//             //     PageRouteBuilder(
//             //       //   YE WALA USE IF YOU NEED THE SCREEN TO POPUP FROM CENTER
//             //       // transitionDuration: Duration(seconds: 2),
//             //       // transitionsBuilder:(BuildContext context, Animation<double> animation, Animation<double> secAnimation,Widget child){
//             //       //   return ScaleTransition(
//             //       //     alignment: Alignment.center,
//             //       //       scale: animation,
//             //       //     child: child,
//             //       //   );
//             //       // },
//             //       transitionDuration: const Duration(milliseconds: 500),
//             //       pageBuilder: (BuildContext context,
//             //           Animation<double> animation,
//             //           Animation<double> secAnimation) {
//             //         return const HomePage();
//             //       },
//             //       transitionsBuilder: (context, animation, secAnimation,
//             //           child) {
//             //         var begin = const Offset(1.0, 0.0);
//             //         var end = Offset.zero;
//             //         var curve = Curves.ease;
//             //         var tween = Tween(begin: begin, end: end).chain(
//             //             CurveTween(curve: curve));
//             //         var curvedAnimation = CurvedAnimation(
//             //             parent: animation, curve: curve);
//             //         return SlideTransition(
//             //           position: tween.animate(curvedAnimation),
//             //           child: child,
//             //         );
//             //       },
//             //     )
//             //     , (route) => false);
//           },
//         ),
//       ),
//       body: Container(
//         padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
//         child: GestureDetector(
//           onTap: () {
//             FocusScope.of(context).unfocus();
//           },
//           child: ListView(
//             children: [
//               Center(
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: 130,
//                       height: 130,
//                       decoration: BoxDecoration(
//                           border: Border.all(width: 4, color: Colors.white),
//                           boxShadow: [
//                             BoxShadow(
//                                 spreadRadius: 2,
//                                 blurRadius: 10,
//                                 color: Colors.black.withOpacity((0.1))
//                             )
//                           ],
//                           shape: BoxShape.circle,
//                           image: const DecorationImage(
//                               fit: BoxFit.cover,
//                               image: AssetImage('assets/prof_pic3.jpg')
//                           )
//                       ),
//                     ),
//                     Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: Container(
//                           height: 40,
//                           width: 40,
//                           decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                   width: 4,
//                                   color: Colors.white
//                               ),
//                               color: Colors.black
//                           ),
//                           child: const Icon(
//                               Icons.edit,
//                               color: Colors.white
//                           ),
//                         )
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 30,),
//               buildTextField("Full Name", "Your Name Here", false),
//               buildTextField("Email", "Sample", false),
//               buildTextField("Password", "***************8", true),
//               buildTextField("Location", "New York", false)
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   Widget buildTextField(String labelText, String placeholder,
//       bool isPasswordTextField) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 30),
//       child: TextField(
//         obscureText: isPasswordTextField ? isObscurePassword : false,
//         decoration: InputDecoration(
//             suffixIcon: isPasswordTextField ?
//             IconButton(
//                 icon: const Icon(Icons.remove_red_eye, color: Colors.grey,),
//                 onPressed: () {
//                   setState(() {
//                     isObscurePassword = !isObscurePassword;
//                   });
//                 }
//             ) : null,
//             contentPadding: const EdgeInsets.only(bottom: 5),
//             labelText: labelText,
//             floatingLabelBehavior: FloatingLabelBehavior.always,
//             hintText: placeholder,
//             hintStyle: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.grey
//             )
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileView> {
  bool isObscurePassword = true;
  File? _image;
  String imageUrl="https://firebasestorage.googleapis.com/v0/b/uniconnect-62628.appspot.com/o/default_prof.jpg?alt=media&token=2488a918-e680-4445-a04b-5627c62dcf46";

  Future getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Fluttertoast.showToast(msg: "No Image Selected");
      }
    });

    if(_image!=null){
      Fluttertoast.showToast(msg: "Uploading Image....");
      String uid= FirebaseAuth.instance.currentUser!.uid;
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('profile/$uid.jpg');
      await ref.putFile(_image!);
      String url = await ref.getDownloadURL();

      setState(() {
        imageUrl = url;
      });

      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'profilepic': url
      });
    }
  }

  Future<void> getProfilePicture() async {
    String uid= FirebaseAuth.instance.currentUser!.uid;
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('profile/$uid.jpg');
    String url = await ref.getDownloadURL();

    setState(() {
      imageUrl = url;
    });
  }

  @override
  void initState() {
    super.initState();
    getProfilePicture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity((0.1)),
                          )
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: imageUrl != null ? ClipOval(
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/loading.gif',
                          image: imageUrl ?? "https://firebasestorage.googleapis.com/v0/b/uniconnect-62628.appspot.com/o/default_prof.jpg?alt=media&token=2488a918-e680-4445-a04b-5627c62dcf46",
                          fit: BoxFit.cover,
                        ),
                      ) : Container(
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          getImage();
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
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              buildTextField("Full Name", "Your Name Here", false),
              buildTextField("Email", "Sample", false),
              buildTextField("Password", "***************8", true),
              buildTextField("Location", "New York", false),
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
        obscureText: isPasswordTextField ? isObscurePassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              icon: Icon(Icons.remove_red_eye, color: Colors.grey),
              onPressed: () {
                setState(() {
                  isObscurePassword = !isObscurePassword;
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
