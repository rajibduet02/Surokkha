/// Generic item entity for lists (e.g. home items).
class ItemModel {
  const ItemModel({
    this.id,
    this.title,
  });

  final String? id;
  final String? title;

  // TODO: fromJson, toJson
}
