import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:watch_store/screens/product_list/product_list_screen.dart';

extension SizedBoxExtension on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}

extension IntExtension on int {
  String get separateWithColon {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }
}

extension ProductSortExtension on ProductSort {
  String toText() {
    switch (this) {
      case ProductSort.mostViewed:
        return 'پربازدیدترین';
      case ProductSort.newest:
        return 'جدیدترین';
      case ProductSort.cheapest:
        return 'ارزان‌ترین';
      case ProductSort.mostExpensive:
        return 'گران‌ترین';
    }
  }

  String toParam() {
    switch (this) {
      case ProductSort.mostViewed:
        return "/most_viewed_products";
      case ProductSort.newest:
        return "/newest_products";
      case ProductSort.cheapest:
        return "/cheapest_products";
      case ProductSort.mostExpensive:
        return "/most_expensive_products";
    }
  }
}
