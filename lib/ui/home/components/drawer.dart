import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:here4u/emergency/emergency.dart';
import 'package:here4u/ui/addpost/addpost.dart';
import 'package:here4u/ui/adminControl_screen/adminControlHelperKita_screen.dart';
import 'package:here4u/ui/adminControl_screen/adminControlVolunteers_screen.dart';
import 'package:here4u/ui/helperkits/helperkits.dart';
import 'package:here4u/ui/home/components/volontaries.dart';
import 'package:here4u/ui/maps/maps_nearby_place_screen.dart';
import 'package:here4u/ui/provider/permission_provider.dart';
import 'package:here4u/ui/widgets/mywidgets.dart';
import 'package:provider/provider.dart';

class DrawePage extends StatelessWidget {
  const DrawePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PermissionsProvider permissionsProvider =
        Provider.of<PermissionsProvider>(context, listen: false);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.white),
            child: Container(
              width: 100.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/logo/logo.jpeg"), fit: BoxFit.contain),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.add,
              color: Colors.red,
            ),
            title: Text('إضافة منشور'),
            onTap: () {
              Navigator.pushNamed(context, AddPost.id);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.app_registration,
              color: Colors.red,
            ),
            title: Text('التسجيل على معونة'),
            onTap: () {
              Navigator.pushNamed(context, HelperKits.id);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.radio_button_on,
              color: Colors.red,
            ),
            title: Text(
              'طلب الإسعاف',
            ),
            onTap: () {
              Navigator.pushNamed(context, EmergencyPage.id);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.location_on,
              color: Colors.red,
            ),
            title: Text(
              'الوصول إلى أقرب مشفى',
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MapsNearByPlacesScreen(
                            placetoSearch: "hospital",
                            typetoSearch: "hospital",
                          )));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.location_on,
              color: Colors.red,
            ),
            title: Text(
              'الوصول إلى أقرب صيدلية',
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MapsNearByPlacesScreen(
                            placetoSearch: "pharmacy",
                            typetoSearch: "pharmacy",
                          )));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.archive_rounded,
              color: Colors.red,
            ),
            title: Text('باب التطوع'),
            onTap: () {
              Navigator.pushNamed(context, Voluntaries.id);
            },
          ),
          Visibility(
            visible: permissionsProvider.adminSigned,
            child: ListTile(
              leading: Icon(
                Icons.admin_panel_settings,
                color: Colors.red,
              ),
              title: Text('صفحة إدارة طلبات المعونات'),
              onTap: () {
                Navigator.pushNamed(context, AdminControlHelperKitsScreen.id);
              },
            ),
          ),
          Visibility(
            visible: permissionsProvider.adminSigned,
            child: ListTile(
              leading: Icon(
                Icons.admin_panel_settings,
                color: Colors.red,
              ),
              title: Text('صفحة إدارة طلبات التطوع'),
              onTap: () {
                Navigator.pushNamed(context, AdminControlVolunteersScreen.id);
              },
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.help,
              color: Colors.red,
            ),
            title: Text('حول'),
            onTap: () {
              //   Navigator.pushNamed(context, Voluntaries.id);
              MyWidgets mywidget = new MyWidgets();
              mywidget.displaySnackMessage('الهلال الأحمر العربي السوري', context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text('خروج'),
            onTap: () {
              // exit out of the program
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}
