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
    lernmotivation = importMap['progressValues'][0] ?? 1;
    lernaufwand = importMap['progressValues'][1] ?? 1;
    lernerfolg = importMap['progressValues'][2] ?? 1;
    stresslevel = importMap['progressValues'][3] ?? 1;
    hochschulbindung = importMap['progressValues'][4] ?? 1;
  }
}
