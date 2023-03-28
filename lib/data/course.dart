class Course {
  late String _id,
      name,
      start,
      end,
      color,
      progressType,
      universityName,
      className;
  late bool deleted;

  Course(this._id, this.name, this.start, this.end, this.color,
      this.progressType, this.deleted, this.universityName, this.className);

  set setId(String id) {
    _id = id;
  }

  get getId {
    return _id;
  }

  Course.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    name = importMap['name'] ?? '';
    start = importMap['start'] ?? '';
    end = importMap['end'] ?? '';
    color = importMap['color'] ?? '';
    progressType = importMap['progressType'] ?? '';
    universityName = importMap['universityName'] ?? '';
    className = importMap['className'] ?? '';
    deleted = importMap['deleted'] ?? false;
  }

  Map toJson() => {
        'name': name,
        'members': [],
        'start': start,
        'end': end,
        'color': color,
        'progressTpye': progressType,
        'universityName': universityName,
        'className': className,
        'deleted': deleted,
      };
}
