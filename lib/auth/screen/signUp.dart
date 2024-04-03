import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController phonenumber=TextEditingController();
  TextEditingController name=TextEditingController();

  Future registration()async{
    var regApiUrl='https://protocoderspoint.com/php/registration.php';
    Map maped={
      'name':name.text,
      'email':email.text,
      'phone':phonenumber.text,
      'password':password.text
    };
    http.Response response=await http.post(Uri.parse(regApiUrl),body:maped);
    var data =jsonDecode(response.body);
    print('data : ${data}');
    if(data['success']=='1'){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('success now Sign in to check')));
Navigator.pop(context);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('failed')));

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,
          title: Text('SignUp'),),
      body: Container(color: Colors.blue,
          child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.blue)),
                    isDense: true,
                    // Added this
                    contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  ),
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.blue)),
                    isDense: true,
                    // Added this
                    contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  ),
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.blue)),
                    isDense: true,
                    // Added this
                    contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  ),
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(keyboardType: TextInputType.number,
                  controller: phonenumber,
                  decoration: InputDecoration(
                    hintText: 'phoneNumber',
                    hintStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.blue)),
                    isDense: true,
                    // Added this
                    contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  ),
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                ),
              ),

              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
registration();
              }, child: Text('SignUp')),

            ],),),
    );
  }
}
