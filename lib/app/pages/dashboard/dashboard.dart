import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:grace_product_buyer/app/common/body_builder.dart';

import 'package:grace_product_buyer/app/models/category.dart';
import 'package:grace_product_buyer/app/pages/dashboard/widgets/categories.dart';
import 'package:grace_product_buyer/app/pages/dashboard/widgets/product_card.dart';
import 'package:grace_product_buyer/app/pages/shopping_cart_page/shopping_cart_page.dart';
import 'package:grace_product_buyer/app/providers/cart_provider.dart';
import 'package:grace_product_buyer/app/providers/home_provider.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with AutomaticKeepAliveClientMixin<Dashboard> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
        (_) => Provider.of<HomeProvider>(context, listen: false).getData());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<HomeProvider>(
        builder: (context, HomeProvider homeProvider, _) {
      return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.list),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ShoppingCartPage(),
                  ),
                );
              },
              icon: Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context, cart, child) =>
                      Text('${cart.carts.length}'),
                ),
                child: const Icon(Icons.shopping_cart_rounded),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person),
            )
          ],
        ),
        body: _buildBody(context, homeProvider),
      );
    });
  }

  Widget _buildBody(BuildContext context, HomeProvider homeProvider) {
    return BodyBuilder(
      apiRequestStatus: homeProvider.apiRequestStatus,
      child: _buildBodyList(context, homeProvider),
      reload: () => homeProvider.getData(),
    );
  }

  Widget _buildBodyList(
    BuildContext context,
    HomeProvider homeProvider,
  ) {
    return RefreshIndicator(
      onRefresh: () => homeProvider.getData(),
      child: ListView(
        // padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: defaultDecoration(
                media: MediaQuery.of(context).size,
                hintText: 'Search for a Product',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.filter_list),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Categories(
            categories: <Category>[
              Category(id: 0, name: "All"),
              ...homeProvider.categories
            ],
          ),
          const SizedBox(height: 20.0),
          Column(
            children: homeProvider.products
                .map((p) => ProductCard(product: p))
                .toList(),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
