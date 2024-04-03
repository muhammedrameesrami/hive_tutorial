import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_tutorial/model.dart';
import 'package:intl/intl.dart';

import '../../addListPage/screen/addListPage.dart';

class ShowListPage extends StatefulWidget {
  const ShowListPage({super.key});

  @override
  State<ShowListPage> createState() => _ShowListPageState();
}

class _ShowListPageState extends State<ShowListPage> {
  Box? _productBox;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_productBox == null) {
      Hive.openBox('Product_box').then((value) {
        setState(() {
          _productBox = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('List Of Products'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddListPage(
                        fromId: 'add',
                      )));
        },
        child: Icon(CupertinoIcons.plus),
      ),
      body: _productBox == null
          ? Center(
              child: Text('No Product yet!'),
            )
          : SizedBox(
              height: double.infinity,
              width: 500,
              child: ValueListenableBuilder(
                  valueListenable: _productBox!.listenable(),
                  builder: (context, box, widget) {
                    print(box.keys);
                    print('keys');
                    final productKeys = box.keys.toList();
                    return ListView.builder(
                      itemCount: productKeys.length,
                      itemBuilder: (context, index) {
                        print('${productKeys.length}length-------------');
                        final productId = productKeys[index];
                        final product =
                            ProductModel.fromMap(box.get(productId));
                        print(product);
                        return Padding(
                          padding: EdgeInsets.only(top: 10, left: 7, right: 4),
                          child: Container(
                            height: 125,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blueAccent,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      DateFormat.yMMMMd()
                                          .format(product.createdDate),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                        width: 255,
                                        child: Text(
                                          product.productId,
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        width: 255,
                                        child: Center(
                                            child: Text(
                                          product.productName,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ))),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      product.productCount.toString(),
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddListPage(
                                                        productModel: product,
                                                        fromId: 'edit',
                                                        Indexx: index,
                                                      )));
                                        },
                                        icon: Icon(Icons.edit),
                                        color: Colors.white),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.delete),
                                      color: Colors.white,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
    );
  }
}
