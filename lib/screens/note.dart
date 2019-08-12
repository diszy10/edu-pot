import 'package:flutter/material.dart';

import 'package:edukasi_pot/screens/screens.dart';
import 'package:edukasi_pot/helpers/helpers.dart';

// class NoteScreen extends StatelessWidget {
//   static const routeName = '/note';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF9F6F5),
//       body: ListView(
//         children: <Widget>[
//           // SizedBox(height: 50.0),

//           //
//           // Top navigation, title page
//           //
//           Container(
//             margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
//             padding: EdgeInsets.symmetric(
//                 horizontal: MediaQuery.of(context).size.width * 0.16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(50.0),
//                   ),
//                   child: Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       onTap: () => Navigator.pop(context),
//                       borderRadius: BorderRadius.circular(50.0),
//                       child: Container(
//                         padding: EdgeInsets.all(8.0),
//                         child: Icon(
//                           Icons.arrow_back,
//                           size: 28.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         'Today\'s Note',
//                         style: TextStyle(
//                           fontSize: 32.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 16.0),
//                       Text(
//                         'How class today?',
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           color: Color(0xFFA29C9D),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 50.0),
//           // Textarea
//           Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: MediaQuery.of(context).size.width * 0.16),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: TextFormField(
//                 maxLines: 14,
//                 decoration: InputDecoration(
//                     hintText:
//                         'Ex. Explain the last exercise on next session once more',
//                     hintStyle: TextStyle(
//                       fontSize: 18.0,
//                     ),
//                     contentPadding: EdgeInsets.all(32.0)),
//               ),
//             ),
//           ),
//           SizedBox(height: 50.0),
//           // Link
//           Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: MediaQuery.of(context).size.width * 0.16),
//             child: GestureDetector(
//               onTap: () {},
//               child: Row(
//                 children: <Widget>[
//                   Icon(Icons.local_library, color: Colors.grey),
//                   SizedBox(width: 8.0),
//                   Text(
//                     'View today\'s class summary',
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.normal,
//                       color: Color(0xFF5B87EC),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           // SizedBox(height: ,

//           //
//           // Continue Button
//           //
//           Container(
//             margin: EdgeInsets.only(
//                 top: MediaQuery.of(context).size.height * 0.293),
//             width: double.infinity,
//             height: 65.0,
//             color: Color(0xFF5B87EC),
//             child: Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 onTap: () => Navigator.pushReplacementNamed(
//                     context, SubjectListScreen.routeName),
//                 // onTap: () async {
//                 //   final authProv =
//                 //       Provider.of<AuthProvider>(context, listen: false);
//                 //   await authProv.logout();
//                 // },
//                 child: Center(
//                   child: Text(
//                     '👋🏼  Save and Logout',
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class NoteScreen extends StatelessWidget {
  static const routeName = '/note';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F6F5),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //
          // Top navigation, title page
          //
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_back,
                          size: 28.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
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
                      SizedBox(height: 16.0),
                      Text(
                        'How class today?',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFFA29C9D),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50.0),

          //
          // Textarea
          //
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                maxLines: 14,
                decoration: InputDecoration(
                    hintText:
                        'Ex. Explain the last exercise on next session once more',
                    hintStyle: TextStyle(
                      fontSize: 18.0,
                    ),
                    contentPadding: EdgeInsets.all(32.0)),
              ),
            ),
          ),
          SizedBox(height: 50.0),

          //
          // Link
          //
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.16),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                children: <Widget>[
                  Icon(Icons.local_library, color: Colors.grey),
                  SizedBox(width: 8.0),
                  Text(
                    'View today\'s class summary',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF5B87EC),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 100.0),

          //
          // Continue Button
          //
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.16),
            child: Container(
              // margin: EdgeInsets.only(
              //     top: MediaQuery.of(context).size.height * 0.293),
              // width: double.infinity,
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
                      '👋🏼  Save and Logout',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
