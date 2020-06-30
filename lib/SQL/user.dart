class User{
  int id;
  String phone;

  User(this.id, this.phone);


  Map<String,dynamic> toMap(){

    var map = <String,dynamic>{
      'id' : id,
      'phone' : phone
    };

    return map;
  }


  User.fromMap(Map<String,dynamic> map){
     id = map['id'];
     phone = map['phone'];

  }


}