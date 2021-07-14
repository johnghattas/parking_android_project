
class Comments{
  // int? id;

  String? firstName;
  String? secondName;
  int? review;
  String? comment;
  var created;
  var updated;
  Comments(/*this.id,*/this.comment, this.created,this.updated,this.review,this.firstName,this.secondName);

  Comments.fromMap(Map<dynamic,dynamic>map){
    comment=map['comment'];
    review=map['review'];
    created=map['created_at'];
    updated=map['updated_at'];
    firstName=map['user']['first_name'];
    secondName=map['user']['second_name'];
  }
  Map<String,dynamic>toMap(){
    final Map<String,dynamic>data=Map<String,dynamic>();
    data['comment']=comment;
    data['review']=review;
    data['created_at']=created;
    data['updated_at']=updated;
    data['user']['second_name']=firstName;
    data['user']['first_name']=firstName;
    return data;
  }
}


