import 'package:flutter/material.dart';
import 'package:mkulima/misc/colors.dart';
import 'package:mkulima/model/pages_model.dart';
import 'package:mkulima/model/popups.dart';
import 'package:mkulima/pages/market_page/marketPage.dart';
import 'package:mkulima/pages/productPage/addProduct.dart';
import 'package:mkulima/pages/productPage/productsPage.dart';
import 'package:mkulima/pages/records_page/recordsPage.dart';
import 'package:mkulima/pages/subscriptions_page/subscriptionsPage.dart';

List<PagesModel> pages = [
  PagesModel(
      title: "Products",
      page: const ProductsPage(),
      icon: Icons.storage,
      color: Colors.amber[800]),
  PagesModel(
      title: "Market",
      page: const MarketPage(),
      icon: Icons.business_center_rounded,
      color: Colors.brown),
  PagesModel(
      title: "Records",
      page: const RecordsPage(),
      icon: Icons.data_thresholding,
      color: AppColors.bluetheme),
  PagesModel(
      title: "Premium",
      page: const SubscriptionsPage(),
      icon: Icons.subscriptions,
      color: Colors.red[900]),
];

var images = {
  "image1": 'images/plantation1.jpeg',
  "image2": 'images/plantation2.jpeg',
  "image3": 'images/plantation3.jpeg',
  "image4": 'images/plantation4.jpeg'
};

List<CustomPopupMenu> popups = [
  CustomPopupMenu(
      title: 'Add Product', icon: Icons.add, page: const AddProduct()),
];
