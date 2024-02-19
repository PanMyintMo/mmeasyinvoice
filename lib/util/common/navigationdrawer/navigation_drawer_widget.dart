import 'package:flutter/material.dart';
import 'package:mmeasyInvoice/app_router.dart';
import 'package:mmeasyInvoice/auth/auth_module.dart';
import 'package:mmeasyInvoice/auth/auth_route.dart';
import 'package:mmeasyInvoice/util/home_route.dart';
import 'package:mmeasyInvoice/auth/home_module.dart';
import 'package:mmeasyInvoice/util/common/share_util.dart';
import 'package:mmeasyInvoice/util/common/navigationdrawer/menuexpansion.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({super.key});

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 20);
  String? utype;
  String? username;
  String? url;
  String? email;

  int _currentlyExpandedTileIndex = -1;

  List<bool> expansionStates = [
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  void initState() {
    super.initState();
    fetchUserType();
  }

  void handleExpansionChange(int tileIndex, bool expanded) {
    if (expanded) {
      setState(() {
        _currentlyExpandedTileIndex = tileIndex;
      });
    } else {
      setState(() {
        _currentlyExpandedTileIndex = -1;
      });
    }
    for (var i = 0; i < expansionStates.length; i++) {
      expansionStates[i] = i == _currentlyExpandedTileIndex;
    }
  }

  Future<void> fetchUserType() async {
    final preferences = SharePreferenceService();
    final userType = await preferences.getUserRole();
    final userName = await preferences.getUserName();
    final userEmail = await preferences.getUserEmail();

    setState(() {
      username = userName;
      email = userEmail;
      utype = userType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.white70,
        child: ListView(
          children: <Widget>[
            buildHeader(
              username: username,
              email: email,
              url: url ?? '',
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  buildSearchField(),
                  const SizedBox(height: 24),
                  buildMenuItems(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String url,
    required String? username,
    required String? email,
  }) {
    return InkWell(
      child: Container(
        color: Colors.black12,
        height: 250,
        padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: url.isNotEmpty ? NetworkImage(url) : null,
              child: url.isEmpty
                  ? const Icon(Icons.account_circle_rounded, size: 80)
                  : null,
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    username ?? '',
                    style: TextStyle(fontSize: 20, color: Colors.blue[400]),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    email ?? '',
                    style: TextStyle(fontSize: 14, color: Colors.blue[400]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchField() {
    var color = Colors.blue[300];

    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color!.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItems() {
    final List<MenuItem> categoryItem = [
      MenuItem(
          text: 'All Category',
          onClicked: () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.allCategory);
          }),
      MenuItem(
          text: 'Add Category',
          onClicked: () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.addCategory);
          })
    ];
    final List<MenuItem> sizeMenu = [
      MenuItem(
          text: 'All Size',
          onClicked: () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.allSize);
          }),
      MenuItem(
          text: 'Add Size',
          onClicked: () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.addSize);
          })
    ];
    final List<MenuItem> deliveryMenu = [
      MenuItem(
          text: 'View Delivery',
          onClicked: () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.viewDelivery);
          }),
      MenuItem(
          text: 'Add Delivery',
          onClicked: () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.addDelivery);
          })
    ];
    final List<MenuItem> userMenuItems = [
      MenuItem(
          text: 'All User',
          onClicked: () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.allUserRole);
          }),
      MenuItem(
          text: 'Add User',
          onClicked: () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.addUserRole);
          })
    ];
    final List<MenuItem> productMenu = [
      MenuItem(
          text: 'All Product',
          onClicked: () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.allProduct);
          }),
      MenuItem(
          text: 'Add Product',
          onClicked: () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.addProduct);
          })
    ];
    final List<MenuItem> order = [
      MenuItem(
          text: 'All Order',
          onClicked: () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.allOrder);
          }),
      MenuItem(
          text: 'Add Order',
          onClicked: () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.addOrder);
          }),
      MenuItem(
          text: 'Customer Profile',
          onClicked: () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.customerProfile);
          }),
      MenuItem(
          text: 'Customer Address',
          onClicked: () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.customerAddress);
          })
    ];
    final List<MenuItem> locationMenuItems = [
      MenuItem(
          text: 'View Country',
          onClicked: () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.viewCountry);
          }),
      MenuItem(
          text: 'View Cities',
          onClicked: () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.viewCity);
          }),
      MenuItem(
          text: 'View Townships',
          onClicked: () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.viewTownship);
          }),
      MenuItem(
          text: 'View Wards',
          onClicked: () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.viewWard);
          }),
      MenuItem(
          text: 'View Streets',
          onClicked: () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.viewStreet);
          }),
    ];

    return Column(
      children: [
        if (utype == 'SK' || utype == 'ADM')
          buildMenuItem(
            text: 'Dashboard',
            icon: Icons.home,
            onClicked: () {},
          ),
        const Divider(color: Colors.black12),
        if (utype == 'ADM')
          buildMenuItem(
            text: 'Delivery Man',
            icon: Icons.delivery_dining,
            onClicked: () {
              AppRouter.changeRoute<HomeModule>(
                HomeRoute.deliveryMan,
              );
            },
          ),
        const SizedBox(height: 16),
        CustomExpansionTile(
          text: 'Delivery System',
          icon: Icons.delivery_dining,
          items: deliveryMenu,
          initiallyExpanded: expansionStates[0],
          onExpansionChanged: (expanded) {
            handleExpansionChange(0, expanded);
          },
        ),
        const Divider(color: Colors.black12),
        const SizedBox(height: 16),
        if (utype == 'SK' || utype == 'ADM')
          buildMenuItem(
            text: 'ShopKeeper',
            icon: Icons.shop,
            onClicked: () {
              AppRouter.changeRoute<HomeModule>(HomeRoute.shopKeeper);
            },
          ),
        const SizedBox(height: 16),
        if (utype == 'ADM')
          buildMenuItem(
            text: 'FaultyItem',
            icon: Icons.add_business,
            onClicked: () {
              AppRouter.changeRoute<HomeModule>(HomeRoute.allFaultyItem);
            },
          ),
        const SizedBox(height: 16),
        const Divider(color: Colors.black12),
        const SizedBox(height: 16),
        if (utype == 'ADM')
          CustomExpansionTile(
            text: 'Category',
            icon: Icons.account_circle_rounded,
            items: categoryItem,
            initiallyExpanded: expansionStates[1],
            onExpansionChanged: (expanded) {
              handleExpansionChange(1, expanded);
            },
          ),
        const SizedBox(height: 16),
        if (utype == 'ADM')
          CustomExpansionTile(
            text: 'Size',
            icon: Icons.format_size,
            items: sizeMenu,
            initiallyExpanded: expansionStates[2],
            onExpansionChanged: (expanded) {
              handleExpansionChange(2, expanded);
            },
          ),
        const SizedBox(height: 16),
        CustomExpansionTile(
          text: 'Products',
          icon: Icons.account_circle_rounded,
          items: productMenu,
          initiallyExpanded: expansionStates[3],
          onExpansionChanged: (expanded) {
            handleExpansionChange(3, expanded);
          },
        ),
        const SizedBox(height: 16),
        CustomExpansionTile(
          text: 'User Role',
          icon: Icons.account_circle_rounded,
          items: userMenuItems,
          initiallyExpanded: expansionStates[4],
          onExpansionChanged: (expanded) {
            handleExpansionChange(4, expanded);
          },
        ),
        const Divider(color: Colors.black12),
        const SizedBox(height: 16),
        if (utype == 'ADM' || utype == 'SK')
          buildMenuItem(
            text: 'Product Invoice',
            icon: Icons.insert_drive_file_sharp,
            onClicked: () {
              AppRouter.changeRoute<HomeModule>(HomeRoute.productInvoice);
            },
          ),
        const SizedBox(height: 16),
        buildMenuItem(
          text: 'Company Profile',
          icon: Icons.camera_outdoor,
          onClicked: () {
            AppRouter.changeRoute<HomeModule>(HomeRoute.companyProfile);
          },
        ),
        const SizedBox(height: 16),
        CustomExpansionTile(
          text: 'Order Part',
          icon: Icons.percent_rounded,
          items: order,
          initiallyExpanded: expansionStates[5],
          onExpansionChanged: (expanded) {
            handleExpansionChange(5, expanded);
          },
        ),
        if (utype == 'SK')
          buildMenuItem(
            text: 'Product Invoice',
            icon: Icons.shop,
            onClicked: () {},
          ),
        if (utype == 'SK' || utype == 'ADM')
          CustomExpansionTile(
            text: 'Location',
            icon: Icons.location_pin,
            items: locationMenuItems,
            initiallyExpanded: expansionStates[6],
            onExpansionChanged: (expanded) {
              handleExpansionChange(6, expanded);
            },
          ),
        buildMenuItem(
          text: 'Logout',
          icon: Icons.exit_to_app,
          onClicked: () {
             AppRouter.changeRoute<AuthModule>(AuthRoutes.root);
            SharePreferenceService().removeToken();
            SharePreferenceService().removeUserRole(); 
           
          },
        ),
      ],
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.black;
    const hoverColor = Colors.green;
    Color? textColor = color;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: () {
        setState(() {
          textColor = (textColor == color) ? Colors.green : color;
        });
        if (onClicked != null) {
          onClicked();
        }
      },
    );
  }
}
