import 'package:edukasi_pot/ui/shared/shared.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final Key key;
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String helperText;
  final String initialValue;
  final IconData icon;
  final TextInputType inputType;
  final bool obscureText;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  final Function onIconTapped;

  const CustomTextField(
      {this.key,
      this.controller,
      this.hintText,
      this.labelText,
      this.helperText,
      this.initialValue,
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
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      controller: widget.controller,
      keyboardType: widget.inputType,
      obscureText: widget.obscureText ?? false,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      initialValue: widget.initialValue,
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

class CustomPasswordField extends StatefulWidget {
  final Key key;
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String helperText;
  final String initialValue;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  const CustomPasswordField(
      {this.key,
      this.controller,
      this.hintText,
      this.labelText,
      this.helperText,
      this.initialValue,
      this.textInputAction,
      this.focusNode,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted})
      : super(key: key);

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      key: widget.key,
      controller: widget.controller,
      hintText: widget.hintText,
      focusNode: widget.focusNode,
      obscureText: _obscureText,
      icon: _obscureText ? Icons.visibility : Icons.visibility_off,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      initialValue: widget.initialValue,
      onIconTapped: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
    );
  }
}
