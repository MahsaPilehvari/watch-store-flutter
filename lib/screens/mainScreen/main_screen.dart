import 'package:flutter/material.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/resources/colors.dart';
import 'package:watch_store/resources/strings.dart';
import 'package:watch_store/screens/shopping_cart/shopping_cart_screen.dart';
import 'package:watch_store/screens/home/home_screen.dart';
import 'package:watch_store/screens/profile/profile_screen.dart';
import 'package:watch_store/widgets/btmNavigation_item.dart';

class BtmNavIndex {
  BtmNavIndex._();
  static const home = 0;
  static const basket = 1;
  static const profile = 2;
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<int> _routeHistory = [BtmNavIndex.home];

  int selectedIndex = BtmNavIndex.home;
  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();
  final GlobalKey<NavigatorState> _basketKey = GlobalKey();

  late final map = {
    BtmNavIndex.home: _homeKey,
    BtmNavIndex.basket: _basketKey,
    BtmNavIndex.profile: _profileKey,
  };

  Future<bool> _onWillPop() async {
    if (map[selectedIndex]!.currentState!.canPop()) {
      map[selectedIndex]!.currentState!.pop();
    } else {
      setState(() {
        _routeHistory.removeLast();
        selectedIndex = _routeHistory.last;
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double bNHeight = size.height * .1;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (!didPop) {
          await _onWillPop();
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: bNHeight,
              child: IndexedStack(
                index: selectedIndex,
                children: [
                  Navigator(
                    key: _homeKey,
                    onGenerateRoute:
                        (settings) => MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                  ),
                  Navigator(
                    key: _basketKey,
                    onGenerateRoute:
                        (settings) => MaterialPageRoute(
                          builder: (context) => ShoppingCartScreen(),
                        ),
                  ),
                  Navigator(
                    key: _profileKey,
                    onGenerateRoute:
                        (settings) => MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: LightAppColors.bottomNavigation,
                height: bNHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BtmNavItem(
                      svgPicturePath: Assets.svg.user,
                      isActive: selectedIndex == BtmNavIndex.profile,
                      text: AppStrings.profile,
                      onTap: () => btmNavOnPressed(index: BtmNavIndex.profile),
                    ),
                    BtmNavItem(
                      svgPicturePath: Assets.svg.cart,
                      isActive: selectedIndex == BtmNavIndex.basket,
                      text: AppStrings.basket,
                      onTap: () => btmNavOnPressed(index: BtmNavIndex.basket),
                    ),
                    BtmNavItem(
                      svgPicturePath: Assets.svg.home,
                      isActive: selectedIndex == BtmNavIndex.home,
                      text: AppStrings.home,
                      onTap: () => btmNavOnPressed(index: BtmNavIndex.home),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  btmNavOnPressed({required index}) {
    setState(() {
      selectedIndex = index;
      _routeHistory.add(selectedIndex);
    });
  }
}
