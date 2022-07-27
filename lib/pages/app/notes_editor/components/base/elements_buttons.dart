import 'package:flutter/material.dart';
import 'package:my_mind/pages/app/notes_editor/components/base/base_component.dart';
import 'package:my_mind/pages/app/notes_editor/states/editor_state.dart';
import 'package:my_mind/states/language_state.dart';
import 'package:my_mind/utilities/utilities.dart';
import 'package:provider/provider.dart';

import '../../../../../constants.dart';
import '../../../../../shared_components/icon_with_text.dart';

class ElementsButtons extends StatefulWidget {
  const ElementsButtons({Key? key, required this.content}) : super(key: key);

  final BaseComponent content;

  @override
  State<ElementsButtons> createState() => _ElementsButtonsState();
}

class _ElementsButtonsState extends State<ElementsButtons> {
  late final LanguageState _languageState;
  late final EditorState _editorState;
  final double _defaultIconSize = 25;
  final double _defaultFontSize = 12;
  final double _minWidthButtonStyle = 65;

  @override
  void initState() {
    super.initState();
    _languageState = context.read<LanguageState>();
    _editorState = context.read<EditorState>();
  }

  @override
  Widget build(BuildContext context) {
    bool show =
        context.select((EditorState state) => state.isShowingEditElements());
    print("EditorElementsButtons rebuild: " + widget.content.index.toString());
    return !show
        ? const SizedBox()
        : Container(
            decoration: BoxDecoration(
              color: Constants.paletteSelected["dark"],
              border: Border(
                top: BorderSide(color: Constants.paletteSelected["medium"]!),
                left: BorderSide(color: Constants.paletteSelected["medium"]!),
                right: BorderSide(color: Constants.paletteSelected["medium"]!),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 8.0, right: 8.0, bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...buildElementButtons(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget buildStyleButton(Widget child) {
    return Material(
      color: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: _minWidthButtonStyle),
        child: child,
      ),
    );
  }

  List<Widget> buildElementButtons() {
    List<Widget> elements = [];

    // Insertar
    elements.add(buildStyleButton(PopupMenuButton(
        child: IconWithText(
            vertical: true,
            fontSize: _defaultFontSize,
            iconSize: _defaultIconSize,
            icon: Icons.add_outlined,
            text: _languageState.getText(TextKeys.txtNew)),
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Constants.appDefaultBorderRadius),
              topRight: Radius.circular(Constants.appDefaultBorderRadius),
              bottomLeft: Radius.circular(Constants.appDefaultBorderRadius),
              bottomRight: Radius.circular(Constants.appDefaultBorderRadius),
            ),
            side: BorderSide(
                color: Constants.paletteSelected["medium"]!, width: 1.5)),
        offset: const Offset(0, 60),
        tooltip: "",
        itemBuilder: (context) {
          return [
            // Texto
            PopupMenuItem(
              child: ListTile(
                leading:
                    Icon(Icons.short_text_outlined, size: _defaultIconSize),
                title: Text(_languageState.getText(TextKeys.txtAddTextElement)),
              ),
              onTap: () =>
                  _editorState.newElement(position: widget.content.index + 1),
            ),
            // Lista
            PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.format_list_bulleted_outlined,
                      size: _defaultIconSize),
                  title: Text(_languageState.getText(TextKeys.txtNewList)),
                ),
                onTap: () => UtilitiesFunctions.showSnackbar(
                    context, _languageState.getText(TextKeys.txtAvailableSoon)))
          ];
        })));

    // Opciones
    elements.add(Material(
      color: Colors.transparent,
      child: PopupMenuButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: buildStyleButton(IconWithText(
                vertical: true,
                fontSize: _defaultFontSize,
                iconSize: _defaultIconSize,
                icon: Icons.more_vert_outlined,
                text: _languageState.getText(TextKeys.txtOptions))),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Constants.appDefaultBorderRadius),
                topRight: Radius.circular(Constants.appDefaultBorderRadius),
                bottomLeft: Radius.circular(Constants.appDefaultBorderRadius),
                bottomRight: Radius.circular(Constants.appDefaultBorderRadius),
              ),
              side: BorderSide(
                  color: Constants.paletteSelected["medium"]!, width: 1.5)),
          offset: const Offset(0, 60),
          tooltip: "",
          onSelected: (value) async {
            switch (value) {
              case "move_up":
                _editorState.moveElement(widget.content.index, true);
                break;
              case "move_down":
                _editorState.moveElement(widget.content.index, false);
                break;
              case "delete":
                if (await UtilitiesFunctions.showConfirmDialog(
                    context,
                    _languageState,
                    _languageState.getText(TextKeys.txtDelete),
                    _languageState.getText(TextKeys.txtConfirmDelete))) {
                  _editorState.deleteElement(position: widget.content.index);
                }
                break;
            }
          },
          itemBuilder: (context) {
            return [
              // Si no es el primer elemento, permitimos moverlo hacia arriba
              PopupMenuItem(
                enabled: widget.content.index > 0,
                child: ListTile(
                  leading:
                      Icon(Icons.arrow_upward_outlined, size: _defaultIconSize),
                  enabled: widget.content.index > 0,
                  title: Text(_languageState.getText(TextKeys.txtMove)),
                ),
                value: "move_up",
              ),
              // Si no es el ultimo elemento, permitimos moverlo hacia abajo
              PopupMenuItem(
                enabled:
                    widget.content.index < _editorState.countElements() - 1,
                child: ListTile(
                  leading: Icon(Icons.arrow_downward_outlined,
                      size: _defaultIconSize),
                  enabled:
                      widget.content.index < _editorState.countElements() - 1,
                  title: Text(_languageState.getText(TextKeys.txtMove)),
                ),
                value: "move_down",
              ),
              // Si no es el ultimo elemento de la nota, permitimos eliminarlo
              PopupMenuItem(
                enabled: _editorState.countElements() > 1,
                child: ListTile(
                  leading: Icon(Icons.delete_outline_outlined,
                      size: _defaultIconSize),
                  enabled: _editorState.countElements() > 1,
                  title: Text(_languageState.getText(TextKeys.txtDelete)),
                ),
                value: "delete",
              )
            ];
          }),
    ));
    return elements;
  }
}
