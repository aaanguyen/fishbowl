class CardModel {
  final int id;
  final String name;
  final String body;
  final String category;
  final int value;
  final String cardSet;
  final bool active;

  CardModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        name = parsedJson['name'],
        body = parsedJson['body'],
        category = parsedJson['category'],
        value = parsedJson['value'],
        cardSet = parsedJson['cardSet'],
        active = parsedJson['active'];

  CardModel.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        name = parsedJson['name'],
        body = parsedJson['body'],
        category = parsedJson['category'],
        value = parsedJson['value'],
        cardSet = parsedJson['cardSet'],
        active = parsedJson['active'] == 1;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'body': body,
      'category': category,
      'value': value,
      'cardSet': cardSet,
      'active': active ? 1 : 0,
    };
  }
}
