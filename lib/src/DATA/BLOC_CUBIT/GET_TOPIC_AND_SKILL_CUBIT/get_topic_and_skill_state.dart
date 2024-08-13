part of 'get_topic_and_skill_cubit.dart';

abstract class GetTopicAndSkillState extends Equatable {
  const GetTopicAndSkillState();
}

class GetTopicAndSkillInitial extends GetTopicAndSkillState {
  @override
  List<Object> get props => [];
}

class GetTopicAndSkillLoadInProgress extends GetTopicAndSkillState {
  @override
  List<Object> get props => [];
}

class GetTopicAndSkillLoadSuccess extends GetTopicAndSkillState {
  final List<GetTopicAndSkillModel> topicSkillList;
  GetTopicAndSkillLoadSuccess(this.topicSkillList);
  @override
  List<Object> get props => [topicSkillList];

}


class GetTopicAndSkillLoadFail extends GetTopicAndSkillState {
  final String failReason;
  GetTopicAndSkillLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}

