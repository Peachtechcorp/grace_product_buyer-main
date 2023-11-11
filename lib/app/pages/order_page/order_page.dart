import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:grace_product_buyer/app/common/body_builder.dart';
import 'package:grace_product_buyer/app/models/order.dart';
import 'package:grace_product_buyer/app/pages/order_page/widgets/order_card.dart';
import 'package:grace_product_buyer/app/providers/order_provider.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with AutomaticKeepAliveClientMixin<OrderPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
        (_) => Provider.of<OrderProvider>(context, listen: false).init());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Consumer<OrderProvider>(
      builder:
          (BuildContext context, OrderProvider orderProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Orders'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          body: _buildBody(orderProvider),
        );
      },
    );
  }

  Widget _buildBody(OrderProvider orderProvider) {
    return BodyBuilder(
      apiRequestStatus: orderProvider.apiRequestStatus,
      reload: () => orderProvider.init(),
      child: _buildBodyList(orderProvider),
    );
  }

  Widget _buildBodyList(OrderProvider orderProvider) {
    return RefreshIndicator(
      onRefresh: () => orderProvider.init(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        itemCount: orderProvider.orders.length,
        itemBuilder: (context, int index) {
          Order order = orderProvider.orders[index];
          return OrderCard(order: order);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
