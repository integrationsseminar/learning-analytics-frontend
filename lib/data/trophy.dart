class Trophy {
  Trophy(this.trophy, this.tier);

  late String trophy;
  late double tier;

  Trophy.fromJSON(Map<String, dynamic> importMap) {
    trophy = importMap['trophy'] ?? "no Trophy Found";
    tier = convertToPercentage(importMap['tier']) ?? 0;
  }

  String addSpaceBeforeUppercase(String text) {
    return text.replaceAllMapped(
        RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}');
  }

  double convertToPercentage(int tier) {
    return tier / 4;
  }
}

class OneOfAllTrophies {
  OneOfAllTrophies(this.identfier, this.description);

  late String identfier;
  late String description;

  OneOfAllTrophies.fromJSON(Map<String, dynamic> importMap) {
    identfier = importMap['identifier'] ?? "no trophy found";
    description = importMap['description'] ?? "no description found";
  }
}
