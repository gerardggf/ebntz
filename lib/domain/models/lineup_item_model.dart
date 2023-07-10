class LineupItemModel {
  final String id;
  final String author;
  final String creationDate;
  final String category;
  final List<String> tags;
  final String title;
  final String description;
  final String location;
  final String url;

  LineupItemModel({
    required this.id,
    required this.author,
    required this.creationDate,
    required this.category,
    required this.tags,
    required this.title,
    required this.description,
    required this.location,
    required this.url,
  });

  LineupItemModel copyWith({
    String? id,
    String? author,
    String? creationDate,
    String? category,
    List<String>? tags,
    String? title,
    String? description,
    String? location,
    String? url,
  }) =>
      LineupItemModel(
        id: id ?? this.id,
        author: author ?? this.author,
        creationDate: creationDate ?? this.creationDate,
        category: category ?? this.category,
        tags: tags ?? this.tags,
        title: title ?? this.title,
        description: description ?? this.description,
        location: location ?? this.location,
        url: url ?? this.url,
      );

  factory LineupItemModel.fromJson(Map<String, dynamic> json) =>
      LineupItemModel(
        id: json["id"],
        author: json["author"],
        creationDate: json["creationDate"],
        category: json["category"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        title: json["title"],
        description: json["description"],
        location: json["location"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "creationDate": creationDate,
        "category": category,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "title": title,
        "description": description,
        "location": location,
        "url": url,
      };
}


// {
// "id": "ferfefre",
// "author": "ahshashfas",
// "creationDate": "aduifghjkasfhjkas",
// "category": ["safas","uifashkfas","jfashjk","uasua"],
// "tags": ["fasf","uifashkfas","jfashjk","uasua"],
// "title":"sjkdhasda",
// "description":"sfhjasfsa",
// "location":"dhjashjdga",
// "url":"sjkdasjyhfash"
// }