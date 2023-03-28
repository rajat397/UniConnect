import 'package:flutter/material.dart';
import 'package:uniconnect/screens/home_page.dart';

// import 'login_screen.dart';

class ProfileView extends StatefulWidget{
  const ProfileView({Key? key}) : super(key: key);
  @override
  _ProfilePageState createState()=>_ProfilePageState();
}

class _ProfilePageState extends State<ProfileView> {
  bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(context,
                PageRouteBuilder(
                  //   YE WALA USE IF YOU NEED THE SCREEN TO POPUP FROM CENTER
                  // transitionDuration: Duration(seconds: 2),
                  // transitionsBuilder:(BuildContext context, Animation<double> animation, Animation<double> secAnimation,Widget child){
                  //   return ScaleTransition(
                  //     alignment: Alignment.center,
                  //       scale: animation,
                  //     child: child,
                  //   );
                  // },
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secAnimation) {
                    return HomePage();
                  },
                  transitionsBuilder: (context, animation, secAnimation,
                      child) {
                    var begin = Offset(1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.ease;
                    var tween = Tween(begin: begin, end: end).chain(
                        CurveTween(curve: curve));
                    var curvedAnimation = CurvedAnimation(
                        parent: animation, curve: curve);
                    return SlideTransition(
                      position: tween.animate(curvedAnimation),
                      child: child,
                    );
                  },
                )
                , (route) => false);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
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
                                color: Colors.black.withOpacity((0.1))
                            )
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/prof_pic3.jpg')
                          )
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 4,
                                  color: Colors.white
                              ),
                              color: Colors.black
                          ),
                          child: Icon(
                              Icons.edit,
                              color: Colors.white
                          ),
                        )
                    )
                  ],
                ),
              ),
              SizedBox(height: 30,),
              buildTextField("Full Name", "Your Name Here", false),
              buildTextField("Email", "Sample", false),
              buildTextField("Password", "***************8", true),
              buildTextField("Location", "New York", false)

            ],
          ),
        ),
      ),
    );
  }


  Widget buildTextField(String labelText, String placeholder,
      bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPasswordTextField ? isObscurePassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField ?
            IconButton(
                icon: Icon(Icons.remove_red_eye, color: Colors.grey,),
                onPressed: () {
                  setState(() {
                    isObscurePassword = !isObscurePassword;
                  });
                }
            ) : null,
            contentPadding: EdgeInsets.only(bottom: 5),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            )
        ),
      ),
    );
  }
}
