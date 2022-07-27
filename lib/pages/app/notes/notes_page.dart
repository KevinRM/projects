import 'package:flutter/material.dart';
import 'package:my_mind/api/interfaces/base_element.dart';
import 'package:my_mind/api/models/note.model.dart';
import 'package:my_mind/constants.dart';
import 'package:my_mind/router/my_router.dart';
import 'package:my_mind/router/router_page_manager.dart';
import 'package:my_mind/shared_components/icon_with_text.dart';
import 'package:my_mind/states/language_state.dart';
import 'package:provider/provider.dart';

import '../../../shared_components/custom_divider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late LanguageState _languageState;
  List<NoteModel> notes = [];

  @override
  void initState() {
    super.initState();
    _languageState = context.read<LanguageState>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [buildMenuBar()],
    );
  }

  List<Widget> buildElements() {
    List<Widget> elemsToReturn = [];

    if (notes.isEmpty) {
      elemsToReturn.add(Text(_languageState.getText(TextKeys.txtHaveNotNotes)));
    }

    return elemsToReturn;
  }

  Widget buildMenuBar() {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Constants.appDefaultBorderRadius),
        color: Constants.paletteSelected["dark"],
      ),
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 70),
              child: Material(
                color: Colors.transparent,
                child: TextButton(
                  onPressed: () => RouterPageManager.of(context)
                      .goToPage(MyRouterPath.noteEditor(ElementType.note)),
                  child: IconWithText(
                      vertical: true,
                      icon: Icons.note_add_outlined,
                      text: _languageState.getText(TextKeys.txtNewNote)),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 70),
              child: Material(
                color: Colors.transparent,
                child: TextButton(
                  onPressed: () {},
                  child: IconWithText(
                      vertical: true,
                      icon: Icons.format_list_bulleted_outlined,
                      text: _languageState.getText(TextKeys.txtNewList)),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 70),
              child: Material(
                color: Colors.transparent,
                child: TextButton(
                  onPressed: () {},
                  child: IconWithText(
                      vertical: true,
                      icon: Icons.folder_open_outlined,
                      text: _languageState.getText(TextKeys.txtNewGroup)),
                ),
              ),
            ),
            CustomDivider(
              vertical: true,
              height: 30,
              colors: [
                Constants.paletteSelected["medium"]!,
                Constants.paletteSelected["medium"]!,
                Constants.paletteSelected["medium"]!,
              ],
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 70),
              child: Material(
                color: Colors.transparent,
                child: TextButton(
                  onPressed: () {},
                  child: IconWithText(
                      vertical: true,
                      icon: Icons.sort_by_alpha_outlined,
                      text: _languageState.getText(TextKeys.txtSort)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
