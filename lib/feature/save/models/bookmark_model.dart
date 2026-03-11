class BookMarkModel {
  String? id;
  String? userId;
  List<BookMarkItems>? bookMarkItems;
  int? totalItems;

  BookMarkModel({this.id, this.userId, this.bookMarkItems, this.totalItems});

  BookMarkModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    if (json['items'] != null) {
      bookMarkItems = <BookMarkItems>[];
      json['items'].forEach((v) {
        bookMarkItems!.add(BookMarkItems.fromJson(v));
      });
    }
    totalItems = json['total_items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    if (bookMarkItems != null) {
      data['items'] = bookMarkItems!.map((v) => v.toJson()).toList();
    }
    data['total_items'] = totalItems;
    return data;
  }
}

class BookMarkItems {
  String? id;
  String? itemId;
  Item? item;
  String? createdAt;
  String? updatedAt;

  BookMarkItems({this.id, this.itemId, this.item, this.createdAt, this.updatedAt});

  BookMarkItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item_id'] = itemId;
    if (item != null) {
      data['item'] = item!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Item {
  String? id;
  String? title;
  String? type;
  ProductInfo? productInfo;

  Item({this.id, this.title, this.type, this.productInfo});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    productInfo = json['product_info'] != null
        ? new ProductInfo.fromJson(json['product_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    if (this.productInfo != null) {
      data['product_info'] = this.productInfo!.toJson();
    }
    return data;
  }
}

class ProductInfo {
  String? id;
  String? title;
  String? description;
  String? brochureFileUrl;
  String? videoFileUrl;
  String? bannerImageUrl;

  ProductInfo(
      {this.id,
        this.title,
        this.description,
        this.brochureFileUrl,
        this.videoFileUrl,
        this.bannerImageUrl});

  ProductInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    brochureFileUrl = json['brochure_file_url'];
    videoFileUrl = json['video_file_url'];
    bannerImageUrl = json['banner_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['brochure_file_url'] = this.brochureFileUrl;
    data['video_file_url'] = this.videoFileUrl;
    data['banner_image_url'] = this.bannerImageUrl;
    return data;
  }
}
