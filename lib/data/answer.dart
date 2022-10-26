class Answer {
  late String user, answer;

  Answer(this.user, this.answer);

  Answer.fromJSON(Map<String, dynamic> importMap) {
    user = importMap['user'] ?? '';
    answer = importMap['answer'] ?? '';
  }

  Map toJson() => {'user': user, 'answer': answer};
}
