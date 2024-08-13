class GetTopicAndSkillModel {
  String? topicId = "";
  String? topic = "";
  String? skillId = "";
  String? skill = "";

  GetTopicAndSkillModel({this.skill, this.skillId, this.topic, this.topicId});

  GetTopicAndSkillModel.fromJson(Map<String, dynamic> json) {
    this.skillId = json['SkillID'];
    this.skill = json['Skill'];
    this.topicId = json['TopicID'];
    this.topic = json['Topic'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['Topic'] = this.topic;
    data['TopicID'] = this.topicId;
    data['Skill'] = this.skill;
    data['SkillID'] = this.skillId;
    return data;
  }
}
