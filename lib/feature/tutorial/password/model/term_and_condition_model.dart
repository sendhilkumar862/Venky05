

class TermAndConditionModel {
  TermAndConditionModel({this.title, this.id, this.content});
  TermAndConditionModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    content = json['content'];
  }
  String? title;
  int? id;
  String? content;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['id'] = id;
    data['content'] = content;
    return data;
  }
}