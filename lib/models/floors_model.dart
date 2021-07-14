class FloorsModel{
  int? id;
  int? capacity;
  int? number;
  FloorsModel.init();
  FloorsModel(this.number,this.capacity);


  FloorsModel.fromMap(Map<String,dynamic> map){
    id=map['id'];
    capacity=map['capacity'];
    number=map['number'];
  }
  Map<String,dynamic> toMap(){
    final Map<String,dynamic> data=new Map<String,dynamic>();
    // data["id"]=(id);
    data["capacity"]=capacity.toString();
    data["number"]=number.toString();
    return data;
  }

}
