import 'package:flutter/material.dart';
import 'package:my_mind/constants.dart';
import 'package:my_mind/pages/app/notes_editor/components/text/text_content.dart';
import 'package:my_mind/pages/app/notes_editor/states/editor_state.dart';
import 'package:my_mind/states/language_state.dart';
import 'package:provider/provider.dart';

class TextComponent extends StatefulWidget {
  const TextComponent({Key? key, required this.model}) : super(key: key);
  final TextContent model;

  @override
  State<TextComponent> createState() => _TextComponentState();
}

class _TextComponentState extends State<TextComponent> {
  late LanguageState _languageState;
  late EditorState _editorState;
  late TextContent _content;

  final FocusNode _focusNode = FocusNode();

  bool _showLimitLength = false;

  @override
  void initState() {
    super.initState();
    _languageState = context.read<LanguageState>();
    _editorState = context.read<EditorState>();
    _content = widget.model;
    _content.addListener(refresh);
  }

  @override
  void dispose() {
    _content.removeListener(refresh);
    super.dispose();
  }

  void refresh() {
    setState(() {
      // Es necesario para obtener de nuevo el texto una vez modificado los comandos de estilo
      _content.textEditingController.text = _content.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("=> Build: " + _content.index.toString());
    bool showEditElementButtons =
        context.select((EditorState state) => state.isShowingEditElements());
    if (_content.isSelected) {
      _focusNode.requestFocus();
      // Es necesario para relocalizar el cursor despues de pulsar un boton de estilo
      _content.relocateCursor();
    } else {
      _focusNode.unfocus();
    }

    Widget wdgReturn;

    if (_content.isSelected) {
      wdgReturn = Container(
        decoration: _content.isSelected
            ? BoxDecoration(
                border: Border.all(color: Constants.paletteSelected["medium"]!),
              )
            : null,
        child: Column(
          children: [
            TextField(
              focusNode: _focusNode,
              controller: _content.textEditingController,
              maxLines: null,
              textAlign: _content.aligment,
              decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                  border: InputBorder.none),
              scrollPadding: const EdgeInsets.all(50),
              maxLength:
                  _showLimitLength ? Constants.maxNoteTextElementLenght : null,
              onChanged: (String value) {
                _content.text = value;
                bool relocate = _content.checkTextIsFormatted(
                    _content.textEditingController.selection);
                if (relocate) {
                  refresh();
                  _content.relocateCursor();
                }
                checkValidators();
              },
            ),
          ],
        ),
      );
    } else {
      wdgReturn = SelectableText.rich(
        TextSpan(
            children: _content.text.isEmpty && !_content.isSelected
                ? [
                    TextSpan(
                        text: _languageState
                            .getText(TextKeys.txtTextElementPlaceholder))
                  ]
                : _content.getStyledText()),
        onTap: () =>
            _editorState.changeElementSelected(newIndexElement: _content.index),
        textAlign: _content.aligment,
        style: TextStyle(color: Constants.paletteSelected["text"]),
      );

      // Working to support lists
      // wdgReturn = SelectableText.rich(
      //   TextSpan(children: [
      //     TextSpan(children: [
      //       TextSpan(text: "     \u2022 ", style: TextStyle(fontSize: 20)),
      //       TextSpan(text: "     \u002D ", style: TextStyle(fontSize: 20)),
      //       TextSpan(text: "Elemento 1")
      //     ]),
      //     TextSpan(text: "\n"),
      //     TextSpan(text: "Elemento 2"),
      //     TextSpan(text: "\n"),
      //     TextSpan(text: "Elemento 3"),
      //   ]),
      //   // onTap: () =>
      //   //     _editorState.changeElementSelected(newIndexElement: _content.index),
      //   textAlign: _content.aligment,
      //   style: TextStyle(color: Constants.paletteSelected["text"]),
      // );
    }

    return Container(
      decoration: showEditElementButtons
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Constants.paletteSelected["medium"]!),
                left: BorderSide(color: Constants.paletteSelected["medium"]!),
                right: BorderSide(color: Constants.paletteSelected["medium"]!),
              ),
            )
          : null,
      child: Row(
        children: [
          Expanded(
            child: Padding(
                padding: showEditElementButtons
                    ? const EdgeInsets.all(12.0)
                    : const EdgeInsets.all(0.0),
                child: wdgReturn),
          ),
        ],
      ),
    );
  }

  void checkValidators() {
    if (_content.text.length >= Constants.maxNoteTextElementLenght - 200 &&
        !_showLimitLength) {
      _showLimitLength = true;
      refresh();
    } else if (_content.text.length <
            Constants.maxNoteTextElementLenght - 200 &&
        _showLimitLength) {
      _showLimitLength = false;
      refresh();
    }
  }

  // void relocateCursor() {
  //   // Tiene que ser en este orden para que primero modifique el texto y luego
  //   // ya asigne el cursor a la posicion correcta
  //   refresh();
  //   _textEditingController.selection = TextSelection.fromPosition(
  //       TextPosition(offset: _content.cursorPosStart));
  // }
}
