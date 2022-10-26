class Thread {
  late String _id, course, createdAt, createdBy, title, description;

  Thread(this._id, this.course, this.createdAt, this.createdBy, this.title,
      this.description);

  Thread.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    course = importMap['course'] ?? '';
    createdAt = importMap['createdAt'] ?? '';
    createdBy = importMap['createdBy'] ?? '';
    title = importMap['title'] ?? '';
    description = importMap['description'] ?? '';
  }

  String get getId {
    return _id;
  }

  set setId(String id) {
    _id = id;
  }

  Map toJson() =>
      {'course': course, 'title': title, 'description': description};
}
