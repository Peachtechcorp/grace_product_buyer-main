import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/models/cart.dart';
import 'package:grace_product_buyer/app/models/product.dart';

class CartProvider extends ChangeNotifier {
  List<Cart> _carts = [];

  List<Cart> get carts => _carts;

  Future<void> addToCart(Product product) async {
    List<Cart> carts = _carts;

    List<Cart> existing =
        carts.where((c) => c.product.id == product.id).toList();

    if (existing.isNotEmpty) {
      Cart cart = existing.first;
      int index = carts.indexOf(cart);

      cart.quantity = cart.quantity + 1;
      carts[index] = cart;
      _carts = carts;

      notifyListeners();
      return;
    }

    carts.add(
      Cart(
        product: product,
        quantity: 1,
      ),
    );

    _carts = carts;

    notifyListeners();
  }

  Future<void> removeFromCart(Cart cart) async {
    List<Cart> carts = _carts;
    carts.removeWhere((c) => c == cart);
    _carts = carts;

    notifyListeners();
  }

  Future<void> increaseQuantity(Cart cart) async {
    List<Cart> carts = _carts;
    int index = carts.indexOf(cart);

    cart.quantity = cart.quantity + 1;
    carts[index] = cart;
    _carts = carts;

    notifyListeners();
  }

  Future<void> decreaseQuantity(Cart cart) async {
    List<Cart> carts = _carts;
    int index = carts.indexOf(cart);

    if (cart.quantity == 1) {
      return;
    }

    cart.quantity = cart.quantity - 1;
    carts[index] = cart;
    _carts = carts;

    notifyListeners();
  }

  double getPrice() {
    double price = 0;

    for (var cart in _carts) {
      price += cart.product.price * cart.quantity;
    }

    return price;
  }
}
