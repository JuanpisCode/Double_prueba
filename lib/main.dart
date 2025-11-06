import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'controller/user_form.dart';
import 'controller/user_detail.dart';
import 'controller/address_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'User Manager (in-memory)',
        theme: ThemeData(primarySwatch: Colors.indigo),
        initialRoute: UserForm.routeName,
        routes: {
          UserForm.routeName: (_) => const UserForm(),
          AddressForm.routeName: (_) => const AddressForm(),
          UserDetail.routeName: (_) => const UserDetail(),
        },
      ),
    );
  }
}