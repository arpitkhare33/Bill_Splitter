import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage=0;
  int _personCounter=1;
  double _billAmount=0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),//dynamic height
        alignment: Alignment.center,
        color: Colors.white ,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: BorderRadius.circular(12),

              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Total Per Person',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.purpleAccent,
                    ),),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('\$ ${calculateTotalPerPerson( _billAmount, _personCounter,_tipPercentage)}',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 34.9,
                        color: Colors.purpleAccent,
                      ),),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.blueGrey.shade100,style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(12),

              ),
              child: Column(
                children: <Widget>[

                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.purpleAccent),
                    decoration: InputDecoration(
                      prefixText: 'Bill Amount',
                      prefixIcon: Icon(Icons.attach_money),

                    ),
                    onChanged: (String value){
                      try{
                        _billAmount=double.parse(value);
                      }
                      catch(exception){

                        _billAmount =0.0;
                      }

                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Split',style: TextStyle(
                        color: Colors.grey.shade700,
                      ),),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: ()
                            {
                              setState(() {
                                if(_personCounter>1)
                                  {
                                    _personCounter--;
                                  }
                                else{
                                  //do nothing,don't decrement
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.purpleAccent.withOpacity(0.1),

                              ),
                              child: Center(
                                child: Text('-',style: TextStyle(
                                  color: Colors.purpleAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,

                                ),),
                              ),
                            ),
                          ),
                          Text('$_personCounter',style: TextStyle(
                            color: Colors.purpleAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),),
                          InkWell(
                            onTap: ()
                            {
                              setState(() {
                                _personCounter++;
                              }
                               );
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.purpleAccent.withOpacity(0.1),

                              ),
                              child: Center(
                                child: Text('+',style: TextStyle(
                                  color: Colors.purpleAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,

                                ),),
                              ),
                            ),
                          ),

                        ],
                      ),

                      //Tip
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Tip',style: TextStyle(
                            color: Colors.grey.shade700,


                          ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text('\$ ${(calulateTotalTip(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2)}',style: TextStyle(
                              color: Colors.purpleAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),),
                          ),
                        ],
                      )
                    ],
                  ),
                  //Slider
                  Column(
                    children: <Widget>[
                      Text('$_tipPercentage%',style: TextStyle(
                        color: Colors.purpleAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      ),
                      Slider(
                        min: 0.0,
                        max: 100.0,
                        activeColor: Colors.purpleAccent,
                        inactiveColor: Colors.grey,
                        divisions: 10,//optional
                        value: _tipPercentage.toDouble(),
                        onChanged: (double value ){
                          setState(() {
                            _tipPercentage =value.round();
                          });
                        },

                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  calculateTotalPerPerson( double billAmount, int splitBy,int tipPercentage){

// splitBy is the number of person
    var totalPerPerson = (calulateTotalTip(billAmount, splitBy, tipPercentage) +billAmount)/splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }
  calulateTotalTip( double billAmount, int splitBy, int tipPercentage ){
    double totalTip=0.0;
    if(billAmount<0 || billAmount.toString().isEmpty || billAmount==null ){
      // no go!

    }
    else{
      totalTip = (billAmount*tipPercentage)/100;
      return totalTip;
    }
  }
}
