import 'package:auto_size_text/auto_size_text.dart';
import 'package:evogalaxy/constants.dart';
import 'package:evogalaxy/states/language_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilitiesFunctions {
  static String parseFilePath(String path) {
    return kIsWeb ? 'assets/$path' : path;
  }

  static void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text)).then((value) => showSnackbar(
        context,
        context.read<LanguageState>().getText(TextKeys.copiedToClipboard)));
  }

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static int getNumColumns(BuildContext context) {
    // print("Width: " + MediaQuery.of(context).size.width.toString());
    double _width = MediaQuery.of(context).size.width;
    if (isSmallScreen(context) || _width <= 1024) {
      return 1;
    } else {
      return 2;
    }
  }

  static Padding buildTextFormField(LanguageState languageState,
      TextInputType type, TextKeys title, String currValue,
      {Function(String)? onChange,
      Function(String?)? onSaved,
      Function()? onTap,
      String? Function(String?)? validator,
      Key? key,
      bool isRequired = false,
      Widget? suffix,
      bool isReadonly = false,
      InputDecoration? decoration,
      EdgeInsets? padding}) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: TextFormField(
        key: key,
        initialValue: currValue,
        keyboardType: type,
        readOnly: isReadonly,
        maxLines: null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: decoration ??
            InputDecoration(
              labelText: languageState.getText(title) + (isRequired ? "*" : ""),
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
                return languageState.getText(TextKeys.requiredField);
              }
              return null;
            },
      ),
    );
  }

  static Padding buildDropdownFormField<T>(
    LanguageState languageState,
    List<T> itemsParam,
    TextKeys title, {
    T? selectedItem,
    bool isRequired = false,
    Function(T?)? onChange,
    Function(T?)? onSaved,
  }) {
    List<DropdownMenuItem<T>> items =
        itemsParam.map<DropdownMenuItem<T>>((T value) {
      String textValue = value.toString().split(".")[1];
      return DropdownMenuItem<T>(
        value: value,
        child: Text(languageState.pareseTxt(textValue)),
      );
    }).toList();
    if (!isRequired) {
      items.insert(
          0,
          DropdownMenuItem<T>(
            value: null,
            child: Text(languageState.getText(TextKeys.empty)),
          ));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<T>(
          isExpanded: true,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label:
                  Text(languageState.getText(title) + (isRequired ? "*" : ""))),
          icon: const Icon(Icons.arrow_drop_down_outlined),
          elevation: 16,
          value: selectedItem ??
              (items.isNotEmpty && isRequired ? items[0].value : null),
          onChanged: onChange,
          onSaved: onSaved,
          items: items),
    );
  }

  static void showAlertDialog(
      BuildContext context, String title, String message,
      {List<Widget>? actions}) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Text(
                message,
              ),
              elevation: 24.0,
              actions: actions ??
                  [
                    TextButton(
                      child: const Text("Vale"),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
            ));
  }

  static void showSnackbar(BuildContext context, String message,
      {bool success = false, bool error = false}) {
    SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: success
          ? Constants.successColor
          : error
              ? Constants.dangerColor
              : Constants.paletteSelected["accent"],
      width: 400,
      content: AutoSizeText(
        message,
        minFontSize: Constants.appBarFontSize,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Constants.textColor),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void openURL(String url) async {
    await launch(url);
  }
}
