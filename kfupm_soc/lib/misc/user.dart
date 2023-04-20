class AppUser {
  int? id;
  String? name;
  String? phoneNum;

  get getId => id;

  set setId(id) => this.id = id;

  get getName => name;

  set setName(name) => this.name = name;

  get getPhoneNum => phoneNum;

  set setPhoneNum(String? phoneNum) => phoneNum = phoneNum;

  AppUser({this.id, this.name, this.phoneNum});
}
