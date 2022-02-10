class CreateAccDetails {
  String? uid;
  String? userName;
  String? email;

  CreateAccDetails(
      {this.uid,this.userName,this.email});

  factory CreateAccDetails.fromMap(map){
    return CreateAccDetails(
      uid: map['uid'],
      userName: map['userName'],
      email: map['email'],
    );
  }

  Map <String,dynamic> toMap(){
    return{
      'uid': uid,
      'userName': userName,
      'email': email,
    };
  }

}
