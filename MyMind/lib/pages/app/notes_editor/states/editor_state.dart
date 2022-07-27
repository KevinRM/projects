import 'package:flutter/material.dart';
import 'package:my_mind/pages/app/notes_editor/components/base/base_component.dart';

import '../components/text/text_content.dart';

class EditorState extends ChangeNotifier {
  final List<BaseComponent> editorContent = [];
  int indexElementSelected = -1;
  int indexPreviousElementSelected = -1;
  bool _showEditElements = false;

  int countElements() {
    return editorContent.length;
  }

  /// Insert new element at position, otherwise, at the end
  void newElement({int position = -1}) {
    if (position > -1) {
      editorContent.insert(position, TextContent(editorContent.length));
      _updateContentIndexes();
    } else {
      editorContent.add(TextContent(editorContent.length));
    }

    // Solo hace rebuild de los que cambió su indice al rodarse de posicion
    notifyListeners();
  }

  /// Delete element at position
  void deleteElement({int position = -1}) {
    if (position > -1) {
      editorContent.removeAt(position);
      _updateContentIndexes();
      notifyListeners();
    }
  }

  List<BaseComponent> getAllElements() {
    return List.unmodifiable(editorContent);
  }

  BaseComponent getElementAt(int index) {
    return editorContent[index];
  }

  BaseComponent? getElementSelected() {
    return indexElementSelected > -1
        ? editorContent[indexElementSelected]
        : null;
  }

  void changeElementSelected({int newIndexElement = -1}) {
    // Si se esta activa la opcion de editar, desactivarla
    if (_showEditElements) {
      hideEditElements();
    }

    if (newIndexElement != indexElementSelected) {
      indexPreviousElementSelected = indexElementSelected;
      indexElementSelected = newIndexElement;
      if (indexPreviousElementSelected > -1) {
        // Si el elemento a deseleccionar esta vacío y no es el único que hay, lo eliminamos
        if (editorContent[indexPreviousElementSelected].isEmpty() &&
            editorContent.length > 1) {
          editorContent.removeAt(indexPreviousElementSelected);
          _updateContentIndexes();
          if (indexElementSelected > indexPreviousElementSelected) {
            indexElementSelected--;
          }
        } else {
          editorContent[indexPreviousElementSelected].changeSelectedState();
        }
      }
      if (indexElementSelected > -1) {
        editorContent[indexElementSelected].changeSelectedState();
      }

      notifyListeners();
    }
  }

  void _updateContentIndexes() {
    for (var i = 0; i < editorContent.length; i++) {
      editorContent[i].index = i;
    }
  }

  /// Show the buttons for editing elements contained in the note
  bool showEditElements() {
    changeElementSelected();
    _showEditElements = true;
    notifyListeners();
    return _showEditElements;
  }

  /// Hide the buttons for editing elements contained in the note
  bool hideEditElements() {
    _showEditElements = false;
    notifyListeners();
    return _showEditElements;
  }

  bool isShowingEditElements() {
    return _showEditElements;
  }

  void moveElement(int indexToMove, bool up) {
    if (up) {
      if (indexToMove > 0) {
        BaseComponent element = editorContent.removeAt(indexToMove);
        editorContent.insert(indexToMove - 1, element);
        _updateContentIndexes();
        notifyListeners();
      }
    } else {
      if (indexToMove < editorContent.length - 1) {
        BaseComponent element = editorContent.removeAt(indexToMove);
        editorContent.insert(indexToMove + 1, element);
        _updateContentIndexes();
        notifyListeners();
      }
    }
  }
}
