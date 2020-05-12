class Note {
  String id;
  String body;

  static const String DEFAULT_NAME = 'New note';

  Note({this.id, this.body = 'ааа'});

  String get noteBody {
    return this.body.isNotEmpty ? this.body : Note.DEFAULT_NAME;
  }

  int get characters {
    return this.body.length;
  }

  int get words {
    if (this.body.length == 0) {
      return 0;
    }

    return this.body.split(' ').length;
  }
}