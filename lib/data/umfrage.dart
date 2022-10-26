import './antwort.dart';

class Umfrage {
  final String frage;
  final List<String> tags;
  final int answersAmount;
  final List<AntwortClass> answersData;

  Umfrage(this.frage, this.tags, this.answersAmount, this.answersData);
}
