class Categories {
  int? id;
  String? catName;

  Categories({
    this.id,
    this.catName,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    id: json['id'] as int?,
    catName: json['cat_name'] as String?,
  );
}
