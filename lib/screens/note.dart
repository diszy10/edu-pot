import 'package:edukasi_pot/helpers/helpers.dart';
import 'package:edukasi_pot/shared/shared.dart';
import 'package:flutter/material.dart';

class NoteScreen extends StatelessWidget {
  static const routeName = '/note';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              /// Title page
              Container(
                padding: edgeSymmetric(context, 7, 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Today\'s Note',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpaceSmall(context),
                    Text(
                      'How class today?',
                      style: TextStyle(
                        color: Color(0xFFA29C9D),
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
              ),

              /// Text area
              Container(
                margin: edgeSymmetric(context, 15, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextFormField(
                  maxLines: 15,
                  decoration: InputDecoration(
                    hintText:
                        'Ex. Explain the last exercise on next session once more',
                    hintStyle: TextStyle(
                      fontSize: 18.0,
                    ),
                    contentPadding: EdgeInsets.all(32.0),
                    border: InputBorder.none,
                  ),
                ),
              ),

              verticalSpaceLarge(context),

              /// Link
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: MediaQuery.of(context).size.width * 0.16),
              //   child: GestureDetector(
              //     onTap: () {},
              //     child: Row(
              //       children: <Widget>[
              //         Icon(Icons.local_library, color: Colors.grey),
              //         SizedBox(width: 8.0),
              //         Text(
              //           'View today\'s class summary',
              //           style: TextStyle(
              //             fontSize: 18.0,
              //             fontWeight: FontWeight.normal,
              //             color: Color(0xFF5B87EC),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),

              /// Save and logout button
              Container(
                width: double.infinity,
                height: 70.0,
                color: Color(0xFF5B87EC),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      await logout(context);
                    },
                    child: Center(
                      child: Text(
                        '👋🏼 Save and Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
