import 'package:flutter/material.dart';

import 'package:edukasi_pot/models/models.dart';

import './drawer.dart';
import './sidebar.dart';
import './tab_view.dart';

class ModuleScreen extends StatelessWidget {
  /// Subject screen that show many modules.
  static const routeName = '/module';

  final _moduleList = [
    Module(title: 'Decimal fractions and place value patterns'),
    Module(title: 'Decimal fractions and place value patterns'),
    Module(title: 'Decimal fractions and place value patterns'),
    Module(title: 'Decimal fractions and place value patterns'),
    Module(title: 'Decimal fractions and place value patterns'),
    Module(title: 'Decimal fractions and place value patterns'),
  ];

  @override
  Widget build(BuildContext context) {
    final Size media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFF2F4F6),
      drawer: ModuleDrawer(moduleList: _moduleList),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SideBar(),
            SizedBox(
              width: 48.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F4F6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],
                      blurRadius: 2.0,
                      offset: Offset(-3.0, -2.0),
                    )
                  ],
                ),
              ),
            ),
            // Body
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  backgroundColor: Color(0xFFF2F4F6),
                  appBar: _AppBar(
                    media: media,
                  ),
                  body: ModuleTabView(),
                ),
              ),
            ),
            SizedBox(
              width: 48.0,
              child: Container(color: Color(0xFFF2F4F6)),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  _AppBar({
    Key key,
    @required Size media,
    bool target,
  })  : _media = media,
        _target = target ?? media.height > 800,
        super(key: key);

  final Size _media;
  final bool _target;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      backgroundColor: Color(0xFFF2F4F6),
      automaticallyImplyLeading: false,
      flexibleSpace: Column(
        children: <Widget>[
          SizedBox(height: 68.0),

          /// Topic info badge
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                decoration: BoxDecoration(
                    color: Color(0xFF25C431),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                'TOPIC 8',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFF25C431),
                ),
              )
            ],
          ),
          SizedBox(height: 16.0),

          /// Module topic text
          Text(
            'Decimal fractions and place value patterns',
            style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323232)),
          ),
          SizedBox(height: 32.0),
        ],
      ),
      bottom: TabBar(
        unselectedLabelColor: Color(0xFF9FA3A6),
        labelColor: Color(0xFF06A4B2),
        indicatorColor: Color(0xFF06A4B2),
        indicatorWeight: 4,
        tabs: [
          Tab(
            child: Text('Description', style: TextStyle(fontSize: 16.0)),
          ),
          Tab(
            child: Text('Exercise', style: TextStyle(fontSize: 16.0)),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(_target ? _media.height / 3 : _media.height / 2.3);
}
