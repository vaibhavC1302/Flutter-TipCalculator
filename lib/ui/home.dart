import 'package:flutter/material.dart';

class tipcal extends StatefulWidget {
  @override
  _tipcalState createState() => new _tipcalState();
}

class _tipcalState extends State<tipcal> {
  double _billamount = 0.0;
  int _tippercentage = 0;
  int _personcounter = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade400,
              Colors.blue.shade100
            ]
          )
        ),
        alignment: Alignment.center,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.0),
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    const Text(
                      "Total Per Person:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("\$ ${totalperperson(_billamount,_personcounter ,_tippercentage)}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.blueGrey.shade100,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: [
                  TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(fontSize: 20.0),
                      decoration: const InputDecoration(
                          prefixText: "Bill Amount--",
                          prefixIcon: Icon(Icons.attach_money)),
                      onChanged: (String value) {
                        try {
                          _billamount = double.parse(value);
                        } catch (exceptions) {
                          _billamount = 0.0;
                        }
                        ;
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Split:",
                        style: TextStyle(fontSize: 18),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personcounter > 1) {
                                  _personcounter--;
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(7.0)),
                              height: 40.0,
                              width: 40.0,
                              child: const Center(
                                  child: Text(
                                "-",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                          Text("$_personcounter",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _personcounter++;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(7.0)),
                              child: const Center(
                                  child: Text(
                                "+",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tip:", style: TextStyle(fontSize: 18)),
                      Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text("${calculatetip(_billamount, _tippercentage)}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${_tippercentage}%",
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: Colors.blue.shade400,
                          inactiveColor: Colors.blue,
                          value: _tippercentage.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              _tippercentage = value.round();
                            });
                          }),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  calculatetip(double totalbill, int tipper) {
    double totaltip = 0.0;
    if (totalbill < 0 || totalbill
        .toString()
        .isEmpty || totalbill == null) {} else {
      totaltip = (totalbill * tipper) / 100;
    }
    return totaltip;
  }
  
  totalperperson(double totalbill,int personcount,int tipper){
    double billperperson = 0.0 ;
    billperperson = (totalbill + calculatetip(totalbill, tipper))/personcount ;
    return billperperson.toStringAsFixed(2) ;
  }

}
