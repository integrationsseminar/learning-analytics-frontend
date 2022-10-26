class Threadcomment {
  late String _id, createdAt, createdBy, message, thread, type;

  Threadcomment(this._id, this.createdAt, this.createdBy, this.message,
      this.thread, this.type);

  Threadcomment.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    createdAt = importMap['createdAt'] ?? '';
    createdBy = importMap['createdBy'] ?? '';
    message = importMap['message'] ?? '';
    thread = importMap['thread'] ?? '';
    type = importMap['type'] ?? '';
  }

  String get getId {
    return _id;
  }

  set setId(String id) {
    _id = id;
  }

  Map toJson() => {'message': message, 'thread': thread};
}
