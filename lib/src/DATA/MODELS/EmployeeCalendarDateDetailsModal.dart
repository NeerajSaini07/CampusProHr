class EmployeeCalendarDateDetailsModal {
  String? id;
  String? name;
  String? description;
  String? badge;
  String? date;
  String? type;
  String? statusval;
  String? statuscolor;
  String? buttonstyle;
  String? date2;
  String? mode;

  EmployeeCalendarDateDetailsModal(
      {this.id,
      this.name,
      this.description,
      this.badge,
      this.date,
      this.type,
      this.statusval,
      this.statuscolor,
      this.buttonstyle,
      this.date2,
      this.mode});

  EmployeeCalendarDateDetailsModal.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'] : "";
    name = json['name'] != null ? json['name'] : "";
    description = json['description'] != null ? json['description'] : "";
    badge = json['badge'] != null ? json['badge'] : "";
    date = json['date'] != null ? json['date'] : "";
    type = json['type'] != null ? json['type'] : "";
    statusval = json['statusval'] != null ? json['statusval'] : "";
    statuscolor = json['statuscolor'] != null ? json['statuscolor'] : "";
    buttonstyle = json['buttonstyle'] != null ? json['buttonstyle'] : "";
    date2 = json['date2'] != null ? json['date2'] : "";
    mode = json['mode'] != null ? json['mode'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['badge'] = this.badge;
    data['date'] = this.date;
    data['type'] = this.type;
    data['statusval'] = this.statusval;
    data['statuscolor'] = this.statuscolor;
    data['buttonstyle'] = this.buttonstyle;
    data['date2'] = this.date2;
    data['mode'] = this.mode;
    return data;
  }
}
