import 'package:flutter/material.dart';
import 'package:marvel_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authConsumer, child) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black87),
        ),
        body: authConsumer.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authConsumer.currentUserModel!.id.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      authConsumer.currentUserModel!.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      authConsumer.currentUserModel!.phone,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      authConsumer.currentUserModel!.isActive.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      authConsumer.currentUserModel!.isVerified.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
