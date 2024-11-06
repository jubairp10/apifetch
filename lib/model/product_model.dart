class Products {
  int? id;
  int? partsCat;
  String? partImage;
  int? vBrand;
  int? vCategory;
  String? price;
  String? partsName;
  String? description;
  dynamic offerPrice;
  bool? isOffer;
  String? productRating;

  Products({
    this.id,
    this.partsCat,
    this.partImage,
    this.vBrand,
    this.vCategory,
    this.price,
    this.partsName,
    this.description,
    this.offerPrice,
    this.isOffer,
    this.productRating,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    id: json['id'] as int?,
    partsCat: json['parts_cat'] as int?,
    partImage: json['part_image'] as String?,
    vBrand: json['v_brand'] as int?,
    vCategory: json['v_category'] as int?,
    price: json['price'] as String?,
    partsName: json['parts_name'] as String?,
    description: json['description'] as String?,
    offerPrice: json['offer_price'],
    isOffer: json['is_offer'] as bool?,
    productRating: json['product_rating'] as String?,
  );
}
