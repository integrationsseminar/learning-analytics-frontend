import './answer.dart';
import './stringEnumAnswerType.dart';

class Survey {
  late String _id, title, description, course, createdBy, createdAt;
  late StringEnumAnswerType answerType;
  late List<Answer> answers;
  late bool deleted;

  Survey(this._id, this.title, this.description, this.course, this.answerType,
      this.createdBy, this.answers, this.deleted, this.createdAt);

  Survey.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    title = importMap['title'] ?? '';
    description = importMap['description'] ?? '';
    course = importMap['course'] ?? '';
    createdBy = importMap['createdBy'] ?? '';
    createdAt = importMap['createdAt'] ?? '';
    answerType = StringEnumAnswerType.fromJSON(importMap['answerType'] ?? {});
    answers = (importMap['answers'] ?? [])
        .map<Answer>((answerMap) => Answer.fromJSON(answerMap))
        .toList();
    deleted = importMap['deleted'] ?? false;
  }

  get getId {
    return _id;
  }

  set setId(String id) {
    _id = id;
  }

  Map toJson() => {
        'course': course,
        'title': title,
        'description': description,
        'createdBy': createdBy,
        'answerType': answerType.toJson(),
        'answers': answers.map((e) => e.toJson()).toList(),
      };
}
