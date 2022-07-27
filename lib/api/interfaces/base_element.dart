enum ElementType { noType, note, list, reminder, group }

class BaseElement {
  String title;
  String idOwner;
  List<String> uidMembers;
  ElementType type;
  String? idGroup;
  int? order; // Cuanto mayor, primero aparece

  String? id;
  // DateTime? createdAt;
  // DateTime? updatedAt;
  // DateTime? deletedAt;

  BaseElement({
    this.title = "",
    this.idOwner = "",
    this.uidMembers = const [],
    this.type = ElementType.noType,
    this.idGroup,
    this.id,
    // this.createdAt,
    // this.updatedAt,
  });

  BaseElement.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        idOwner = json['idOwner'],
        uidMembers = json['uidMembers'] as List<String>,
        type = ElementType.values.firstWhere(
            (el) => el.toString() == json['type'].toString(),
            orElse: () => ElementType.noType),
        idGroup = json['idGroup'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['idOwner'] = idOwner;
    data['uidMembers'] = uidMembers;
    data['type'] = type.toString();

    return data;
  }
}
