import 'package:flutter/material.dart';

class TextFormFieldLogin extends StatefulWidget {
  const TextFormFieldLogin({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.type,
  }) : super(key: key);

  final String labelText;
  final TextEditingController controller;
  final TextInputType type;
  @override
  State<TextFormFieldLogin> createState() => _TextFormFieldLoginState();
}

class _TextFormFieldLoginState extends State<TextFormFieldLogin> {
  late bool isTextFormPassword;
  bool isHidePassword = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.type == TextInputType.visiblePassword) {
        isTextFormPassword = true;
      } else {
        isTextFormPassword = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: isTextFormPassword ? isHidePassword : false,
      keyboardType: widget.type,
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Esse campo e obrigatório";
        }
      },
      decoration: InputDecoration(
        suffixIcon: isTextFormPassword
            ? IconButton(
                icon: Icon(
                  isHidePassword ? Icons.visibility_off : Icons.visibility,
                  color: const Color.fromRGBO(255, 176, 102, 1),
                ),
                onPressed: () {
                  setState(() {
                    isHidePassword = !isHidePassword;
                  });
                },
              )
            : null,
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 75, 72, 72),
          fontSize: 15.0,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromRGBO(255, 176, 102, 1)),
          borderRadius: BorderRadius.circular(2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(255, 176, 102, 1),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(255, 176, 102, 1),
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
