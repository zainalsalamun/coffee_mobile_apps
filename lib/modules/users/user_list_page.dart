import 'package:flutter/material.dart';
import 'package:coffe_mobile_apps/services/auth_services.dart';
import 'package:coffe_mobile_apps/models/user.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final AuthService _auth = AuthService();

  List<AppUser> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final data = await _auth.getAllUsers();
    setState(() {
      users = data;
    });
  }

  Future<void> _deleteUser(AppUser user) async {
    await _auth.deleteUser(user.id);
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5C2A2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5C2A2A),
        elevation: 0,
        title: const Text(
          "Daftar Pengguna",
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => Navigator.pushNamed(context, "/addUser"),
        child: const Icon(Icons.add, color: Color(0xFF5C2A2A)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final u = users[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: const AssetImage("assets/images/user.png"),
                    radius: 22,
                  ),
                  const SizedBox(width: 14),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        u.username,
                        style: const TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        u.role,
                        style: const TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Edit
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/editUser", arguments: u);
                    },
                    child: const Icon(Icons.settings, color: Colors.brown),
                  ),
                  const SizedBox(width: 18),

                  // Delete
                  GestureDetector(
                    onTap: () => _deleteUser(u),
                    child: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
