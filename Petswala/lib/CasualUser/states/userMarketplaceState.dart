import 'package:equatable/equatable.dart';
import 'package:petswala/CasualUser/models/productItem.dart';
import 'package:quiver/core.dart';
class MarketPlaceState extends Equatable{
  final String selected;
  final List<ProductItem> products;
  final List<ProductItem> displayedProducts;
  final List<ProductItem> cartItems;

  get props => [selected, products, displayedProducts, cartItems];

  MarketPlaceState._(
      {this.selected: 'All',
      this.products: const [],
      this.cartItems: const [],
      this.displayedProducts: const []});

  factory MarketPlaceState.initial(
      {List<ProductItem> products: const [],
      List<ProductItem> displayedProducts: const [],
       List<ProductItem> cartItems: const []}) {
    return MarketPlaceState._(
        products: products, displayedProducts: displayedProducts, cartItems: cartItems);
  }
}
