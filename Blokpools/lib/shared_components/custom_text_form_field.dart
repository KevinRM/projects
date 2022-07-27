import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.type,
    required this.title,
    this.currValue,
    this.padding,
    this.isReadonly = false,
    this.isRequired = false,
    this.autofocus = false,
    this.decoration,
    this.suffix,
    this.onTap,
    this.onChange,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  final EdgeInsets? padding;
  final String? currValue;
  final TextInputType type;
  final bool isReadonly;
  final bool isRequired;
  final bool autofocus;
  final String title;
  final InputDecoration? decoration;
  final Widget? suffix;
  final Function()? onTap;
  final Function(String)? onChange;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: TextFormField(
        key: key,
        initialValue: currValue,
        keyboardType: type,
        readOnly: isReadonly,
        maxLines: null,
        autofocus: autofocus,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: decoration ??
            InputDecoration(
              labelText: title + (isRequired ? "*" : ""),
              border: const OutlineInputBorder(),
              suffixIcon: suffix,
            ),
        onTap: onTap,
        onChanged: onChange,
        onSaved: onSaved,
        onFieldSubmitted: (value) async {},
        validator: validator ??
            (String? value) {
              if (isRequired && (value == null || value.isEmpty)) {
                return "This field is required";
              }
              return null;
            },
      ),
    );
  }
}
