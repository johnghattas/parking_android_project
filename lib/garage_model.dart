class Model {
  int? id;
  String? name;
  String? city;
  String? street;
  int? bNumber;
  int? capacity;
  bool? private;
  bool? hasSystem;

  Model( this.bNumber, this.capacity, this.city, this.hasSystem,
      this.name, this.private, this.street);

  Model.fromMap(Map<String, dynamic> map) {
    print('code heree in from amp');

    id = map['id'];
    name = map['name'];
    city = map['city'];
    street = map['street'];
    bNumber = map['b_number'];
    capacity = map['capacity'];
    private = map['private'];

    hasSystem = map['hasSystem'];
    print('end here in from amp');

  }
  Map<String, dynamic>  toMap (){
    final Map<String,dynamic>data=new Map<String,dynamic>();
    data['name']=name;
    data['city']=city;
    data['street']=street;
    data['b_number']=bNumber.toString();
    data['capacity']=capacity.toString();
    //
    data['lat']='30.033333';
    data['long']= '31.233334';

    return data;
  }
}
