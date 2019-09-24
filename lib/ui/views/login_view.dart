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

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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

  void _removeSavedEmail(BuildContext context, AuthModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text('Are you sure to remove saved email ?',
            style: TextStyle(fontSize: 16.0)),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel', style: TextStyle(fontSize: 16.0)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Remove', style: TextStyle(fontSize: 16.0)),
            onPressed: () {
              Navigator.of(context).pop();
              model.removeSavedEmail();
              _emailController.text = '';
            },
          ),
        ],
      ),
    );
  }

  void _handleLogin(BuildContext context, AuthModel model) async {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      try {
        if (model.isEmailSaved == true) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              // title: Text('Remember email address ?'),
              content: Text('Do you agree to save email address ?',
                  style: TextStyle(fontSize: 16.0)),
              actions: <Widget>[
                FlatButton(
                  child: Text('Disagree', style: TextStyle(fontSize: 16.0)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Agree', style: TextStyle(fontSize: 16.0)),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await model.login(
                        _emailController.text, _passwordController.text);
                  },
                ),
              ],
            ),
          );
        } else if (model.isEmailSaved == false) {
          await model.login(_emailController.text, _passwordController.text);
        }
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
    return BaseView<AuthModel>(
      onModelReady: (model) => _emailController.text = model.email,
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
                                Image.asset('assets/images/edukasi-logo.png'),
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
                                    controller: _emailController,
                                    hintText: "Email",
                                    // initialValue: 'user1@test.com',
                                    validator: _validateEmail,
                                    focusNode: _emailFocus,
                                    inputType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    // onSaved: (val) => _email = val,
                                    onFieldSubmitted: (value) {
                                      _emailFocus.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_passwordFocus);
                                    },
                                  ),
                                  verticalSpaceSmall(context),
                                  CustomPasswordField(
                                    controller: _passwordController,
                                    hintText: "Password",
                                    // initialValue: 'test',
                                    validator: _validatePassword,
                                    focusNode: _passwordFocus,
                                    textInputAction: TextInputAction.done,
                                    // onSaved: (val) => _password = val,
                                    onFieldSubmitted: (value) {
                                      _passwordFocus.unfocus();
                                    },
                                  ),
                                  verticalSpaceSmall(context),
                                  model.email == null
                                      ? _RememberCheckbox(model)
                                      : Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: GestureDetector(
                                            onTap: () => _removeSavedEmail(
                                                context, model),
                                            child: Text('Remove Saved Email',
                                                style:
                                                    TextStyle(fontSize: 16.0)),
                                          ),
                                        ),
                                  verticalSpaceSmall(context),
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
                                                  ViewState.Authenticate
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

class _RememberCheckbox extends StatefulWidget {
  final AuthModel model;

  const _RememberCheckbox(this.model);

  @override
  __RememberCheckboxState createState() => __RememberCheckboxState();
}

class __RememberCheckboxState extends State<_RememberCheckbox> {
  bool _checked = false;

  void _valueOnChanged(bool value) {
    setState(() {
      _checked = value;
      widget.model.setRememberEmail(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 225.0,
      child: CheckboxListTile(
        value: _checked,
        onChanged: _valueOnChanged,
        title: Text('Remember Email', style: TextStyle(fontSize: 16.0)),
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Color(0xFF5B6CEC),
      ),
    );
  }
}
