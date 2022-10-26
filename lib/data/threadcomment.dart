class Threadcomment {
  late String _id, createdAt, createdBy, message, thread;
  late bool createdByOwner;

  Threadcomment(this._id, this.createdAt, this.createdBy, this.message,
      this.thread, this.createdByOwner);

  Threadcomment.fromJSON(Map<String, dynamic> importMap) {
    _id = importMap['_id'] ?? '';
    createdAt = importMap['createdAt'] ?? '';
    createdBy = importMap['createdBy'] ?? '';
    message = importMap['message'] ?? '';
    thread = importMap['thread'] ?? '';
    createdByOwner = importMap['createdByOwner'] ?? false;
  }

  String get getId {
    return _id;
  }

  set setId(String id) {
    _id = id;
  }

  Map toJson() => {'message': message, 'thread': thread};
}
