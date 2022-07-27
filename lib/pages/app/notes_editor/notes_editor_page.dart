import 'package:flutter/material.dart';
import 'package:my_mind/api/interfaces/base_element.dart';
import 'package:my_mind/constants.dart';
import 'package:my_mind/pages/app/notes_editor/components/editor_buttons.dart';
import 'package:my_mind/pages/app/notes_editor/states/editor_state.dart';
import 'package:my_mind/pages/app/notes_editor/components/editor_top_bar.dart';
import 'package:my_mind/shared_components/custom_divider.dart';
import 'package:provider/provider.dart';

class NotesEditorPage extends StatefulWidget {
  const NotesEditorPage({Key? key, required this.elementType, this.elementId})
      : super(key: key);

  final ElementType elementType;
  final String? elementId;

  @override
  State<NotesEditorPage> createState() => _NotesEditorPageState();
}

class _NotesEditorPageState extends State<NotesEditorPage> {
  final EditorState _editorState = EditorState();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Cargamos en funcion del tipo. Si recibe parametro cargamos de BBDD los datos
    loadElement();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: MultiProvider(
          providers: [ChangeNotifierProvider.value(value: _editorState)],
          child: Column(
            children: [
              const EditorTopBar(),
              CustomDivider(
                colors: [
                  Constants.paletteSelected["background"]!,
                  Constants.paletteSelected["background"]!,
                ],
                margin: 0,
              ),
              const EditorButtons(),
              buildBody()
            ],
          ),
        )),
      ),
    );
  }

  void loadElement() async {
    if (widget.elementId == null) {
      _editorState.newElement();
    } else {
      // TODO:
    }
  }

  Widget buildBody() {
    return Expanded(
      child: GestureDetector(
        onTap: () => _editorState.changeElementSelected(),
        child: Container(
          decoration: BoxDecoration(
            border:
                Border.all(width: 5, color: Constants.paletteSelected["dark"]!),
          ),
          padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 100),
          child: Consumer<EditorState>(builder: (context, value, child) {
            print("Editor page consumer: " + value.countElements().toString());

            // El funcionamiento de esta lista es optimizado, aunque se haga un rebuild
            // del consumer, solo va a reconstruir los elemntos que han cambiado
            // en lugar de todo el listview
            return ListView.builder(
                itemCount: value.countElements(),
                itemBuilder: ((context, index) {
                  return value.getElementAt(index).build();
                }));
          }),
        ),
      ),
    );
  }
}
