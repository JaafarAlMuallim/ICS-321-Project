class AppUser {
  String? name;
  String? phoneNum;
  String? kfupmId;
  String? bdate;

  get getName => name;

  set setName(name) => this.name = name;

  get getPhoneNum => phoneNum;

  set setPhoneNum(String? phoneNum) => this.phoneNum = phoneNum;

  get getKfupmId => kfupmId;

  set setKfupmId(String? kfupmId) => kfupmId = kfupmId;

  get getBdate => bdate;

  set setBdate(bdate) => this.bdate = bdate;

  AppUser({this.name, this.phoneNum, this.kfupmId, this.bdate});
}
