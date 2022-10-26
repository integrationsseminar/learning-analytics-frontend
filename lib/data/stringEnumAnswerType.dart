class StringEnumAnswerType {
  late String type;
  late List<String> answers;

  StringEnumAnswerType(this.type, this.answers);

  StringEnumAnswerType.fromJSON(Map<String, dynamic> importMap) {
    type = importMap['type'] ?? '';
    answers = (importMap['enum'] ?? [])
        .map<String>((answerMap) => answerMap.toString())
        .toList();
  }

  Map toJson() => {"type": type, "enum": answers};
}
