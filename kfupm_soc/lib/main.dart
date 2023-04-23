import 'package:firebase_auth/firebase_auth.dart' as fire_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_soc/my_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  fire_auth.FirebaseAuth.instance
      .authStateChanges()
      .listen((fire_auth.User? user) {
    if (user == null) {
    } else {}
  });
  await Supabase.initialize(
    url: 'https://ovjfjgtuhzwbqzjlbzex.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im92amZqZ3R1aHp3YnF6amxiemV4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODIxODM2NzEsImV4cCI6MTk5Nzc1OTY3MX0.avFViqQymYP_5DwOzpmrkouqCZ9-mke3vhfeiZhc9Ak',
  );
  runApp(const MyApp());
}
