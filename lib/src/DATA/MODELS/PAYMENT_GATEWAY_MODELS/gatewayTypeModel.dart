class GatewayTypeModel {
  String? id = '';
  String? param1 = '';
  String? param2 = '';
  String? param3 = '';
  String? param4 = '';
  String? param5 = '';
  String? gatewayType = '';
  String? gatewayUrl = '';

  GatewayTypeModel(
      {this.id,
      this.param1,
      this.param2,
      this.param3,
      this.param4,
      this.param5,
      this.gatewayType,
      this.gatewayUrl});

  GatewayTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    param1 = json['Param1'];
    param2 = json['Param2'];
    param3 = json['Param3'];
    param4 = json['Param4'];
    param5 = json['Param5'];
    gatewayType = json['GatewayType'];
    gatewayUrl = json['GatewayUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Param1'] = this.param1;
    data['Param2'] = this.param2;
    data['Param3'] = this.param3;
    data['Param4'] = this.param4;
    data['Param5'] = this.param5;
    data['GatewayType'] = this.gatewayType;
    data['GatewayUrl'] = this.gatewayUrl;
    return data;
  }
}
