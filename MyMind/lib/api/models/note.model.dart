import 'package:my_mind/api/interfaces/base_element.dart';

class NoteModel extends BaseElement {
  NoteModel();

  NoteModel.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();

    return data;
  }
}
