import 'package:artificial_limbs/admin/admin_products.dart';
import 'package:artificial_limbs/auth/login_screen.dart';
import 'package:artificial_limbs/user/user_products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class UserHome extends StatefulWidget {
  static const routeName = '/userHome';
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            backgroundColor: HexColor('#F6B26B'),
            title: Center(
                child: Text(
              'الصفحة الرئيسية',
              style: TextStyle(
                color: Colors.white,
              ),
            )),
          ),
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: 200.h,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [.01, .25],
                        colors: [HexColor('#F6B26B'), HexColor('#F6B26B')],
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/images/logo.png'),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Material(
                    color: Colors.transparent,
                    child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                             Navigator.pushNamed(
                              context, UserProducts.routeName);
                          },
                          title: Text("المنتجات"),
                          leading: Icon(Icons.apps),
                        ))),
                Divider(
                  thickness: 0.8,
                  color: Colors.grey,
                ),
                Material(
                    color: Colors.transparent,
                    child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                            // Navigator.pushNamed(
                            //  context, UserCart.routeName);
                          },
                          title: Text("سلة المشتريات"),
                          leading: Icon(Icons.shopping_cart),
                        ))),
                        
        
                Divider(
                  thickness: 0.8,
                  color: Colors.grey,
                ),
                Material(
                    color: Colors.transparent,
                    child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('تأكيد'),
                                    content:
                                        Text('هل انت متأكد من تسجيل الخروج'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          FirebaseAuth.instance.signOut();
                                          Navigator.pushNamed(
                                              context, LoginScreen.routeName);
                                        },
                                        child: Text('نعم'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('لا'),
                                      ),
                                    ],
                                  );
                                });
                          },
                          title: Text('تسجيل الخروج'),
                          leading: Icon(Icons.exit_to_app_rounded),
                        )))
              ],
            ),
          ),
          body: Column(
            children: [
              SizedBox(height: 20.h,),
              Container(
                  height: 350.h,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/user.jpg',
                  )),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'أهلا بك فى تطبيق الأطراف الصناعية',
                style: TextStyle(fontSize: 24, fontFamily: "reem"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
