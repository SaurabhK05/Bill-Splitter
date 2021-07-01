import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BillSpliter extends StatefulWidget {
  @override
  _BillSpliterState createState() => _BillSpliterState();
}

class _BillSpliterState extends State<BillSpliter> {
  double _billamount = 0;
  int _personCount = 1;
  int _percentage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill Splitter"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade300,

      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            Container(
              width: 150,
              height: 170,
              decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(.1),
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Total Per Person", style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0
                    ),), 

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("\u{20B9} ${calculateTotalBillAmount(_billamount, _personCount, _percentage)}", 
                      style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0
                      ),),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.blueGrey.shade300,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(children: <Widget>[
                TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(color: Colors.deepPurple,
                  fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    prefixText: '\u{20B9}' " Bill Amount : ",
                    ),
                  onChanged: (String value) {
                    try {
                      _billamount = double.parse(value);
                    } catch (e) {
                      _billamount = 0.0;
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Split",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Row(children: <Widget>[
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (_personCount > 1) {
                              _personCount--;
                            }
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: Colors.deepPurple.withOpacity(0.1),
                          ),
                          child: Center(
                            child: Text(
                              "-",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "$_personCount",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _personCount++;
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: Colors.purple.withOpacity(0.1),
                          ),
                          child: Center(
                            child: Text(
                              "+",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0),
                            ),
                          ),
                        ),
                      )
                    ]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Tip",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text("\u{20B9} ${calculateTotalTip(_billamount, _percentage)}",
                        style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "$_percentage%",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    ),
                    Slider(
                        min: 0,
                        max: 100,
                        activeColor: Colors.deepPurple,
                        inactiveColor: Colors.grey,
                        divisions: 10,
                        value: _percentage.toDouble(),
                        onChanged: (double value) {
                          setState(() {
                            _percentage = value.round();
                          });
                        })
                  ],
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalBillAmount(double billAmount, int personCount, int percentage){

    var total = (calculateTotalTip(billAmount, percentage) + billAmount) / personCount;
    return total.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int percentage){
    if(billAmount < 0){
      // return GestureDetector(
      //   onTap: (){
      //     final snackBar = SnackBar(content: Text("-ve Amount Can not Calculated...!!"), 
      //     backgroundColor: Colors.deepPurple.shade300,);
      //     Scaffold.of(context).showSnackBar(snackBar);
          
      //   },
      // );
      
    }
    return (billAmount * percentage) / 100;
  }
}
