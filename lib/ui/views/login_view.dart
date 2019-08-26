import 'dart:io';

import 'package:edukasi_pot/core/enums/viewstate.dart';
import 'package:edukasi_pot/core/viewmodels/viewmodels.dart';
import 'package:edukasi_pot/ui/shared/shared.dart';
import 'package:edukasi_pot/ui/views/base_view.dart';
import 'package:edukasi_pot/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  static String _email, _password;

  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value == '')
      return 'Email must not be empty';
    else if (!regex.hasMatch(value)) return 'Please enter valid email address';
    return null;
  }

  String _validatePassword(String value) {
    if (value == '') return 'Password must not be empty';
    return null;
  }

  void _handleLogin(BuildContext context, LoginModel model) async {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      try {
        await model.login(context, _email, _password);
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (context, model, child) => Scaffold(
        body: model.state == ViewState.Busy
            ? SplashScreen()
            : Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFace0f9).withOpacity(0.3),
                          Color(0xFFfff1eb).withOpacity(0.6),
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topCenter,
                        stops: [0, 1],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child:
                                Image.asset('assets/graphics/edukasi-logo.png'),
                          ),
                          verticalSpaceLarge(context),
                          Container(
                            width: widthMedium(context),
                            padding: edgeSymmetric(context, 3, 5),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CustomTextField(
                                    hintText: "Email",
                                    initialValue: 'user1@test.com',
                                    validator: _validateEmail,
                                    focusNode: _emailFocus,
                                    inputType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    onSaved: (val) => _email = val,
                                    onFieldSubmitted: (value) {
                                      _emailFocus.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_passwordFocus);
                                    },
                                  ),
                                  verticalSpaceSmall(context),
                                  CustomPasswordField(
                                    hintText: "Password",
                                    initialValue: 'test',
                                    validator: _validatePassword,
                                    focusNode: _passwordFocus,
                                    textInputAction: TextInputAction.done,
                                    onSaved: (val) => _password = val,
                                    onFieldSubmitted: (value) {
                                      _passwordFocus.unfocus();
                                    },
                                  ),
                                  verticalSpaceMedium(context),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF5B6CEC),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () =>
                                            _handleLogin(context, model),
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        child: Center(
                                          child: model.state ==
                                                  ViewState.Authentication
                                              ? Container(
                                                  padding: Platform.isIOS
                                                      ? edgeVertical(context, 3)
                                                      : edgeVertical(
                                                          context, 2.15),
                                                  child: Loader(
                                                    loaderColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Colors.white),
                                                  ),
                                                )
                                              : Container(
                                                  padding:
                                                      edgeVertical(context, 3),
                                                  child: Text(
                                                    'Log in',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
