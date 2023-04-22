import 'package:flutter/material.dart';

import '../authentication_respository/authentication_repository.dart';

class SignUpController {
  final name = TextEditingController();
  final uni = TextEditingController();

  Future<String> addDocument(
      String name, String phoneNum, String kfupmId, String bdate) async {
    String x = await AuthenticationRepository()
        .documentUserinFireStore(name, phoneNum, kfupmId, bdate);
    return x;
  }
}

void phoneAuthentication(String name, String phoneNum, String kfupmId,
    DateTime bdate, BuildContext context) {
  AuthenticationRepository().phoneAuth(
    context: context,
    name: name,
    phoneNum: phoneNum,
    kfupmId: kfupmId,
    bdate: bdate,
  );
}
