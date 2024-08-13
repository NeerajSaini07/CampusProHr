class PayModeWiseFeeModel {
  String? online = '';
  String? cash = '';
  String? cheque = '';
  String? swipeMachine = '';
  String? total = '';

  PayModeWiseFeeModel(
      {this.online, this.cash, this.cheque, this.swipeMachine, this.total});

  PayModeWiseFeeModel.fromJson(Map<String, dynamic> json) {
    online = json['Online'] != null ? json['Online'] : "";
    cash = json['Cash'] != null ? json['Cash'] : "";
    cheque = json['Cheque'] != null ? json['Cheque'] : "";
    swipeMachine = json['SwipeMachine'] != null ? json['SwipeMachine'] : "";
    total = json['Total'] != null ? json['Total'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Online'] = this.online;
    data['Cash'] = this.cash;
    data['Cheque'] = this.cheque;
    data['SwipeMachine'] = this.swipeMachine;
    data['Total'] = this.total;
    return data;
  }
}
