import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uniconnect/resources/auth.methods.dart';
import 'package:uniconnect/responsive/mobile_screen_layout.dart';
import 'package:uniconnect/responsive/responsive_layout_screen.dart';
import 'package:uniconnect/responsive/web_screen_layout.dart';
import 'package:uniconnect/screens/login_screen.dart';
import 'package:uniconnect/util/colors.dart';
import 'package:uniconnect/util/utils.dart';
import 'package:uniconnect/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      username: usernameController.text,
    );
    // if string returned is success, user has been created

    setState(() {
      isLoading = false;
    });
    if (res != "Success") {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreenLayout()),
        ),
      );
    }
  }

  void navigateToLogin() {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginScreen()),(route)=>false);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/loginbg.jpg'),
                fit: BoxFit.cover,
              )
            ),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Flexible(flex: 4, child:
              Image.asset(
                  'assets/logo_png.png',
                height: 1000,
              )
          // SvgPicture.asset(
            // 'assets/logo.svg',
            // matchTextDirection: false,
            // allowDrawingOutsideViewBox: true,
            // // height: 3205,
            // placeholderBuilder: (context)=> const CircularProgressIndicator(),
            // fit: BoxFit.contain,
            // alignment: Alignment.center,
          // )
          ),
          const SizedBox(
            height: 30,
          ),

          // Image.asset('assets/logo_png.png'),
          TextFieldInput(
              textEditingController: usernameController,
              hintText: 'Enter your username',
              textInputType: TextInputType.text),
          const SizedBox(
            height: 24,
          ),
          TextFieldInput(
              textEditingController: emailController,
              hintText: 'Enter your email',
              textInputType: TextInputType.emailAddress),
          const SizedBox(
            height: 24,
          ),
          TextFieldInput(
            textEditingController: passwordController,
            hintText: 'Enter your Password',
            textInputType: TextInputType.text,
            isPass: true,
          ),
          const SizedBox(
            height: 24,
          ),
          InkWell(
            onTap: signUpUser,
            child: Container(
              child: !isLoading
                  ? const Text(
                      'Sign up',
                    )
                  : const CircularProgressIndicator(
                      color: primaryColor,
                    ),
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  color: blueColor),
            ),
          ),

          const SizedBox(
            height: 12,
          ),
          Flexible(child: Container(), flex: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: const Text("Already have an account?"),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
              ),
              GestureDetector(
                onTap: navigateToLogin,
                child: Container(
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                ),
              ),
            ],
          )
        ]),
      )),
    );
  }
}
