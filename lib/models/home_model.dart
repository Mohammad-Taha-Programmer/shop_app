class HomeModel{
  final bool status;
  final HomeDataModel? data;
  HomeModel({required this.status, required this.data});
  factory HomeModel.fromMap(Map<String, dynamic> map){
    return HomeModel(status: map['status'], data: HomeDataModel.fromMap(map['data']));
  }
}

class HomeDataModel{
 final List<BannerModel> banners;
 final List<ProductModel> products;
 HomeDataModel({required this.banners, required this.products});
 factory  HomeDataModel.fromMap(Map<String, dynamic> map){
    return HomeDataModel(
      banners: List<BannerModel>.from(map['banners'].map((e)=> BannerModel.fromMap(e))),
      products: List<ProductModel>.from(map['products'].map((e)=> ProductModel.fromMap(e)))
    );
  }
}

class BannerModel{
  final int id;
  final String image;
  BannerModel({required this.id, required this.image});

  factory BannerModel.fromMap(Map<String, dynamic> map){
    return BannerModel(id: map['id'], image: map['image']);
  }
}
class ProductModel{
  final int id;
  final num price;
  final num oldPrice;
  final num discout;
  final String image;
  final String name;
  final bool inFavirites;
  final bool inCart;

  ProductModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discout,
    required this.image,
    required this.name,
    required this.inFavirites,
    required this.inCart
});

  factory ProductModel.fromMap(Map<String, dynamic> map){
    return ProductModel(
        id: map['id'],
        price: map['price'],
        oldPrice: map['old_price'],
        discout: map['discount'],
        image: map['image'],
        name: map['name'],
        inFavirites: map['in_favorites'],
        inCart: map['in_cart'],
    );
  }
}