import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/bottom_navigation.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../shop/presentation/pages/shop_page.dart';
import '../../../wishlist/presentation/pages/wishlist_page.dart';
import '../../../cart/presentation/pages/cart_page.dart';
import '../../../cart/data/providers/cart_provider.dart';
import '../../../profile/presentation/pages/profile_page.dart';

final navigationIndexProvider = StateProvider<int>((ref) => 0);

class MainNavigationPage extends ConsumerWidget {
  const MainNavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);
    final cartItemCount = ref.watch(cartItemCountProvider);

    final pages = [
      const HomePage(),
      const ShopPage(),
      const WishlistPage(),
      const CartPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(navigationIndexProvider.notifier).state = index;
        },
        cartItemCount: cartItemCount,
        wishlistItemCount: 5, // TODO: Get from wishlist provider
      ),
    );
  }
}
