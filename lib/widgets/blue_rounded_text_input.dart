import 'package:flutter/material.dart';

class BlueRoundedTextInput extends StatelessWidget {
  BlueRoundedTextInput({
    required this.hint,
    this.icon,
    this.onSaved,
    this.obscureText = false,
    this.textInputType,
    this.minLines,
    this.maxLines,
    this.initialValue,
    this.readOnly = false
  });

  final String? hint;
  final IconData? icon;
  final void Function(String?)? onSaved;
  final bool obscureText;
  final TextInputType? textInputType;
  final int? minLines;
  final int? maxLines;
  final bool readOnly;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      initialValue: initialValue,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
                color: Colors.lightBlue,
                width: 0.5
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
                color: Colors.lightBlue,
                width: 2
            )
        ),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: icon != null ? Icon(
          icon,
          color: Colors.lightBlue,
        ) : null,
        hintText: hint,
      ),
      minLines: (textInputType == TextInputType.multiline) ? 2 : minLines,
      maxLines: (obscureText || maxLines == null) ? 1 : maxLines,
      keyboardType: textInputType,
      obscureText: obscureText,
      onSaved: onSaved,
    );
  }
}