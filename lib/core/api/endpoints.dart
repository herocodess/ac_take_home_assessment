class Endpoints {
  ///AUTH
  static const String login = 'log_in';

  ///PRODUCTS
  static String getProducts({required String category}) =>
      'products?category=$category';

  ///CATEGORIES
  static const String categories = 'categories';
}
