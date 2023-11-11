import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:grace_product_buyer/app/common/body_builder.dart';
import 'package:grace_product_buyer/app/models/notification.dart';
import 'package:grace_product_buyer/app/providers/notification_provider.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    SchedulerBinding.instance.addPostFrameCallback((_) =>
        Provider.of<NotificationProvider>(context, listen: false).init());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (BuildContext context, NotificationProvider notificationProvider,
          Widget? child) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Notifications'),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
              bottom: TabBar(
                controller: _tabController,
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                labelColor: Colors.black,
                tabs: const [
                  Tab(
                    text: 'All notifications',
                  ),
                  Tab(
                    text: 'Unread',
                  ),
                ],
              ),
            ),
            body: _buildBody(notificationProvider));
      },
    );
  }

  Widget _buildBody(NotificationProvider notificationProvider) {
    return BodyBuilder(
      apiRequestStatus: notificationProvider.apiRequestStatus,
      child: _buildBodyList(notificationProvider),
      reload: () => notificationProvider.init(),
    );
  }

  Widget _buildBodyList(NotificationProvider notificationProvider) {
    return RefreshIndicator(
      onRefresh: () => notificationProvider.init(),
      child: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            itemCount: notificationProvider.readNotifications.length,
            itemBuilder: (context, int index) {
              NotificationType type = notificationProvider
                  .readNotifications[index].notificationType;
              return ListTile(
                leading: CircleAvatar(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      type == NotificationType.offer
                          ? Icons.offline_bolt
                          : (type == NotificationType.service
                              ? Icons.location_on_rounded
                              : Icons.shopping_bag_sharp),
                    ),
                  ),
                ),
                title: Text(
                  notificationProvider.readNotifications[index].title,
                ),
                subtitle: Text(
                  notificationProvider.readNotifications[index].description,
                ),
              );
            },
          ),
          ListView.builder(
            itemCount: notificationProvider.unreadNotifications.length,
            itemBuilder: (context, int index) {
              NotificationType type = notificationProvider
                  .unreadNotifications[index].notificationType;
              return ListTile(
                leading: CircleAvatar(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      type == NotificationType.offer
                          ? Icons.offline_bolt
                          : (type == NotificationType.service
                              ? Icons.location_on_rounded
                              : Icons.shopping_bag_sharp),
                    ),
                  ),
                ),
                title: Text(
                  notificationProvider.readNotifications[index].title,
                ),
                subtitle: Text(
                  notificationProvider.readNotifications[index].description,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
