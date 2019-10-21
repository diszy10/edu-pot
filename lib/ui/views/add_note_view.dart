import 'dart:io';

import 'package:edukasi_pot/core/enums/viewstate.dart';
import 'package:edukasi_pot/core/viewmodels/add_note_model.dart';
import 'package:edukasi_pot/ui/shared/shared.dart';
import 'package:edukasi_pot/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class AddNoteView extends StatelessWidget {
  final _noteController = TextEditingController();

  void _handleSaveNote(AddNoteModel model) {
    // if (_noteController.text != null) {
    // }
    model.logout();
  }

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
              // Title page
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

              // Text area
              Container(
                margin: edgeSymmetric(context, 15, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextFormField(
                  controller: _noteController,
                  textInputAction: TextInputAction.done,
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

              // Save & logout button
              BaseView<AddNoteModel>(
                builder: (context, model, _) => Container(
                  width: double.infinity,
                  height: 70.0,
                  color: Color(0xFF5B87EC),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        _handleSaveNote(model);
                      },
                      child: Center(
                        child: model.state == ViewState.Busy
                            ? Container(
                                padding: Platform.isIOS
                                    ? edgeVertical(context, 3)
                                    : edgeVertical(context, 2.15),
                                child: Loader(
                                  loaderColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : Text(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
