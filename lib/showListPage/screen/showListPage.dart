import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../addListPage/screen/addListPage.dart';

class ShowListPage extends StatefulWidget {
  const ShowListPage({super.key});

  @override
  State<ShowListPage> createState() => _ShowListPageState();
}

class _ShowListPageState extends State<ShowListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Of Products'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddListPage()));
        },
        child: Icon(CupertinoIcons.plus),
      ),
      body: SizedBox(
        height: double.infinity,
        width: 500,
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 10, left: 7, right: 4),
              child: Container(
                height: 110,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blueAccent,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('date'),
                        SizedBox(
                          width: 10,
                        ),
                        Text('productId')
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('productname'),
                        SizedBox(
                          width: 20,
                        ),
                        Text('productCount')
                      ],
                    ),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                      IconButton(onPressed: (){}, icon: Icon(Icons.delete))
                    ],)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
