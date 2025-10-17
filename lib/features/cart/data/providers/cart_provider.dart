import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super(_initialCartItems);

  static final List<CartItem> _initialCartItems = [
    CartItem(
      id: '1',
      name: 'Vintage Denim Jacket',
      imageUrl:
          'https://images.unsplash.com/photo-1544022613-e87ca75a784a?w=300&h=300&fit=crop',
      price: 2500.0,
      size: 'M',
      quantity: 1,
    ),
    CartItem(
      id: '2',
      name: 'Classic White T-Shirt',
      imageUrl:
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=300&h=300&fit=crop',
      price: 1200.0,
      size: 'L',
      quantity: 2,
    ),
    CartItem(
      id: '3',
      name: 'Retro High-Waist Jeans',
      imageUrl:
          'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=300&h=300&fit=crop',
      price: 3800.0,
      size: 'S',
      quantity: 1,
    ),
  ];

  void addItem(CartItem item) {
    final existingIndex =
        state.indexWhere((cartItem) => cartItem.id == item.id);
    if (existingIndex != -1) {
      final updatedItems = List<CartItem>.from(state);
      updatedItems[existingIndex] = updatedItems[existingIndex].copyWith(
        quantity: updatedItems[existingIndex].quantity + 1,
      );
      state = updatedItems;
    } else {
      state = [...state, item];
    }
  }

  void removeItem(String itemId) {
    state = state.where((item) => item.id != itemId).toList();
  }

  void updateQuantity(String itemId, int quantity) {
    if (quantity <= 0) {
      removeItem(itemId);
      return;
    }

    final updatedItems = state.map((item) {
      if (item.id == itemId) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();

    state = updatedItems;
  }

  void clearCart() {
    state = [];
  }

  double get totalPrice {
    return state.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  double get subtotal => totalPrice;
  double get shipping => 200.0;
  double get tax => totalPrice * 0.02; // 2% tax
  double get grandTotal => subtotal + shipping + tax;

  int get itemCount {
    return state.fold(0, (sum, item) => sum + item.quantity);
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

final cartItemCountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0, (sum, item) => sum + item.quantity);
});

final cartTotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0.0, (sum, item) => sum + item.totalPrice);
});
