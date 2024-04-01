import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddListPage extends StatefulWidget {
  const AddListPage({super.key});

  @override
  State<AddListPage> createState() => _AddListPageState();
}

class _AddListPageState extends State<AddListPage> {
  TextEditingController productName=TextEditingController();
  TextEditingController productCount=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.back)),
        title: Text('Add Product'),
      ),
      body: Container(width: 500,
        height: double.infinity,color: Colors.blueAccent,child: Column(
        children: [
          SizedBox(height: 80,),
          SizedBox(
            width: 300,
            height:50,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '*required';
                }
                return null; // Return null if the input is valid
              },
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 14),

              controller: productName,
              decoration: InputDecoration(
                hintText: "Product Name",
                hintStyle:
                TextStyle(color: Colors.grey),
                errorBorder: const OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.transparent)),
                errorStyle: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 9),

                focusedErrorBorder: const OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.transparent)),
                contentPadding: EdgeInsets.only(left: 20),
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                        color: Colors.transparent)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    )),
                // labelText: "Title",
              ),
            ),
          ),
          SizedBox(height: 20,),
          SizedBox(
            width: 300,
            height:50,
            child: TextFormField(keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '*required';
                }
                return null; // Return null if the input is valid
              },
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 14),

              controller: productCount,
              decoration: InputDecoration(
                hintText: "Product Count",
                hintStyle:
                TextStyle(color: Colors.grey),
                errorBorder: const OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.transparent)),
                errorStyle: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 9),

                focusedErrorBorder: const OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.transparent)),
                contentPadding: EdgeInsets.only(left: 20),
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                        color: Colors.transparent)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    )),
                // labelText: "Title",
              ),
            ),
          ),
          SizedBox(height: 30,),
          ElevatedButton(onPressed: (){},child: Text('Add Product'),)
        ],
      ),),
    );
  }
}
