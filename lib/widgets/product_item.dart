// ignore_for_file: unused_field

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:watch_store/components/extensions.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/resources/colors.dart';
import 'package:watch_store/resources/dimensions.dart';
import 'package:watch_store/screens/single_product/single_product_screen.dart';
import 'package:watch_store/utilities/format_time.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    super.key,
    required this.productName,
    required this.imagePath,
    required this.id,
    required this.price,
    this.discountPrice = 0,
    this.discount = 0,
    this.specialExpiration = "",
  });

  final String productName;
  final int price;
  final int id;
  final int discountPrice;
  final int discount;
  final String specialExpiration;
  final String imagePath;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  Duration _duration = Duration(seconds: 0);
  late Timer? _timer;
  int amazingTime = 0;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (amazingTime == 0) {
          debugPrint("Product onTap limited");
        } else {
          amazingTime--;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.specialExpiration != "") {
      DateTime now = DateTime.now();
      DateTime expiration = DateTime.parse(widget.specialExpiration);
      _duration = now.difference(expiration);
      amazingTime = _duration.inSeconds;

      startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // لغو تایمر وقتی ویجت از درخت حذف شد
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleProductScreen(id: widget.id),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(Dimensions.small),
        width: size.width / 2.5,
        margin: EdgeInsets.all(Dimensions.small),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.small),
          gradient: LinearGradient(
            colors: LightAppColors.productBgGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(widget.imagePath, height: 90),
            Dimensions.medium.height,
            Text(
              textDirection: TextDirection.rtl,
              widget.productName,
              style: LightAppTextStyle.title.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            Dimensions.medium.height,
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textDirection: TextDirection.rtl,
                        " ${widget.price.separateWithColon} تومان",
                        style: LightAppTextStyle.title.copyWith(fontSize: 10),
                      ),
                      if (widget.discount > 0)
                        Text(
                          textDirection: TextDirection.rtl,
                          "${widget.discountPrice.separateWithColon} تومان",
                          style: LightAppTextStyle.oldPrice,
                        ),
                    ],
                  ),
                  Visibility(
                    visible: widget.discount > 0 ? true : false,
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.small * 0.5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.redAccent,
                      ),
                      child: Text(
                        "${widget.discount}%",
                        style: LightAppTextStyle.title.copyWith(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: amazingTime > 0 ? true : false,
              child: Container(
                width: double.infinity,
                height: 2,
                color: Colors.blue,
              ),
            ),
            Dimensions.medium.height,
            Visibility(
              visible: amazingTime > 0 ? true : false,
              child: Text(
                formatTime(amazingTime),
                style: LightAppTextStyle.productTimer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
