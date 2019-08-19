import 'package:edukasi_pot/shared/ui_helper.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final Key key;
  final String hintText;
  final String labelText;
  final String helperText;
  final IconData icon;
  final TextInputType inputType;
  final bool obscureText;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  final Function onIconTapped;

  const AppTextField(
      {this.key,
      this.hintText,
      this.labelText,
      this.helperText,
      this.icon,
      this.inputType,
      this.obscureText,
      this.textInputAction,
      this.focusNode,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.onIconTapped})
      : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      keyboardType: widget.inputType,
      obscureText: widget.obscureText ?? false,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        fillColor: Colors.white,
        contentPadding: edgeSymmetric(context, 2, 3),
        border: InputBorder.none,
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: GestureDetector(
          onTap: widget.onIconTapped,
          child: Icon(
            widget.icon,
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}

class AppPasswordField extends StatefulWidget {
  final Key key;
  final String hintText;
  final String labelText;
  final String helperText;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  const AppPasswordField(
      {this.key,
      this.hintText,
      this.labelText,
      this.helperText,
      this.textInputAction,
      this.focusNode,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted})
      : super(key: key);

  @override
  _AppPasswordFieldState createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      key: widget.key,
      hintText: widget.hintText,
      focusNode: widget.focusNode,
      obscureText: _obscureText,
      icon: _obscureText ? Icons.visibility : Icons.visibility_off,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      onIconTapped: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
    );
  }
}
