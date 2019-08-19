import 'package:edukasi_pot/shared/shared.dart';
import 'package:flutter/material.dart';

import 'package:edukasi_pot/screens/module/drawer.dart';
import 'package:edukasi_pot/screens/module/sidebar.dart';
import 'package:edukasi_pot/screens/module/tab_view.dart';

class ModuleScreen extends StatelessWidget {
  static const routeName = '/module';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F4F6),
      drawer: ModuleDrawer(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Sidebar(),
            Expanded(
              child: Container(
                margin: edgeHorizontal(context, 5),
                child: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    backgroundColor: Color(0xFFF2F4F6),
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        verticalSpaceLarge(context),

                        /// Topic info badge
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              decoration: BoxDecoration(
                                  color: Color(0xFF25C431),
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            horizontalSpace(context, 0.8),
                            Text(
                              'TOPIC 8',
                              style: TextStyle(
                                color: Color(0xFF25C431),
                                fontSize: 24.0,
                              ),
                            )
                          ],
                        ),
                        verticalSpaceSmall(context),

                        /// Module topic text
                        Text(
                          'Decimal fractions and place value patterns',
                          style: TextStyle(
                            color: Color(0xFF323232),
                            fontSize: 74.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        verticalSpaceMedium(context),

                        /// Tabbar
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Color(0xFFCAD0D3)),
                            ),
                          ),
                          child: TabBar(
                            unselectedLabelColor: Color(0xFF9FA3A6),
                            labelColor: Color(0xFF06A4B2),
                            indicatorColor: Color(0xFF06A4B2),
                            indicatorWeight: 4.0,
                            tabs: [
                              Tab(
                                child: Text(
                                  'Description',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Exercise',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// Tabview / tab content
                        Expanded(child: ModuleTabView()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
