class DropDownForProxyApplyModal {
  String? name;
  String? id;

  DropDownForProxyApplyModal({this.id, this.name});

  DropDownForProxyApplyModal.fromJson(Map<String, dynamic> json) {
    this.name = json["Name"];
    this.id = json["ID"];
  }
}
