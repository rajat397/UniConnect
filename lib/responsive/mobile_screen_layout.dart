import 'package:flutter/material.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top:8),
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ), onPressed: () { }, child: Text('Order Food'),
              ),

            ),
            Container(
              margin: EdgeInsets.only(top:8),
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ), onPressed: () { }, child: Text('Carpool'),
              ),

            ),
            Container(
              margin: EdgeInsets.only(top:8),
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ), onPressed: () { }, child: Text('Buy And Sell Items'),
              ),

            ),
            Container(
              margin: EdgeInsets.only(top:8),
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ), onPressed: () { }, child: Text('Games Section'),
              ),

            ),
            Container(
              margin: EdgeInsets.only(top:8),
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ), onPressed: () { }, child: Text('Notes Sharing'),
              ),

            ),
            Container(
              margin: EdgeInsets.only(top:8),
              child: OutlinedButton(
                style: ButtonStyle(

                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ), onPressed: () { }, child: Text('Mess Feedback'),
              ),

            )
          ],
        ),
      ),
    );
  }
}
