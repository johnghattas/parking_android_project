import 'package:flutter/material.dart';
import 'package:parking_project/fetch.dart';
import 'package:parking_project/garage_model.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name =TextEditingController();
  TextEditingController _city =TextEditingController();
  TextEditingController _street =TextEditingController();
  TextEditingController _bNum =TextEditingController();
  TextEditingController _capacity =TextEditingController();

  final underlineInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.purple));
  @override
  Widget build(BuildContext context) {

    // bool _value= false;
    var mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text('Data'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              right: mq.width * 0.05,
              left: mq.width * 0.05,
              top: mq.width * 0.02),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.02),
              ),
              Text('Fill your parking data',style: TextStyle(fontSize: 30,color: Colors.grey),),
              Padding(padding: EdgeInsets.only(bottom: mq.height/20)),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller:_name,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'please fill the fields';
                          }
                          return null;
                        },

                        decoration: InputDecoration(
                            labelText: 'Parking name',
                            labelStyle: TextStyle(
                              color: Colors.purple,
                            ),
                            icon: Icon(
                              Icons.local_parking,
                              color: Colors.purple,
                            ),
                            enabledBorder: underlineInputBorder),
                      ),
                      TextFormField(
                        controller:_city,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'please fill the fields';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'City',
                            labelStyle: TextStyle(
                              color: Colors.purple,
                            ),
                            icon: Icon(
                              Icons.location_city,
                              color: Colors.purple,
                            ),
                            enabledBorder: underlineInputBorder),
                      ),
                      TextFormField(
                        controller:_street,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'please fill the fields';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Street',
                            labelStyle: TextStyle(
                              color: Colors.purple,
                            ),
                            icon: Icon(
                              Icons.add_road,
                              color: Colors.purple,
                            ),
                            enabledBorder: underlineInputBorder),
                      ),
                      TextFormField(
                        controller: _bNum,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'please fill the fields';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'build number',
                            labelStyle: TextStyle(
                              color: Colors.purple,
                            ),
                            icon: Icon(
                              Icons.confirmation_number,
                              color: Colors.purple,
                            ),
                            enabledBorder: underlineInputBorder),
                      ),
                      TextFormField(
                        controller:_capacity,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'please fill the fields';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Capacity',
                            labelStyle: TextStyle(
                              color: Colors.purple,
                            ),
                            icon: Icon(
                              Icons.reduce_capacity,
                              color: Colors.purple,
                            ),
                            enabledBorder: underlineInputBorder),
                      ),
                    ],
                  )),
              ElevatedButton(
                child: Text(
                  'Add',
                ),
                onPressed: () => _addData(),
                style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    padding: EdgeInsets.symmetric(
                        horizontal: mq.width / 6, vertical: 5),
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addData() async {
    if (_formKey.currentState!.validate()) {

      String name = _name.text;
      String city = _city.text;
      String street = _street.text;
      int bNumber= int.parse(_bNum.text);
      int capacity = int.parse(_capacity.text);
      bool hasSystem = true;
      bool private = false;


      Model model = Model( bNumber, capacity, city, hasSystem, name, private, street);
      FetchApi api = FetchApi();
      bool isValid;
      try {
        isValid = await api.addData(model, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1Ni1J9.eyJpc3MiOiJodHRwOlwvXC9wYXJraW5ncHJvamVjdGdwLmhlcm9rdWFwcC5jb21cL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MTg2MDgxNDUsImV4cCI6MTYxODYxMTc0NSwibmJmIjoxNjE4NjA4MTQ1LCJqdGkiOiJkaks1a1AxaVduSDZHaEJmIiwic3ViIjoiNDJhS1V5YVdMRFZPamZGTzh3T0dET3hBTXZiMiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.n62CVHiqh_LV0TdctDfPcapweAoHrt4N2MI0aL-olhM');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()), ));
        return;
      }
      if(isValid) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('successful'), ));
      }else
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fail'), ));

      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => FilledData()));
    }
    print('empty fields!');
  }
}

// Form(key: _formKey,child: TextFormField(validator: (v){
//   if(v==null || v.isEmpty){
//     return 'please fill the fields';
//   }
//   return null;
// }, decoration: InputDecoration(
//     labelText: 'Parking name',
//     suffixIcon: Icon(
//       Icons.local_parking,
//       color: Colors.green,
//     )),),),

// Switch(activeColor: Colors.green, value: _value, onChanged: (change){
//   setState(() {
//     _value=change;
//   });
// })
