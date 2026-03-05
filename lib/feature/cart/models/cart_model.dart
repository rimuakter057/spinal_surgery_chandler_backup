class CartModel {
  String? id;
  String? userId;
  List<Items>? items;
  String? createdAt;
  String? updatedAt;

  CartModel({this.id, this.userId, this.items, this.createdAt, this.updatedAt});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Items {
  String? id;
  String? itemId;
  String? itemTitle;
  String? itemImage;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  Items(
      {this.id,
        this.itemId,
        this.itemTitle,
        this.itemImage,
        this.quantity,
        this.createdAt,
        this.updatedAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    itemTitle = json['item_title'];
    itemImage = json['item_image'];
    quantity = json['quantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item_id'] = itemId;
    data['item_title'] = itemTitle;
    data['item_image'] = itemImage;
    data['quantity'] = quantity;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
