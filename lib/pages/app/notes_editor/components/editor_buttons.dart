import 'package:flutter/material.dart';
import 'package:my_mind/pages/app/notes_editor/components/base/base_component.dart';
import 'package:my_mind/pages/app/notes_editor/states/editor_state.dart';
import 'package:my_mind/shared_components/custom_divider.dart';
import 'package:my_mind/states/language_state.dart';
import 'package:my_mind/utilities/size_config.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../shared_components/icon_with_text.dart';
import 'text/text_content.dart';
import 'text/text_supported_styles.dart';

class EditorButtons extends StatefulWidget {
  const EditorButtons({Key? key}) : super(key: key);

  @override
  State<EditorButtons> createState() => _EditorButtonsState();
}

class _EditorButtonsState extends State<EditorButtons> {
  late final LanguageState _languageState;
  late final EditorState _editorState;
  final double _defaultIconSize = 25;
  final double _defaultFontSize = 12;
  final double _minWidthButtonStyle = 65;

  BaseComponent? elementSelected;
  bool _showingEditElements = false;

  @override
  void initState() {
    super.initState();
    _languageState = context.read<LanguageState>();
    _editorState = context.read<EditorState>();
  }

  @override
  Widget build(BuildContext context) {
    print("Style rebuild");
    // Listen only fields instead all state
    elementSelected =
        context.select((EditorState value) => value.getElementSelected());
    _showingEditElements =
        context.select((EditorState value) => value.isShowingEditElements());
    return Container(
      color: Constants.paletteSelected["dark"],
      child: Padding(
        padding: const EdgeInsets.only(
            top: 12.0, left: 8.0, right: 8.0, bottom: 2.0),
        child: Row(
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...buildTextStyleButtons(),
                    ...buildTextAligmentButtons(),
                    ...buildGeneralButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(Widget child) {
    return Material(
      color: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: _minWidthButtonStyle),
        child: child,
      ),
    );
  }

  List<Widget> buildGeneralButtons() {
    List<Widget> elements = [
      // Edit
      buildButton(
        TextButton(
          onPressed: () {
            _showingEditElements
                ? _editorState.hideEditElements()
                : _editorState.showEditElements();
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) =>
                ScaleTransition(
              scale: animation,
              child: child,
            ),
            child: _showingEditElements
                ? IconWithText(
                    vertical: true,
                    fontSize: _defaultFontSize,
                    iconSize: _defaultIconSize,
                    icon: Icons.check_box_outlined,
                    text: _languageState.getText(TextKeys.txtApply),
                    key: const ValueKey(2),
                  )
                : IconWithText(
                    vertical: true,
                    fontSize: _defaultFontSize,
                    iconSize: _defaultIconSize,
                    icon: Icons.dashboard_customize_outlined,
                    text: _languageState.getText(TextKeys.txtEdit),
                    key: const ValueKey(1),
                  ),
          ),
        ),
      ),
      // Help
      buildButton(
        TextButton(
          onPressed: () async {
            print("Mostrar ayuda");
          },
          child: IconWithText(
              vertical: true,
              fontSize: _defaultFontSize,
              iconSize: _defaultIconSize,
              icon: Icons.help_center_outlined,
              text: _languageState.getText(TextKeys.txtHelp)),
        ),
      ),
    ];

    return elements;
  }

  List<Widget> buildTextStyleButtons() {
    if (elementSelected.runtimeType != TextContent) {
      return [];
    }

    bool showResponsive = SizeConfig.isVerySmallScreen(context);

    List<Widget> elements = [
      // buildStyleButton(
      //   TextButton(
      //     onPressed: () {},
      //     child: IconWithText(
      //         vertical: true,
      //         fontSize: _defaultFontSize,
      //         iconSize: _defaultIconSize,
      //         icon: Icons.format_color_text_outlined,
      //         text: _languageState.getText(TextKeys.txtColor)),
      //   ),
      // ),
      buildButton(
        TextButton(
          onPressed: () {
            print(
                "Mostrar popup con diferentes tamaños, Titulo, Subtitulo, Normal");
          },
          child: IconWithText(
              vertical: true,
              fontSize: _defaultFontSize,
              iconSize: _defaultIconSize,
              icon: Icons.format_size_outlined,
              text: _languageState.getText(TextKeys.txtSize)),
        ),
      ),
      buildButton(
        TextButton(
          onPressed: () {
            (elementSelected as TextContent).applyStyle(
                SupportedStylesKeys.bold,
                (elementSelected as TextContent)
                    .textEditingController
                    .selection);
          },
          child: IconWithText(
              vertical: true,
              fontSize: _defaultFontSize,
              iconSize: _defaultIconSize,
              icon: Icons.format_bold_outlined,
              text: _languageState.getText(TextKeys.txtBold)),
        ),
      ),
      buildButton(
        TextButton(
          onPressed: () {
            (elementSelected as TextContent).applyStyle(
                SupportedStylesKeys.italic,
                (elementSelected as TextContent)
                    .textEditingController
                    .selection);
          },
          child: IconWithText(
              vertical: true,
              fontSize: _defaultFontSize,
              iconSize: _defaultIconSize,
              icon: Icons.format_italic_outlined,
              text: _languageState.getText(TextKeys.txtItalic)),
        ),
      ),
      buildButton(
        TextButton(
          onPressed: () {
            (elementSelected as TextContent).applyStyle(
                SupportedStylesKeys.underline,
                (elementSelected as TextContent)
                    .textEditingController
                    .selection);
          },
          child: IconWithText(
              vertical: true,
              fontSize: _defaultFontSize,
              iconSize: _defaultIconSize,
              icon: Icons.format_underline_outlined,
              text: _languageState.getText(TextKeys.txtUnderline)),
        ),
      ),
    ];

    if (showResponsive) {
      return [
        buildButton(PopupMenuButton(
          child: IconWithText(
              vertical: true,
              fontSize: _defaultFontSize,
              iconSize: _defaultIconSize,
              icon: Icons.style_outlined,
              text: _languageState.getText(TextKeys.txtStyle)),
          offset: const Offset(0, 60),
          tooltip: "",
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Constants.appDefaultBorderRadius),
                topRight: Radius.circular(Constants.appDefaultBorderRadius),
                bottomLeft: Radius.circular(Constants.appDefaultBorderRadius),
                bottomRight: Radius.circular(Constants.appDefaultBorderRadius),
              ),
              side: BorderSide(
                  color: Constants.paletteSelected["medium"]!, width: 1.5)),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                  enabled: false,
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: elements,
                  ))
            ];
          },
        )),
        CustomDivider(
          height: _defaultIconSize,
          colors: [
            Constants.paletteSelected["medium"]!,
            Constants.paletteSelected["medium"]!
          ],
          vertical: true,
        ),
      ];
    } else {
      return [
        ...elements,
        CustomDivider(
          height: _defaultIconSize,
          colors: [
            Constants.paletteSelected["medium"]!,
            Constants.paletteSelected["medium"]!
          ],
          vertical: true,
        ),
      ];
    }
  }

  List<Widget> buildTextAligmentButtons() {
    if (elementSelected.runtimeType != TextContent) {
      return [];
    }

    return [
      buildButton(PopupMenuButton(
        child: IconWithText(
            vertical: true,
            fontSize: _defaultFontSize,
            iconSize: _defaultIconSize,
            icon: Icons.align_horizontal_left_outlined,
            text: _languageState.getText(TextKeys.txtAligment)),
        offset: const Offset(0, 60),
        tooltip: "",
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Constants.appDefaultBorderRadius),
              topRight: Radius.circular(Constants.appDefaultBorderRadius),
              bottomLeft: Radius.circular(Constants.appDefaultBorderRadius),
              bottomRight: Radius.circular(Constants.appDefaultBorderRadius),
            ),
            side: BorderSide(
                color: Constants.paletteSelected["medium"]!, width: 1.5)),
        itemBuilder: (BuildContext context) {
          return [
            // Izquierda
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.align_horizontal_left_outlined,
                    size: _defaultIconSize),
                title: Text(_languageState.getText(TextKeys.txtLeft)),
              ),
              onTap: () => (elementSelected as TextContent)
                  .applyAligment(SupportedStylesKeys.aligmentLeft),
            ),
            // Centro
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.align_horizontal_center_outlined,
                    size: _defaultIconSize),
                title: Text(_languageState.getText(TextKeys.txtCenter)),
              ),
              onTap: () => (elementSelected as TextContent)
                  .applyAligment(SupportedStylesKeys.aligmentCenter),
            ),
            // Derecha
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.align_horizontal_right_outlined,
                    size: _defaultIconSize),
                title: Text(_languageState.getText(TextKeys.txtRight)),
              ),
              onTap: () => (elementSelected as TextContent)
                  .applyAligment(SupportedStylesKeys.aligmentRight),
            ),
          ];
        },
      )),
      CustomDivider(
        height: _defaultIconSize,
        colors: [
          Constants.paletteSelected["medium"]!,
          Constants.paletteSelected["medium"]!
        ],
        vertical: true,
      ),
    ];
  }
}
