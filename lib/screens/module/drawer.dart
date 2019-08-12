import 'package:flutter/material.dart';

import 'package:edukasi_pot/models/models.dart';
import 'package:edukasi_pot/widgets/widgets.dart';

class ModuleDrawer extends StatelessWidget {
  const ModuleDrawer({
    Key key,
    @required List<Module> moduleList,
  })  : _moduleList = moduleList,
        super(key: key);

  final List<Module> _moduleList;

  @override
  Widget build(BuildContext context) {
    final Size media = MediaQuery.of(context).size;
    final bool target = media.height > 1000;
    return SizedBox(
      width: target ? media.width / 2 : media.width / 3,
      child: Drawer(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// User section and close drawer button
            Container(
              margin: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  /// User menu
                  Row(
                    children: <Widget>[
                      /// Username text
                      Text(
                        'Deprito',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),

                      /// Expanded button
                      Container(
                        margin: EdgeInsets.only(top: 4.0, left: 4.0),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(16.0),
                            child: Container(
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                size: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// Close drawer button
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.close,
                          color: Color(0xFF7B8189),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey, height: 1.0),
            SizedBox(height: 8.0),

            /// Notes section
            InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    /// Notes text
                    Row(
                      children: <Widget>[
                        Icon(Icons.note, color: Colors.blue),
                        SizedBox(width: 8.0),
                        Text('Notes', style: TextStyle(fontSize: 20.0)),
                      ],
                    ),

                    /// Notes indicator
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFFF5657),
                          borderRadius: BorderRadius.circular(16.0)),
                      child: Text(
                        '3',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.0),

            /// Modules section
            Container(
              margin: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 16.0),
              child: Text(
                'GRADE 5 MODULES',
                style: TextStyle(fontSize: 16.0, color: Color(0xFF586069)),
              ),
            ),
            _ModuleList(
              modules: _moduleList,
            ),

            Divider(color: Colors.grey, height: 1.0),
            SizedBox(height: 16.0),

            /// Slider conclude class
            ConcludeSlider(),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}

class _ModuleList extends StatelessWidget {
  const _ModuleList({
    Key key,
    @required this.modules,
  }) : super(key: key);

  final List<Module> modules;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: modules.length,
          itemBuilder: (context, index) {
            Module module = modules[index];
            int no = index + 1;
            return InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.folder, color: Color(0xFF90CFE8)),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                        'Module ' + no.toString() + " " + module.title,
                        style: no == 0
                            ? TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              )
                            : TextStyle(
                                fontSize: 18.0,
                                color: Colors.black54,
                              ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
