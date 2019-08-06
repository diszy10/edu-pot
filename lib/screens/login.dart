import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';

import 'package:edukasi_pot/providers/auth.dart';
import 'package:edukasi_pot/widgets/widgets.dart';

import 'package:edukasi_pot/screens/screens.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  String _email, _password;
  bool _isLoading = false;

  // Validation
  String _validateEmail(String value) {
    // Simple email regex.
    // Might not handles all type of email
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value == '')
      return 'Email must not be empty';
    else if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    return null;
  }

  String _validatePassword(String value) {
    if (value == '')
      return 'Passowrd must not be empty';
    // TODO: Implement password validation
    return null;
  }

  // Logic
  void _showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
    ));
  }

  void _handleLogin(BuildContext context) async {
    final FormState form = _formKey.currentState;
    final authProv = Provider.of<AuthProvider>(context);
    if (form.validate()) {
      form.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await authProv.login(_email, _password);
      } catch (e) {
        _showInSnackBar("Something's wrong!!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: AspectRatio(
              aspectRatio: 4.0,
              child: Image.asset('assets/graphics/edukasi-logo.png'),
            ),
          ),
          Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 4),
              child: Column(
                children: <Widget>[
                  AppTextField(
                    hintText: "Email",
                    validator: _validateEmail,
                    inputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    focusNode: _emailFocus,
                    onSaved: (val) => _email = val,
                    onFieldSubmitted: (value) {
                      _emailFocus.unfocus();
                      FocusScope.of(context).requestFocus(_passwordFocus);
                    },
                  ),
                  SizedBox(height: 24.0),
                  AppPasswordField(
                    hintText: "Password",
                    focusNode: _passwordFocus,
                    validator: _validatePassword,
                    textInputAction: TextInputAction.done,
                    onSaved: (val) => _password = val,
                    onFieldSubmitted: (value) {
                      _passwordFocus.unfocus();
                    },
                  ),
                  SizedBox(height: 24.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF5B6CEC),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _handleLogin(context),
                        borderRadius: BorderRadius.circular(16.0),
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16.0,
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
            ),
          )
        ],
      ),
    );
  }
}
