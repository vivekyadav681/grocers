import 'package:flutter_riverpod/legacy.dart';
import 'package:grocers/models/product_model.dart';


class CartItem {
  final ProductModel product;
  final int quantity;

  CartItem({required this.product, required this.quantity});

  CartItem copyWith({int? quantity}) {
    return CartItem(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartNotifier extends StateNotifier<Map<String, CartItem>> {
  CartNotifier() : super({});

  void addProduct(ProductModel product) {
    if (state.containsKey(product.name)) {
      state = {
        ...state,
        product.name: state[product.name]!.copyWith(
          quantity: state[product.name]!.quantity + 1,
        ),
      };
    } else {
      state = {
        ...state,
        product.name: CartItem(product: product, quantity: 1),
      };
    }
  }

  void removeProduct(ProductModel product) {
    if (!state.containsKey(product.name)) return;

    if (state[product.name]!.quantity > 1) {
      state = {
        ...state,
        product.name: state[product.name]!.copyWith(
          quantity: state[product.name]!.quantity - 1,
        ),
      };
    } else {
      final newState = Map<String, CartItem>.from(state);
      newState.remove(product.name);
      state = newState;
    }
  }

  void deleteProduct(ProductModel product) {
    final newState = Map<String, CartItem>.from(state);
    newState.remove(product.name);
    state = newState;
  }

  void clearCart() {
    state = {};
  }

  double get totalAmount {
    double total = 0.0;
    state.forEach((key, item) {
      total += item.product.price * item.quantity;
    });
    return total;
  }

  int get totalItems {
    int total = 0;
    state.forEach((key, item) {
      total += item.quantity;
    });
    return total;
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, Map<String, CartItem>>((ref) {
  return CartNotifier();
});
