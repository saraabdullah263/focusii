class UserModel {
  String? email;
  String? name;
  String? gender; // fixed typo
  String? password;
  String? confirmPassword; // improved naming consistency
  int? age;
  String? token;
  String? pictureUrl;
  DateTime ? dateOfCreation;
  String ?childClass;
  int ?totalScore;

  UserModel({
    this.email,
    this.name,
    this.token,
    this.age,
    this.confirmPassword,
    this.gender,
    this.password,
    this.pictureUrl, this.dateOfCreation,
    this.childClass,
    this.totalScore
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    token = json['token'];
    age = json['age'];
    gender = json['gender'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    pictureUrl = json['pictureUrl'];
    childClass=json['childClass'];
    totalScore=json['totalScore'];
    dateOfCreation= json['dateOfCreation'] != null
          ? DateTime.tryParse(json['dateOfCreation'])
          : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['token'] = token;
    data['age'] = age;
    data['gender'] = gender;
    data['password'] = password;
    data['confirmPassword'] = confirmPassword;
    data['pictureUrl'] = pictureUrl;
    data['childClass']=childClass;
    data['dateOfCreation'] = dateOfCreation;
    data['totalScore']=totalScore;
    return data;
  }
}
