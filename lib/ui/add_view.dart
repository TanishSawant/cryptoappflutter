import 'package:flutter/material.dart';

class AddView extends StatefulWidget {
  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  String menuItem = "BitCoin";
  @override
  Widget build(BuildContext context) {
    List<String> coins = [
      "BitCoin",
      "tether",
      "ethereum"
    ];
    TextEditingController _amountController = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          DropdownButton(
            value: menuItem,
            onChanged: (String value) {
              setState(() {
                menuItem = value;
              });
            },
            items: coins.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(
                  value
                )
              );
            }).toList(),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: "Coin Amount"
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                top: 20.0
              ),
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async{
                  //TODO: IMPLEMENT ADD LOGIC                  
                  Navigator.pop(context);
                },
                child: Text(
                  "Add"
                ),
              )
            )
        ],
      ),
    );
  }
}