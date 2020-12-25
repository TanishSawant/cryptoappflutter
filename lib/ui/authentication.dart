import 'package:cryptoappflutter/net/flutterFire.dart';
import 'package:cryptoappflutter/ui/home_view.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passController = TextEditingController();
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.blueAccent
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.white, fontSize: 20.0),
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  hintStyle: TextStyle(
                    color: Colors.white
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Colors.white
                  )
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.white, fontSize: 20.0),
                controller: _passController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  hintStyle: TextStyle(
                    color: Colors.white
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: Colors.white
                  )
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async{
                  bool _registeredSuccessfully = await register(_emailController.text, _passController.text);
                  if (_registeredSuccessfully) {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeView())
                    );
                  } else {
                    //TODO: Stay on the same page
                  
                  }
                },
                child: Text(
                  "Register"
                ),
              )
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async{
                  bool _signedinSuccessfully = await signIn(_emailController.text, _passController.text);
                  if (_signedinSuccessfully) {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> HomeView())
                    );
                  } else {
                    //TODO: Stay on the same page
                  
                  }
                },
                child: Text(
                  "Login"
                ),
              )
            )
          ],
        )
      ),
    );
  }
}