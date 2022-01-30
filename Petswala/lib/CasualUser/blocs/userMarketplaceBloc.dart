import 'package:bloc/bloc.dart';
import 'package:petswala/CasualUser/events/userMarketplaceEvent.dart';
import 'package:petswala/CasualUser/states/userMarketplaceState.dart';
import 'package:petswala/CasualUser/models/productItem.dart';
import 'package:petswala/demo.dart';

class MarketPlaceBloc extends Bloc<MarketPlaceEvent, MarketPlaceState> {
  MarketPlaceBloc() : super(MarketPlaceState.initial()) {
    on<ChangeSelectionEvent>((event, emit) {
      List<ProductItem> displayedProducts = state.products
          .where((element) =>
              element.category == event.category || event.category == 'All')
          .toList();
      emit(MarketPlaceState.initial(
          products: state.products, displayedProducts: displayedProducts, cartItems: state.cartItems));
    });
    on<ProductSearchEvent>((event, emit) {
      var text = event.searchString.toLowerCase();
      List<ProductItem> displayedProducts = state.products
          .where((element) => element.name.toLowerCase().startsWith(text))
          .toList();
      emit(MarketPlaceState.initial(
          products: state.products, displayedProducts: displayedProducts, cartItems: state.cartItems));
    });
    on<InitializeListEvent>((event, emit) async {
      List<ProductItem> products = await getAllProducts();
      emit(MarketPlaceState.initial(
          products: products, displayedProducts: products, cartItems: []));
    });
    on<RefreshListEvent>((event, emit) async {
      List<ProductItem> products = await getAllProducts();
      emit(MarketPlaceState.initial(
          products: products, displayedProducts: products, cartItems: state.cartItems));
    });
    on<AddToCartEvent>((event, emit) async {
      List<ProductItem> cart = state.cartItems;
      if (!cart.contains(state.displayedProducts[event.index])){
        cart.add(state.displayedProducts[event.index]);
        }

      cart.forEach((element) {print(element.name);});
      emit(MarketPlaceState.initial(
          products: state.products, displayedProducts: state.displayedProducts, cartItems: cart));

    });
    on<RemoveFromCartEvent>((event, emit) async {
      state.cartItems.removeAt(event.index);
    });
    on<IncQuantityEvent>((event, emit) async {
      state.cartItems[event.index].quantity += 1;
      this.add(RefreshListEvent());

    });
    on<DecQuantityEvent>((event, emit) async {
      if(state.cartItems[event.index].quantity > 0)
      {state.cartItems[event.index].quantity -= 1;}
      this.add(RefreshListEvent());

    });
  }
  Future getAllProducts() async {
    var db = await DBConnection.getInstance();
    var products = await db.getAllProducts();
    return products;
  }
}
