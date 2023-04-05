import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uniconnect/util/colors.dart';

class PostCard extends StatelessWidget {
  final Map<String, dynamic> snap;

  // final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      snap['profilepic'] ?? ''),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snap['username'] ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          Dialog(
                            child: ListView(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              shrinkWrap: true,
                              children: [
                                'Delete',
                              ].map(
                                    (e) =>
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 16,
                                        ),
                                        child: Text(e),
                                      ),
                                    ),
                              ).toList(),
                            ),
                          ),
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),

          // BODY SECTION BEGINS

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          color: primaryColor
                      ),
                      children: [
                        TextSpan(
                          text: snap['username'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),


                      ],
                    ),

                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          color: primaryColor
                      ),
                      children: [
                        TextSpan(
                          text: snap['start'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),


                      ],
                    ),

                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          color: primaryColor
                      ),
                      children: [
                        TextSpan(
                          text: snap['destination'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),


                      ],
                    ),

                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          color: primaryColor
                      ),
                      children: [
                        TextSpan(
                          text: snap['vechicle'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),


                      ],
                    ),

                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          color: primaryColor
                      ),
                      children: [
                        TextSpan(
                          text: snap['timeOfDeparture'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),


                      ],
                    ),

                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          color: primaryColor
                      ),
                      children: [
                        TextSpan(
                          text: snap['expectedPerHeadCharge'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),


                      ],
                    ),

                  ),
                ),
                //
                // Container(
                //   padding: const EdgeInsets.symmetric(vertical: 4),
                //   child: Text(
                //     DateFormat.yMMMd().format(snap['datePublished'].toDate(),),
                //     style: const TextStyle(fontSize: 16, color: secondaryColor),
                //   ),
                // )


              ],
            ),
          ),
        ],
      ),
    );
  }

}
