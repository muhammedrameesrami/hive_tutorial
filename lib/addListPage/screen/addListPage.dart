import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_tutorial/model.dart';

class AddListPage extends StatefulWidget {
  AddListPage({super.key, this.productModel, required this.fromId,this.Indexx=0 });
  ProductModel? productModel;
  final String fromId;
  final int Indexx;
  @override
  State<AddListPage> createState() => _AddListPageState();
}

class _AddListPageState extends State<AddListPage> {
  Box? _todoBox;

  TextEditingController? productName;
  TextEditingController? productCount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Hive.openBox('Product_box').then((value) {
      setState(() {
        _todoBox = value;
      });
    });
    productName = TextEditingController(
        text: widget.fromId == 'add' ? "" : widget.productModel!.productName);
    productCount = TextEditingController(
        text: widget.fromId == 'add'
            ? ''
            : widget.productModel!.productCount.toString());
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.back)),
        title: Text(widget.fromId == 'add' ? 'Add Product' : 'Edit Product'),
      ),
      body: Container(
        width: 500,
        height: double.infinity,
        color: Colors.blueAccent,
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '*required';
                  }
                  return null; // Return null if the input is valid
                },
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                controller: productName,
                decoration: InputDecoration(
                  hintText: "Product Name",
                  hintStyle: TextStyle(color: Colors.grey),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  errorStyle:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 9),

                  focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  contentPadding: EdgeInsets.only(left: 20),
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      )),
                  // labelText: "Title",
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '*required';
                  }
                  return null; // Return null if the input is valid
                },
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                controller: productCount,
                decoration: InputDecoration(
                  hintText: "Product Count",
                  hintStyle: TextStyle(color: Colors.grey),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  errorStyle:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 9),

                  focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  contentPadding: EdgeInsets.only(left: 20),
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      )),
                  // labelText: "Title",
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                final product = ProductModel(
                    productName: productName!.text.trim(),
                    productId: ProductModel.generateProductId(),
                    productCount: double.tryParse(productCount!.text.trim())!,
                    createdDate: DateTime.now(),
                    delete: false);
                if (productName!.text.trim().isNotEmpty &&
                    productCount!.text
                        .trim()
                        .isNotEmpty)
                  if (widget.fromId == 'add') {
                  _todoBox?.put(product.productId, product.toMap());
                }
                else if (widget.fromId == 'edit') {
                  final ProductModel= widget.productModel!.copyWith(
                      createdDate: DateTime.now(),
                      productName: productName!.text.trim(),
                      productCount:
                      double.tryParse(productCount!.text.trim()));
                  _todoBox?.putAt(
                     widget.Indexx,ProductModel
                     );
                  print(widget.productModel!.copyWith(productName: productName!.text).toMap());
                }

                productCount!.clear();
                productName!.clear();
                Navigator.pop(context);
              },
              child:
                  Text(widget.fromId == 'add' ? 'Add Product' : 'Edit Product'),
            )
          ],
        ),
      ),
    );
  }
}
