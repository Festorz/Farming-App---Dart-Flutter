import 'package:flutter/material.dart';

class AppTextFormfield extends StatefulWidget {
  AppTextFormfield(
      {Key? key,
      this.hide = false,
      required this.controller,
      required this.hint,
      required this.icon,
      this.isPassword = false,
      this.color = Colors.white,
      this.lines = 1,
      this.type = TextInputType.text,
      this.showPassword = false})
      : super(key: key);

  final TextEditingController controller;
  final String hint;
  final IconData? icon;
  final Color color;
  bool hide;
  final bool isPassword;
  bool showPassword;
  final TextInputType type;
  final int lines;

  @override
  _AppTextFormfieldState createState() => _AppTextFormfieldState();
}

class _AppTextFormfieldState extends State<AppTextFormfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.type,
      validator: ((value) {
        if (value == null || value.isEmpty) {
          return 'Please fill in here...';
        }
        return null;
      }),
      controller: widget.controller,
      minLines: 1,
      // selectionControls: ,

      textCapitalization: TextCapitalization.sentences,
      maxLines: widget.lines,
      obscureText: widget.hide,
      decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                      widget.showPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.black),
                  onPressed: () {
                    setState(() {
                      widget.hide = !widget.hide;
                      widget.showPassword = !widget.showPassword;
                    });
                  })
              : null,
          // suffixIconColor: Colors.amber,
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(widget.icon, size: 15, color: Colors.black54),
          hintText: widget.hint,
          hintStyle: const TextStyle(color: Colors.black54),
          contentPadding: const EdgeInsets.all(3),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: widget.color, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: widget.color, width: 1.0)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 1.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 1.0))),
    );
  }
}
