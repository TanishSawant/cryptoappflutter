import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptoappflutter/net/api_methods.dart';
import 'package:cryptoappflutter/ui/add_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double bitcoin = 0.0;
  double tether = 0.0;
  double ethereum = 0.0;

  @override
  // ignore: must_call_super
  void initState(){
    getValues();
    super.initState();
  }

  getValues() async{
    setState(() async {
      bitcoin = await getPrice("bitcoin");
      tether = await getPrice("tether");
      ethereum = await getPrice("ethereum");
    });
  }
  @override
  Widget build(BuildContext context) {
    // ignore: unused_element
    // ignore: missing_return
    double getValue(String id, double amount){
      if (id == "bitcoin") {
        return bitcoin * amount;
      } else if(id == "tether"){
        return tether * amount;
      } else if(id == "ethereum"){
        return ethereum * amount;
      }
    }
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection('Coins')
            .snapshots(),
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data.docs.map((document) {
                return Container(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Coin Name : ${document.id}"),
                      Text("Amount Owned : ${document.data()["Amount"]}"),

                    ],
                  ),
                );
              }).toList()
            );
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, 
            MaterialPageRoute(builder: (context)=> AddView())
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white
        ),
      ),
    );
  }
}