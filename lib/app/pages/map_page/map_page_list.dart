import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:grace_product_buyer/app/common/loader.dart';
import 'package:grace_product_buyer/app/pages/checkout_page/checkout_page.dart';
import 'package:grace_product_buyer/app/pages/map_page/widgets/shop.dart';
import 'package:grace_product_buyer/app/providers/agent_provider.dart';
import 'package:grace_product_buyer/app/providers/order_provider.dart';
import 'package:provider/provider.dart';

class MapPageList extends StatefulWidget {
  const MapPageList({super.key});

  @override
  State<MapPageList> createState() => _MapPageListState();
}

class _MapPageListState extends State<MapPageList> {
  bool isLoading = false;
  String errMsg = '';

  void handleShopTap(int agentId) async {
    setState(() {
      isLoading = true;
      errMsg = '';
    });

    var order = Provider.of<OrderProvider>(context, listen: false);

    var res = await order.assignAgent(agentId);

    setState(() {
      isLoading = false;
    });

    if (res['success'] && mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const CheckoutPage(),
        ),
      );
    } else {
      setState(() {
        errMsg = res['error'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<AgentProvider>(context, listen: false).getAgents();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final agent = Provider.of<AgentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select near shop'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: SizedBox(
        child: Stack(
          children: [
            errMsg.isNotEmpty
                ? SizedBox(
                    height: size.height * 1,
                    width: size.width * 1,
                    child: Center(
                      child: Text(errMsg),
                    ),
                  )
                : SizedBox(
                    height: size.height * 1,
                    width: size.width * 1,
                    child: agent.agents.isEmpty
                        ? const Center(
                            child: Text('No Agents Available'),
                          )
                        : ListView.separated(
                            itemCount: agent.agents.length,
                            itemBuilder: (context, int index) => Shop(
                              agent: agent.agents[index],
                              onTap: () =>
                                  handleShopTap(agent.agents[index].id),
                            ),
                            separatorBuilder: (context, index) =>
                                const Divider(),
                          ),
                  ),
            agent.isLoading ? const Loader() : const SizedBox(),
            isLoading ? const Loader() : const SizedBox()
          ],
        ),
      ),
    );
  }
}
