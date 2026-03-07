class BookMarkModel {
  String? id;
  String? userId;
  List<Items>? items;
  int? totalItems;

  BookMarkModel({this.id, this.userId, this.items, this.totalItems});

  BookMarkModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    totalItems = json['total_items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['total_items'] = this.totalItems;
    return data;
  }
}

class Items {
  String? id;
  String? itemId;
  Item? item;
  String? createdAt;
  String? updatedAt;

  Items({this.id, this.itemId, this.item, this.createdAt, this.updatedAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
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
