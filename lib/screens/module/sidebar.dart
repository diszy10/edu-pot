import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Scaffold.of(context).openDrawer(),
      child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFBFCFD),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                blurRadius: 2.0,
                offset: Offset(-3.0, 4.0),
              )
            ],
          ),
          child: _SidebarContent()),
    );
  }
}

class _SidebarContent extends StatelessWidget {
  const _SidebarContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          /// Menu icon
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.menu,
                  size: 32.0,
                  color: Color(0xFF586069),
                ),
              ),
            ),
          ),

          /// Empty widget for module indicators
          Container(),
        ],
      ),
    );
  }
}
