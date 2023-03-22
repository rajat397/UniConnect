import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uniconnect/util/colors.dart';
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

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Flexible(child: Container(), flex: 2),
          SvgPicture.asset(
            'assets/logo.svg',
            color: primaryColor,
            height: 64,
          ),
          const SizedBox(height: 64),
          //circular widget to accept and show our selected file
          // Stack(
          //   children[
          //     CircleAvatar(
          //       radius: 64,
          //       backgroundImage: NetworkImage('https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80'),
          //     ),

          //   Positioned(child: IconButton(onPressed: () {},icon: const Icon(Icons.add_a_photo,),),),
          //   ],
          // ),
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
            onTap: () {},
            child: Container(
              child: const Text('Log in'),
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
                child: const Text("Don't have an account?"),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  child: const Text(
                    "Sign up",
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
