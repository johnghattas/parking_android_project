class Garage {
  int? id;
  String? city;
  String? street;
  int? bNumber;
  int? capacity;
  String? name;
  double? lat;
  double? long;
  bool? isPrivate;
  bool? hasSystem;

  Garage(
      {this.id,
        this.city,
        this.street,
        this.bNumber,
        this.capacity,
        this.name,
        this.lat,
        this.long,
        this.isPrivate = true,
        this.hasSystem = false,
        });

  Garage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    street = json['street'];
    bNumber = json['b_number'];
    capacity = json['capacity'];
    name = json['name'];
    lat = double.parse(json['lat']);
    long = double.parse(json['long']);
    isPrivate = json['is_private'] == 1? true : false;
    hasSystem = json['has_system']== 1? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city'] = this.city;
    data['street'] = this.street;
    data['b_number'] = this.bNumber;
    data['capacity'] = this.capacity;
    data['name'] = this.name;
    data['lat'] = this.lat.toString();
    data['long'] = this.long.toString();
    data['is_private'] = this.isPrivate!? 1 : 0;
    data['has_system'] = this.hasSystem!? 1 : 0;
    return data;
  }
}