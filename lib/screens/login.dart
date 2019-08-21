import 'package:edukasi_pot/helpers/helpers.dart';
import 'package:edukasi_pot/shared/shared.dart';
import 'package:edukasi_pot/shared/ui_helper.dart';
import 'package:edukasi_pot/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                      child: Image.asset('assets/graphics/edukasi-logo.png')),
                  verticalSpaceLarge(context),
                  AuthForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  String _email, _password;
  bool _isLoading = false;

  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value == '')
      return 'Email must not be empty';
    else if (!regex.hasMatch(value)) return 'Enter Valid Email';
    return null;
  }

  String _validatePassword(String value) {
    if (value == '') return 'Password must not be empty';
    return null;
  }

  void _showInSnackBar(BuildContext context, String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(value),
    ));
  }

  void _handleLogin(BuildContext context) async {
    final FormState form = _formKey.currentState;

    setState(() {
      _isLoading = true;
    });

    if (form.validate()) {
      form.save();
      try {
        await login(context, _email, _password);
      } catch (e) {
        _showInSnackBar(context, "Something's wrong!!");
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthMedium(context),
      padding: edgeSymmetric(context, 3, 5),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppTextField(
              hintText: "Email",
              validator: _validateEmail,
              focusNode: _emailFocus,
              inputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onSaved: (val) => _email = val,
              onFieldSubmitted: (value) {
                _emailFocus.unfocus();
                FocusScope.of(context).requestFocus(_passwordFocus);
              },
            ),
            verticalSpaceSmall(context),
            AppPasswordField(
              hintText: "Password",
              validator: _validatePassword,
              focusNode: _passwordFocus,
              textInputAction: TextInputAction.done,
              onSaved: (val) => _password = val,
              onFieldSubmitted: (value) {
                _passwordFocus.unfocus();
              },
            ),
            verticalSpaceMedium(context),
            // _isLoading
            //     ? Loader()
            //     : RaisedButton(
            //         child: Text(
            //           'Log in',
            //           style: TextStyle(fontSize: 18.0),
            //         ),
            //         onPressed: () => _handleLogin(context),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(4),
            //         ),
            //         padding: edgeSymmetric(context, 4, 1.8),
            //         color: Theme.of(context).primaryColor,
            //         textColor:
            //             Theme.of(context).primaryTextTheme.button.color,
            //       ),
            _isLoading
                ? Loader()
                : Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF5B6CEC),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _handleLogin(context),
                        borderRadius: BorderRadius.circular(4.0),
                        child: Center(
                          child: Container(
                            padding: edgeVertical(context, 3),
                            child: _isLoading
                                ? CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  )
                                : Text(
                                    'Log in',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold
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
    );
  }
}
