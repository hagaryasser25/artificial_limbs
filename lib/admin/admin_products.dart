import 'package:artificial_limbs/admin/add_product.dart';
import 'package:artificial_limbs/models/products_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class AdminProducts extends StatefulWidget {
  static const routeName = '/adminProducts';
  AdminProducts({super.key, });

  @override
  State<AdminProducts> createState() => _AdminProductsState();
}

class _AdminProductsState extends State<AdminProducts> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Products> productsList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchProducts();
  }

  @override
  void fetchProducts() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = await database.reference().child("products");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Products p = Products.fromJson(event.snapshot.value);
      productsList.add(p);
      keyslist.add(event.snapshot.key.toString());
      if (mounted) {
        setState(() {});
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              backgroundColor: HexColor('#F6B26B'),
              title: Center(
                  child: Text(
                "المنتجات",
                style: TextStyle(color: Colors.white),
              ))),
              floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 40.h, left: 10.w),
            child: FloatingActionButton(
              backgroundColor: HexColor('#F6B26B'),
              onPressed: () {
                Navigator.pushNamed(context, AddProduct.routeName);
              },
              child: Icon(Icons.add,color: Colors.white,),
            ),
          ),
          body: ListView.builder(
                itemCount: productsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 15.w, left: 15.w),
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 15, left: 15, bottom: 10),
                              child: Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: Container(
                                  width: 130.w,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 200.h,
                                          child: Image.network(
                                              '${productsList[index].imageUrl.toString()}',)),
                                      Text(
                                        '${productsList[index].name.toString()}',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'سعر المنتج : ${productsList[index].price.toString()}',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        'الكمية المتاحة : ${productsList[index].amount.toString()} متر',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                    
                                      Center(
                                        child: Text(
                                          '${productsList[index].description.toString()}',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 19,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          super.widget));
                                          FirebaseDatabase.instance
                                              .reference()
                                              .child('products')
                                              .child('${productsList[index].id}')
                                              .remove();
                                        },
                                        child: Icon(Icons.delete,
                                            color: Color.fromARGB(
                                                255, 122, 122, 122)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  );
                }),
        ),
      ),
    );
  }
}


