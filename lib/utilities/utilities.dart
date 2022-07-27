import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../shared_components/custom_spacer.dart';
import '../states/language_state.dart';

class UtilitiesFunctions {
  static String parseFilePath(String path) {
    return kIsWeb ? 'assets/$path' : path;
  }

  static DateFormat getDateFormatLocale() {
    switch (LanguageState.languageSelected) {
      case LanguagesAvailables.es:
        return DateFormat('dd MMMM yyyy', 'es_ES');
      case LanguagesAvailables.en:
        return DateFormat('MMMM dd, yyyy', 'en_US');
      default:
        return DateFormat('dd MMMM yyyy', 'es_ES');
    }
  }

  static String firsToUpper(String text) {
    if (RegExp(r"^\s*[a-zA-Z]").hasMatch(text)) {
      int startIndex = text.indexOf(RegExp(r"[a-zA-Z]"));
      return text.substring(startIndex, startIndex + 1).toUpperCase() +
          text.substring(startIndex + 1, text.length);
    } else {
      return text;
    }
  }

  // static void copyToClipboard(BuildContext context, String text) {
  //   Clipboard.setData(ClipboardData(text: text)).then((value) => showSnackbar(
  //       context,
  //       context.read<LanguageState>().getText(TextKeys.copiedToClipboard)));
  // }

  static Padding buildTextFormField(LanguageState languageState,
      TextInputType type, TextKeys title, String currValue,
      {Function(String)? onChange,
      Function(String?)? onSaved,
      Function()? onTap,
      Function(String)? onFieldSubmitted,
      String? Function(String?)? validator,
      Key? key,
      bool isRequired = false,
      Widget? suffix,
      bool obscureText = false,
      bool isReadonly = false,
      bool isDense = false,
      int? maxLines,
      InputDecoration? decoration,
      AutovalidateMode? autovalidateMode,
      EdgeInsets? padding}) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: TextFormField(
        key: key,
        initialValue: currValue,
        keyboardType: type,
        readOnly: isReadonly,
        maxLines: maxLines,
        obscureText: obscureText,
        autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
        decoration: decoration ??
            InputDecoration(
                labelText:
                    languageState.getText(title), // + (isRequired ? "*" : ""),
                border: const OutlineInputBorder(),
                suffixIcon: suffix,
                isDense: isDense),
        onTap: onTap,
        onChanged: onChange,
        onSaved: onSaved,
        onFieldSubmitted: onFieldSubmitted,
        validator: validator ??
            (String? value) {
              if (isRequired && (value == null || value.isEmpty)) {
                return languageState.getText(TextKeys.errRequiredField);
              }
              return null;
            },
      ),
    );
  }

  // static Padding buildDropdownFormField<T>(
  //   LanguageState languageState,
  //   List<T> itemsParam,
  //   TextKeys title, {
  //   T? selectedItem,
  //   bool isRequired = false,
  //   Function(T?)? onChange,
  //   Function(T?)? onSaved,
  // }) {
  //   List<DropdownMenuItem<T>> items =
  //       itemsParam.map<DropdownMenuItem<T>>((T value) {
  //     String textValue = value.toString().split(".")[1];
  //     return DropdownMenuItem<T>(
  //       value: value,
  //       child: Text(languageState.pareseTxt(textValue)),
  //     );
  //   }).toList();
  //   if (!isRequired) {
  //     items.insert(
  //         0,
  //         DropdownMenuItem<T>(
  //           value: null,
  //           child: Text(languageState.getText(TextKeys.empty)),
  //         ));
  //   }

  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: DropdownButtonFormField<T>(
  //         isExpanded: true,
  //         decoration: InputDecoration(
  //             border: const OutlineInputBorder(),
  //             label:
  //                 Text(languageState.getText(title) + (isRequired ? "*" : ""))),
  //         icon: const Icon(Icons.arrow_drop_down_outlined),
  //         elevation: 16,
  //         value: selectedItem ??
  //             (items.isNotEmpty && isRequired ? items[0].value : null),
  //         onChanged: onChange,
  //         onSaved: onSaved,
  //         items: items),
  //   );
  // }

  static void showAlertDialog(
      BuildContext context, String title, String message,
      {List<Widget>? actions}) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              elevation: 0,
              contentPadding: const EdgeInsets.all(0),
              backgroundColor: Constants.paletteSelected["dark"],
              title: Text(title),
              content: Container(
                constraints: const BoxConstraints(maxWidth: 512),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  message,
                ),
              ),
              actions: actions ??
                  [
                    TextButton(
                      child: const Text("Close"),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
            ));
  }

  static Future<bool> showConfirmDialog(BuildContext context,
      LanguageState languageState, String title, String message) async {
    return await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                elevation: 0,
                contentPadding: const EdgeInsets.all(0),
                backgroundColor: Constants.paletteSelected["dark"],
                title: Text(title),
                content: Container(
                  constraints: const BoxConstraints(maxWidth: 512),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    message,
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text(
                        languageState.getText(TextKeys.txtConfirmDialogBack)),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                  TextButton(
                    child: Text(languageState
                        .getText(TextKeys.txtConfirmDialogContinue)),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  )
                ],
              );
            }) ??
        false;
  }

  static void showSnackbar(BuildContext context, String message,
      {bool success = false, bool error = false}) {
    SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: success
          ? Constants.paletteSelected["medium"]
          : error
              ? Constants.paletteSelected["error"]
              : Constants.paletteSelected["warning"],
      width: 400,
      content: AutoSizeText(
        message,
        minFontSize: Constants.appBarFontSize,
        textAlign: TextAlign.center,
        // style: TextStyle(color: Constants.paletteSelected["text"]),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.appDefaultBorderRadius),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showLoadingIndicatorInDialog(
      BuildContext context, String? message) {
    showDialog(
      context: context,
      barrierColor: const Color(0xffdcd1e8).withOpacity(0.67),
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        elevation: 0,
        contentPadding: const EdgeInsets.all(0),
        backgroundColor: Constants.paletteSelected["dark"],
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Constants.paletteSelected["light"]!, width: 1.5),
            borderRadius:
                BorderRadius.circular(Constants.appDefaultBorderRadius)),
        content: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const CustomSpacer(verticalSpace: 20),
              Text(message ?? ""),
            ],
          ),
        ),
      ),
    );
  }

  // static void openURL(String url) async {
  //   await launch(url);
  // }
}
