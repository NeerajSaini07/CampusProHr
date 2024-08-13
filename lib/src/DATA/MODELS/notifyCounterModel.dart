class NotifyCounterModel {
  String title;
  int count;

  NotifyCounterModel.fromJson(String name, int counter)
      : title = name,
        count = counter;

  @override
  String toString() {
    return "{title: $title, count: $count}";
  }
}

// class NotifyCounterModel {
//   String? title;
//   int? count;

//   NotifyCounterModel({this.title, this.count});

//   NotifyCounterModel.fromJson(Map<String, dynamic> json, count) {
//     title = json['title'] ?? "";
//     count = json['count'] ?? 0;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['title'] = this.title;
//     data['count'] = this.count;
//     return data;
//   }
// }
