class ExamListGradeEntryModel {
  String? id = '';
  String? name = '';
  String? displayOrder = '';
  String? head = '';

  ExamListGradeEntryModel({this.id, this.name, this.displayOrder, this.head});

  ExamListGradeEntryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'] : "";
    name = json['name'] != null ? json['name'] : "";
    displayOrder = json['DisplayOrder'] != null ? json['DisplayOrder'] : "";
    head = json['Head'] != null ? json['Head'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['DisplayOrder'] = this.displayOrder;
    data['Head'] = this.head;
    return data;
  }
}
