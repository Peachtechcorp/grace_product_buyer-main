import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/common/error_widget.dart';
import 'package:grace_product_buyer/app/common/loading_widget.dart';
import 'package:grace_product_buyer/app/utils/enum/api_request_status.dart';

class BodyBuilder extends StatelessWidget {
  const BodyBuilder({
    super.key,
    required this.apiRequestStatus,
    required this.child,
    required this.reload,
  });

  final ApiRequestStatus apiRequestStatus;
  final Widget child;
  final Function reload;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    switch (apiRequestStatus) {
      case ApiRequestStatus.loading:
        return const LoadingWidget();
      case ApiRequestStatus.uninitialized:
        return const LoadingWidget();
      case ApiRequestStatus.connectionError:
        return MyErrorWidget(
          refreshCallback: reload,
          isConnection: true,
        );
      case ApiRequestStatus.error:
        return MyErrorWidget(
          refreshCallback: reload,
          isConnection: false,
        );
      case ApiRequestStatus.loaded:
        return child;
      default:
        return const LoadingWidget();
    }
  }
}
