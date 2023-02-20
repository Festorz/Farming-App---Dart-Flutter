import 'package:flutter/material.dart';
import 'package:mkulima/authentication/login.dart';
import 'package:mkulima/data/drawer_items.dart';
import 'package:mkulima/model/drawer_model.dart';
import 'package:mkulima/pages/home_Page/homePage.dart';
import 'package:mkulima/pages/market_page/marketPage.dart';
import 'package:mkulima/pages/productPage/productsPage.dart';
import 'package:mkulima/pages/records_page/recordsPage.dart';
import 'package:mkulima/pages/subscriptions_page/subscriptionsPage.dart';
import 'package:mkulima/provider/navigation_provider.dart';
import 'package:mkulima/server/authentication.dart';
import 'package:mkulima/widgets/apptext.dart';
import 'package:provider/provider.dart';

class DrawerNavigationBar extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  const DrawerNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authentication = Provider.of<Authentication>(context);

    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);

    final provider = Provider.of<NavigationProvider>(context);

    final isCollapsed = provider.isCollapsed;

    return SizedBox(
      width: isCollapsed ? MediaQuery.of(context).size.width * 0.2 : null,
      child: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 240, 244, 245),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24).add(safeArea),
                width: double.infinity,
                color: Colors.white12,
                child: buildHeader(isCollapsed),
              ),
              const Divider(color: Colors.black38),
              const SizedBox(height: 10),
              buildList(items: firstItems, isCollapsed: isCollapsed),
              const SizedBox(height: 5),
              const Divider(color: Colors.black38),
              const SizedBox(height: 5),
              buildList(
                  indexOffset: firstItems.length,
                  isCollapsed: isCollapsed,
                  items: secondItems,
                  auth: authentication),
              const SizedBox(height: 7),
              buildCollapsibleIcon(context, isCollapsed),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(
          {required bool isCollapsed,
          required List<DrawerItem> items,
          int indexOffset = 0,
          auth}) =>
      ListView.separated(
        padding: isCollapsed ? EdgeInsets.zero : padding,
        shrinkWrap: true,
        primary: false,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(height: 2),
        itemBuilder: (context, index) {
          final item = items[index];

          return buildMenuItem(
            isCollapsed: isCollapsed,
            text: item.title,
            icon: item.icon,
            onClicked: () => selectItem(context, indexOffset + index, auth),
          );
        },
      );

  void selectItem(BuildContext context, int index, auth) {
    navigateTo(page) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
    }

    Navigator.pop(context);

    switch (index) {
      case 0:
        navigateTo(const HomePage());
        break;
      case 1:
        navigateTo(const ProductsPage());
        break;
      case 2:
        navigateTo(const MarketPage());
        break;
      case 3:
        navigateTo(const RecordsPage());
        break;
      case 4:
        navigateTo(const SubscriptionsPage());
        break;
      case 5:
        auth.logout(context);
        navigateTo(const LoginPage());
        break;
      // case 6:
      //   break;
      // case 9:
      //   navigateTo(const MyAccount());
      //   break;
    }
  }

  Widget buildMenuItem({
    required bool isCollapsed,
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.black;
    final leading = Icon(icon, color: color);

    return Material(
      color: Colors.transparent,
      child: isCollapsed
          ? ListTile(
              title: leading,
              onTap: onClicked,
            )
          : ListTile(
              leading: leading,
              title: AppText(text: text, color: Colors.black, size: 15),
              onTap: onClicked,
            ),
    );
  }

  Widget buildCollapsibleIcon(BuildContext context, bool isCollapsed) {
    const double size = 52;
    final icon = isCollapsed
        ? Icons.arrow_forward_ios_outlined
        : Icons.arrow_back_ios_new_outlined;
    final alignment = isCollapsed ? Alignment.center : Alignment.centerRight;
    final margin = isCollapsed ? null : EdgeInsets.only(right: 16);
    final width = isCollapsed ? double.infinity : size;

    return Container(
        alignment: alignment,
        margin: margin,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: SizedBox(
              width: width,
              height: size,
              child: Icon(icon, color: Colors.black),
            ),
            onTap: () {
              final provider =
                  Provider.of<NavigationProvider>(context, listen: false);

              provider.toggleIsCollapsed();
            },
          ),
        ));
  }

  Widget buildHeader(bool isCollapsed) => isCollapsed
      ? Container(
          margin: const EdgeInsets.only(left: 5, right: 5),
          child: Image.asset('images/mkulima_s.png',
              width: 10, height: 48, fit: BoxFit.cover),
        )
      : Row(
          children: [
            const SizedBox(width: 10),
            Image.asset('images/mkulima.png',
                width: 48, height: 48, fit: BoxFit.cover),
            const SizedBox(width: 16),
            AppText(
              text: "Mkulima app",
              size: 25,
              color: Colors.red[700],
            ),
          ],
        );
}
