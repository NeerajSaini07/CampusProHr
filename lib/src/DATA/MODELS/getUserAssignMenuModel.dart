class GetUserAssignMenuModel {
  int? iD = -1;
  int? menuID = -1;
  String? menuName = "";
  int? subMenuID = -1;
  String? subMenuName = "";
  String? userType = "";
  int? isActive = -1;
  String? menuIcon = "";
  String? subMenuIcon = "";
  String? navigateURL = "";
  String? menuURL = "";
  int? displayOrder = -1;
  int? menuOrder = -1;
  String? userType1 = "";

  GetUserAssignMenuModel(
      {this.iD,
      this.menuID,
      this.menuName,
      this.subMenuID,
      this.subMenuName,
      this.userType,
      this.isActive,
      this.menuIcon,
      this.subMenuIcon,
      this.navigateURL,
      this.menuURL,
      this.displayOrder,
      this.menuOrder,
      this.userType1});

  GetUserAssignMenuModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'] != null ? json['ID'] : -1;
    menuID = json['MenuID'] != null ? json['MenuID'] : -1;
    menuName = json['MenuName'] != null ? json['MenuName'] : "";
    subMenuID = json['SubMenuID'] != null ? json['SubMenuID'] : -1;
    subMenuName = json['SubMenuName'] != null ? json['SubMenuName'] : "";
    userType = json['UserType'] != null ? json['UserType'] : "";
    isActive = json['IsActive'] != null ? json['IsActive'] : -1;
    menuIcon = json['MenuIcon'] != null ? json['MenuIcon'] : "";
    subMenuIcon = json['SubMenuIcon'] != null ? json['SubMenuIcon'] : "";
    navigateURL = json['NavigateURL'] != null ? json['NavigateURL'] : "";
    menuURL = json['MenuURL'] != null ? json['MenuURL'] : "";
    displayOrder = json['DisplayOrder'] != null ? json['DisplayOrder'] : -1;
    menuOrder = json['MenuOrder'] != null ? json['MenuOrder'] : -1;
    userType1 = json['UserType1'] != null ? json['UserType1'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['MenuID'] = this.menuID;
    data['MenuName'] = this.menuName;
    data['SubMenuID'] = this.subMenuID;
    data['SubMenuName'] = this.subMenuName;
    data['UserType'] = this.userType;
    data['IsActive'] = this.isActive;
    data['MenuIcon'] = this.menuIcon;
    data['SubMenuIcon'] = this.subMenuIcon;
    data['NavigateURL'] = this.navigateURL;
    data['MenuURL'] = this.menuURL;
    data['DisplayOrder'] = this.displayOrder;
    data['MenuOrder'] = this.menuOrder;
    data['UserType1'] = this.userType1;
    return data;
  }
}
