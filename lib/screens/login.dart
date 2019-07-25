import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';

import 'package:edukasi_pot/config/base.dart';
import 'package:edukasi_pot/states/auth.dart';
import 'package:edukasi_pot/widgets/widgets.dart';
import './school.dart';

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
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String _validatePassword(String value) {
    // TODO: Implement
    return null;
  }

  // Logic
  void _showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
    ));
  }

  void _handleLogin(BuildContext context) async {
    bool _isAuth;
    final FormState form = _formKey.currentState;
    final auth = Provider.of<AuthNotifier>(context, listen: false);
    if (form.validate()) {
      form.save();
      setState(() {
        _isLoading = true;
      });
      try {
        _isAuth = await auth.login(_email, _password);
      } catch (e) {
        _isAuth = false;
      }
      if (_isAuth) {
        Navigator.of(context).pushReplacementNamed(SchoolScreen.routeName);
      }
    }
    _showInSnackBar("Something's wrong!!");
  }

  @override
  Widget build(BuildContext context) {
    var config = Provider.of<BaseConfig>(context);
 
    var form = Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Text('Text ${config.env}'),
          AppTextField(
            hintText: "E-mail *",
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
          SizedBox(height: 10.0),
          AppPasswordField(
            hintText: "Password *",
            focusNode: _passwordFocus,
            validator: _validatePassword,
            textInputAction: TextInputAction.done,
            onSaved: (val) => _password = val,
            onFieldSubmitted: (value) {
              _passwordFocus.unfocus();
            },
          ),
          SizedBox(
            height: 15.0,
          ),
          MaterialButton(
            onPressed: () => _handleLogin(context),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'Login',
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
    return Scaffold(
      key: _scaffoldKey,
      body: Material(
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.only(top: 48.0, left: 24.0, right: 24.0),
          child: form,
        ),
      ),
    );
  }
}
