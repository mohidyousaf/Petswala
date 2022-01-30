import 'package:mongo_dart/mongo_dart.dart';
import 'package:petswala/CasualUser/states/userMarketplaceState.dart';

abstract class MarketPlaceEvent {}

class ChangeSelectionEvent extends MarketPlaceEvent {
  String category;
  ChangeSelectionEvent({this.category});
}
class ProductSearchEvent extends MarketPlaceEvent {
  String searchString;
  ProductSearchEvent({this.searchString});
}
class InitializeListEvent extends MarketPlaceEvent {
  InitializeListEvent();
}
class RefreshListEvent extends MarketPlaceEvent {
  RefreshListEvent();
}
class AddToCartEvent extends MarketPlaceEvent {
  int index;
  AddToCartEvent({this.index});
}
class RemoveFromCartEvent extends MarketPlaceEvent {
  int index;
  RemoveFromCartEvent({this.index});
}
class CheckoutEvent extends MarketPlaceEvent{
  CheckoutEvent();
}
class IncQuantityEvent extends MarketPlaceEvent {
  int index;
  IncQuantityEvent({this.index});
}
class DecQuantityEvent extends MarketPlaceEvent {
  int index;
  DecQuantityEvent({this.index});
}
