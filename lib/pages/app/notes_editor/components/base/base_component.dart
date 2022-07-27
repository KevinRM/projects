import 'package:flutter/cupertino.dart';
import 'package:my_mind/pages/app/notes_editor/components/base/elements_buttons.dart';

abstract class BaseComponent {
  int index;
  Widget view;
  ElementsButtons elementsButtons;

  BaseComponent(this.index, this.view, this.elementsButtons);

  void changeSelectedState();

  Map<String, dynamic> toJson();

  Widget build();

  bool isEmpty();
}
