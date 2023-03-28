class Trophy {
  Trophy(this.trophy, this.tier);

  late String trophy;
  late double tier;

  Trophy.fromJSON(Map<String, dynamic> importMap) {
    trophy = addSpaceBeforeUppercase(importMap['trophy']) ?? "no Trophy Found";
    tier = convertToPercentage(importMap['tier']) ?? 0;
  }
}

String addSpaceBeforeUppercase(String text) {
  return text.replaceAllMapped(
      RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}');
}

double convertToPercentage(int tier) {
  return tier / 4;
}
