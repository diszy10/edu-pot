import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/viewmodels/viewmodels.dart';
import 'package:edukasi_pot/ui/shared/shared.dart';
import 'package:edukasi_pot/ui/views/base_view.dart';
import 'package:edukasi_pot/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModuleDrawer extends StatelessWidget {
  final Subject subject;

  const ModuleDrawer({Key key, this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size media = MediaQuery.of(context).size;
    final bool target = media.height > 1000;
    return SizedBox(
      width: target ? media.width / 2 : media.width / 3,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// User and close drawer button
            Container(
              margin: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  /// User
                  Text(
                    '${Provider.of<User>(context).name}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  /// Close drawer button
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(32.0),
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
            verticalSpace(context, 1),

            /// moduleIndextes
            InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    /// moduleIndextes section
                    Row(
                      children: <Widget>[
                        Icon(Icons.note, color: Colors.blue),
                        SizedBox(width: 8.0),
                        Text('Notes', style: TextStyle(fontSize: 20.0)),
                      ],
                    ),

                    /// moduleIndextes indicator
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
            verticalSpace(context, 1),

            /// Module list
            Container(
              margin: edgeSymmetric(context, 2, 2),
              child: Text(
                'GRADE ${subject.klass.substring(0, 1)} MODULES',
                style: TextStyle(
                  color: Color(0xFF586069),
                  fontSize: 16.0,
                ),
              ),
            ),
            ModuleList(subject: subject),
            Divider(color: Colors.grey[300], height: 1.0),
            verticalSpaceSmall(context),

            /// Slider conclude class
            BaseView<ModuleModel>(
              builder: (context, model, _) => ConcludeSlider(
                onConclude: () {
                  model.hideDrawer();
                  model.navigateToHomework();
                },
              ),
            ),
            verticalSpaceSmall(context)
          ],
        ),
      ),
    );
  }
}

class ModuleList extends StatelessWidget {
  final Subject subject;

  const ModuleList({@required this.subject});

  @override
  Widget build(BuildContext context) {
    return BaseView<ModuleModel>(
      onModelReady: (model) => model.getModules(subject.id),
      builder: (context, model, child) => Expanded(
        child: ListView.builder(
          itemCount: model.modules.length,
          itemBuilder: (context, index) {
            Module module = model.modules[index];
            int moduleIndex = index + 1;
            int selectedModule = model.moduleIndex;
            return InkWell(
              onTap: () {
                model.setActiveModule(moduleIndex);
                model.navigateToModuleDetail(arguments: module);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: selectedModule == moduleIndex ? 18.0 : 24.0,
                ),
                decoration: selectedModule == moduleIndex
                    ? BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                color: Color(0xFF5B87EC), width: 5.0)),
                        color: Color(0xFFF4F7F8))
                    : null,
                child: Row(
                  children: <Widget>[
                    selectedModule == moduleIndex
                        ? Icon(Icons.folder_open, color: Color(0xFF25C431))
                        : Icon(Icons.folder, color: Color(0xFF90CFE8)),
                    SizedBox(
                      width: 12.0,
                    ),
                    Expanded(
                      child: Text(
                        'Module ' + moduleIndex.toString() + " " + module.title,
                        style: selectedModule == moduleIndex
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
          },
        ),
      ),
    );
  }
}
