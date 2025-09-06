import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:watch_store/components/extensions.dart';
import 'package:watch_store/data/model/order.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/resources/dimensions.dart';
import 'package:watch_store/screens/profile/bloc/profile_bloc.dart';
import 'package:watch_store/widgets/customized_appBar.dart';
import 'package:watch_store/widgets/surface_container.dart';

class OrderListScreen extends StatelessWidget {
  final String status;
  final List<Order> orderList;
  const OrderListScreen({
    super.key,
    required this.orderList,
    required this.status,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomizedAppbar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  context.read<ProfileBloc>().add(ProfileInitEvent());
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(Assets.svg.leftArrow, width: 8),
              ),
              Text(" $status"),
              // status == 'in process'
              //     ? Text("لیست سفارشات در حال ارسال")
              //     : status == 'cancelled'
              //     ? Text('لیست سفارشات لغو شده')
              //     : Text('لیست سفارشات تحویل شده'),
            ],
          ),
        ),
        body: _buildOrderList(orderList),
      ),
    );
  }

  Widget _buildOrderList(List<Order> orderList) {
    return SizedBox(
      width: double.infinity,
      height: 500,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          final order = orderList[index];
          return SurfaceContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'کد سفارش: ${order.code}',
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  'وضعیت: ${order.status}',
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 8),
                Text(
                  'جزییات سفارش:',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                if (order.orderDetails.isNotEmpty)
                  FittedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children:
                          order.orderDetails.map((detail) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('قیمت: ${detail.price}'),
                                  Dimensions.large.width,
                                  Text('تعداد: ${detail.count}'),
                                  Dimensions.large.width,
                                  Text('نام محصول: ${detail.product}'),
                                ],
                              ),
                            );
                          }).toList(),
                    ),
                  )
                else
                  Text('بدون جزییات سفارش'),
              ],
            ),
          );
        },
      ),
    );
  }
}
