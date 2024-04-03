import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_tutorial/auth/screen/signUp.dart';
import 'package:hive_tutorial/showListPage/screen/showListPage.dart';
import 'package:http/http.dart'as http;
class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  _Login_PageState createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  bool isChecked = false;

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  late Box box1;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createBox();
  }

  void createBox() async {
    box1 = await Hive.openBox('User_box');
    getData();

  }

  void getData()async{
    if(box1.get('email')!=null){
      email.text=box1.get('email');
      isChecked=true;
      setState(() {

      });
    }
    if(box1.get('password')!=null){
pass.text=box1.get('password');
    }
  }

  Future<void> login (BuildContext context) async {
   var regApiUrl='https://protocoderspoint.com/php/login.php';
   Map mapped={
     'email':email.text,
     'password':pass.text
   };
   http.Response response=await http.post(Uri.parse(regApiUrl),body: mapped);
   var data=jsonDecode(response.body);
   if(data['success']=='1'){
     if(isChecked){
box1.put('email', email.value.text);
box1.put('pass', pass.value.text);
     }
     box1.put('WelPage_name', data['name']);
     box1.put('WelPage_email', data['email']);
     box1.put('WelPage_phone', data['phone']);
     box1.put('isLogged', true);
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ShowListPage()), (route) => false);
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Center(
            child: Text(
              'Login',
              style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w600),
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Container(color: Colors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    controller: pass,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Remember Me",
                      style: TextStyle(color: Colors.white),
                    ),
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        isChecked = !isChecked;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));},
                  child: const Text(
                    "dont Have Account ? SignUp Now",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
               ElevatedButton(onPressed: (){
                 login(context);
                 Navigator.pushReplacement(context,
                     MaterialPageRoute(builder: (context) => ShowListPage()));
               }, child: Text('Login')),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),

    );
  }
}
