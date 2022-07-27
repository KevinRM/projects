import 'package:flutter/material.dart';
import 'package:my_mind/constants.dart';
import 'package:my_mind/pages/app/notes_editor/components/base/base_component.dart';
import 'package:my_mind/pages/app/notes_editor/components/base/elements_buttons.dart';
import 'text_component.dart';
import 'text_supported_styles.dart';

class TextContent extends ChangeNotifier implements BaseComponent {
  final TextEditingController textEditingController = TextEditingController();
  bool isSelected = false;
  String text = "";
  int cursorPosStart = -1;
  int cursorPosEnd = -1;
  TextAlign aligment =
      SupportedStyles.aligment[SupportedStylesKeys.aligmentLeft]!;

  @override
  late int index;
  @override
  late Widget view;
  @override
  late ElementsButtons elementsButtons;

  TextContent(this.index) {
    view = TextComponent(model: this, key: UniqueKey());
    elementsButtons = ElementsButtons(content: this);
  }

  @override
  Widget build() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          elementsButtons,
          view,
        ],
      ),
    );
  }

  @override
  void changeSelectedState() {
    isSelected = !isSelected;
    notifyListeners();
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  bool isEmpty() {
    return textEditingController.text.isEmpty;
  }

  /// Se llama desde los botones del editor
  void applyAligment(SupportedStylesKeys style) {
    if (SupportedStyles.aligment.containsKey(style)) {
      aligment = SupportedStyles.aligment[style]!;
      notifyListeners();
    }
  }

  /// Se llama desde los botones del editor
  void applyStyle(SupportedStylesKeys style, TextSelection selection) {
    if (SupportedStyles.styles.containsKey(style)) {
      cursorPosStart = selection.start;
      cursorPosEnd = selection.end;

      String styleStr = SupportedStyles.symbol +
          SupportedStyles.styles[style]! +
          SupportedStyles.symbol;

      text = text.replaceRange(cursorPosStart, cursorPosStart, styleStr);

      cursorPosStart += styleStr.length;
      cursorPosEnd += styleStr.length;

      if (cursorPosEnd != cursorPosStart) {
        text = text.replaceRange(cursorPosEnd, cursorPosEnd, styleStr);
        cursorPosEnd += styleStr.length;
        cursorPosStart = cursorPosEnd;
      } else {
        cursorPosEnd = cursorPosStart;
      }

      checkTextIsFormatted(
          TextSelection.fromPosition(TextPosition(offset: cursorPosStart)));

      notifyListeners();
    }
  }

  /// Buscar todos los elementos de estilo en el texto
  /// y comprobar que esten bien formateados
  bool checkTextIsFormatted(TextSelection selection) {
    bool needRelocateCursor = false;

    cursorPosStart = selection.start;
    cursorPosEnd = selection.end;

    String textLeftCursor = text.substring(0, cursorPosStart);
    String textRightCursor = text.substring(cursorPosStart);

    textLeftCursor = checkFormat(textLeftCursor);
    textRightCursor = checkFormat(textRightCursor);

    cursorPosStart = textLeftCursor.length;
    cursorPosEnd = cursorPosStart;

    String newText = textLeftCursor + textRightCursor;

    // Si se aplicaron cambios hay que notificar para recolocar el cursor
    if (newText != text) {
      needRelocateCursor = true;
      text = newText;
    }

    return needRelocateCursor;
  }

  void relocateCursor() {
    // Primero se tiene que refrescar el widget y luego modificar la posicion del cursor
    textEditingController.selection =
        TextSelection.fromPosition(TextPosition(offset: cursorPosStart));
  }

  String checkFormat(String textToCheck) {
    String retry = "";
    // Hacemos iteraciones hasta que no se apliquen mas cambios al texto
    while (retry != textToCheck) {
      retry = textToCheck;

      // Comprobamos que los comandos esten bien formateados
      List<RegExpMatch> matches =
          SupportedStyles.regExpToCheckFormat.allMatches(textToCheck).toList();

      for (var i = matches.length - 1; i >= 0; i--) {
        RegExpMatch match = matches[i];
        // Descarta los simbolos de los extremos
        String matchStr =
            match.group(0)!.substring(1, match.group(0)!.length - 1);
        matchStr = matchStr.replaceAll(RegExp(r"(\/|\s)"), "");

        textToCheck =
            textToCheck.replaceRange(match.start + 1, match.end - 1, matchStr);
      }
    }

    // Eliminamos duplicados
    List<RegExpMatch> matches =
        SupportedStyles.regExpStyles.allMatches(textToCheck).toList();
    for (var i = matches.length - 1; i >= 0; i--) {
      String matchStr = matches[i].group(0)!;

      bool needUpdateText = false;
      // Comprobamos para cada estilo soportado si tiene mas de 1 match
      // Significa que esta duplicado
      for (var command in SupportedStyles.styles.values) {
        RegExp regExpDuplicates = RegExp(r"" + command);
        List<Match> commandMatches =
            regExpDuplicates.allMatches(matchStr).toList();

        if (commandMatches.length > 1) {
          needUpdateText = true;
          // Empezamos a eliminar desde el final para no tener conflicto con indices
          for (var i = commandMatches.length - 1; i >= 1; i--) {
            matchStr = matchStr.replaceRange(
                commandMatches[i].start, commandMatches[i].end, "");
          }
        }
      }

      if (needUpdateText) {
        textToCheck = textToCheck.replaceRange(
            matches[i].start, matches[i].end, matchStr);
      }
    }

    return textToCheck;
  }

  List<TextSpan> getStyledText() {
    List<TextSpan> listToReturn = [];
    String textCopy = text.toString();
    List<String> activeStyles = [];

    while (textCopy.isNotEmpty) {
      RegExpMatch? match = SupportedStyles.regExpStyles.firstMatch(textCopy);
      if (match == null) {
        // No hay estilos que aplicar o, si se abre una secuencia de comandos pero
        // no se cierra, se aplica a el resto del texto
        listToReturn.add(_getTextSpanStyled(textCopy, activeStyles));
        break;
      } else {
        // Obtenemos el comando de estilos
        String matchStr = match.group(0) ?? "";

        // Aplicamos estilo
        if (match.start > 0) {
          String subStr = textCopy.substring(0, match.start);
          listToReturn.add(_getTextSpanStyled(subStr, activeStyles));
        }

        // Actualizamos los estilos bien activando o desactivando
        activeStyles = SupportedStyles.parseCommand(activeStyles, matchStr);

        // Actualizamos la copia del texto para eliminar lo analizado ya
        textCopy = textCopy.substring(match.end);
      }
    }

    return listToReturn;
  }

  TextSpan _getTextSpanStyled(String value, List<String> styles) {
    return TextSpan(
      text: value,
      style: TextStyle(
          fontWeight:
              styles.contains(SupportedStyles.styles[SupportedStylesKeys.bold])
                  ? FontWeight.bold
                  : null,
          fontStyle: styles
                  .contains(SupportedStyles.styles[SupportedStylesKeys.italic])
              ? FontStyle.italic
              : null,
          decoration: styles.contains(
                  SupportedStyles.styles[SupportedStylesKeys.underline])
              ? TextDecoration.underline
              : null,
          color: Constants.paletteSelected["text"]!,
          decorationThickness: 4),
    );
  }
}
