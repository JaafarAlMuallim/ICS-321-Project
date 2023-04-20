import 'package:flutter/material.dart';

import '../authentication_respository/authentication_repository.dart';

class SignUpController {
  final name = TextEditingController();
  final uni = TextEditingController();

  Future<String> addDocument(String name, String phoneNum) async {
    String x = await AuthenticationRepository()
        .documentUserinFireStore(name, phoneNum);
    return x;
  }
}

void phoneAuthentication(String name, String uni, String phoneNum,
    String gender, BuildContext context) {
  AuthenticationRepository().phoneAuth(
    context: context,
    name: name,
    phoneNum: phoneNum,
  );
}
