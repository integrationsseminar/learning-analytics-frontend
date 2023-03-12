class ProgressValues {
  ProgressValues(this.date, this.lernmotivation, this.lernaufwand,
      this.lernerfolg, this.stresslevel, this.hochschulbindung);

  late DateTime date;
  late int lernmotivation;
  late int lernaufwand;
  late int lernerfolg;
  late int stresslevel;
  late int hochschulbindung;

  ProgressValues.fromJSON(Map<String, dynamic> importMap) {
    date = DateTime.parse(importMap['createdAt']) ?? DateTime.utc(2000, 1, 1);
    lernmotivation = importMap['progressValues'[0]] ?? 0;
    lernaufwand = importMap['progressValues'[1]] ?? 0;
    lernerfolg = importMap['progressValues'[2]] ?? 0;
    stresslevel = importMap['progressValues'[3]] ?? 0;
    hochschulbindung = importMap['progressValues'[4]] ?? 0;
  }
}
