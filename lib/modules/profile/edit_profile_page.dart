import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/user.dart';
import '../../services/auth_services.dart';

enum ProfileMode { normal, addUser, selectUser, editOtherUser }

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final Color maroon = const Color(0xFF5C2A2A);
  final AuthService _auth = AuthService();

  ProfileMode mode = ProfileMode.normal;

  AppUser? currentUser;
  List<AppUser> otherUsers = [];
  List<int> selectedIds = [];

  // Controllers for editing own profile
  late TextEditingController nameC;
  late TextEditingController roleC;
  late TextEditingController passC;

  // Controllers for add/edit other users
  TextEditingController addNameC = TextEditingController();
  TextEditingController addRoleC = TextEditingController();
  TextEditingController addPassC = TextEditingController();
  AppUser? editingUser;

  // Avatar
  String? avatarPath;

  @override
  void initState() {
    super.initState();
    nameC = TextEditingController();
    roleC = TextEditingController();
    passC = TextEditingController();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await _auth.getLoggedInUser();
    final allUsers = await _auth.getAllUsers();

    if (user == null) return;

    setState(() {
      currentUser = user;

      nameC.text = user.username;
      roleC.text = user.role;
      passC.text = user.password;
      avatarPath = user.avatarPath; // ambil avatar

      otherUsers = allUsers.where((u) => u.id != user.id).toList();
    });
  }

  Future<void> _saveProfile() async {
    if (currentUser == null) return;

    await _auth.updateUser(
      currentUser!.id,
      nameC.text.trim(),
      passC.text.trim(),
      roleC.text.trim(),
      newAvatarPath: avatarPath,
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Profil berhasil diperbarui")));
  }

  Future<void> _saveNewUser() async {
    await _auth.register(
      addNameC.text.trim(),
      addPassC.text.trim(),
      role: addRoleC.text.trim(),
    );

    addNameC.clear();
    addRoleC.clear();
    addPassC.clear();

    setState(() => mode = ProfileMode.normal);
    _loadUser();
  }

  Future<void> _saveEditOtherUser() async {
    if (editingUser == null) return;

    await _auth.updateUser(
      editingUser!.id,
      addNameC.text.trim(),
      addPassC.text.trim(),
      addRoleC.text.trim(),
      newAvatarPath: avatarPath,
    );

    setState(() => mode = ProfileMode.normal);
    _loadUser();
  }

  Future<void> _deleteSelected() async {
    for (var id in selectedIds) {
      await _auth.deleteUser(id);
    }
    selectedIds.clear();
    setState(() => mode = ProfileMode.normal);
    _loadUser();
  }

  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return;

    final dir = await getApplicationDocumentsDirectory();
    final newPath = "${dir.path}/avatar_${currentUser!.id}.jpg";

    final file = await File(picked.path).copy(newPath);

    setState(() {
      avatarPath = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maroon,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(26, 30, 26, 120),
              child: _buildBody(),
            ),

            Positioned(
              bottom: 26,
              left: 0,
              right: 0,
              child: Center(child: _buildBottomButton()),
            ),

            Positioned(
              bottom: 23,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (mode) {
      case ProfileMode.addUser:
        return _buildAddUserForm();
      case ProfileMode.editOtherUser:
        return _buildEditOtherUserForm();
      case ProfileMode.selectUser:
        return _buildSelectUserList();
      default:
        return _buildNormalMode();
    }
  }

  Widget _buildNormalMode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAvatar(),

        _label("Nama"),
        _textFieldBox(controller: nameC),
        const SizedBox(height: 20),

        _label("Jabatan"),
        _textFieldBox(controller: roleC),
        const SizedBox(height: 20),

        _label("Password"),
        _textFieldBox(controller: passC, obscure: true),
        const SizedBox(height: 30),

        _label("Pengguna Lain:"),
        const SizedBox(height: 14),

        Column(
          children:
              otherUsers
                  .map(
                    (u) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _tileUserNormal(u),
                    ),
                  )
                  .toList(),
        ),

        const SizedBox(height: 18),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _clickText("Tambah", () {
              setState(() => mode = ProfileMode.addUser);
            }),
            _clickText("Pilih", () {
              selectedIds.clear();
              setState(() => mode = ProfileMode.selectUser);
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildAddUserForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAvatar(addMode: true),

        _label("Nama"),
        _textFieldBox(controller: addNameC),
        const SizedBox(height: 20),

        _label("Jabatan"),
        _textFieldBox(controller: addRoleC),
        const SizedBox(height: 20),

        _label("Password"),
        _textFieldBox(controller: addPassC, obscure: true),
      ],
    );
  }

  Widget _buildEditOtherUserForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAvatar(addMode: true),

        _label("Nama"),
        _textFieldBox(controller: addNameC),
        const SizedBox(height: 20),

        _label("Jabatan"),
        _textFieldBox(controller: addRoleC),
        const SizedBox(height: 20),

        _label("Password"),
        _textFieldBox(controller: addPassC, obscure: true),
      ],
    );
  }

  Widget _buildSelectUserList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAvatar(),

        _label("Pengguna Lain:"),
        const SizedBox(height: 14),

        Column(
          children:
              otherUsers
                  .map(
                    (u) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _tileUserSelect(u, selectedIds.contains(u.id)),
                    ),
                  )
                  .toList(),
        ),

        const SizedBox(height: 18),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _clickText("Batalkan", () {
              selectedIds.clear();
              setState(() => mode = ProfileMode.normal);
            }),
            _clickText("Hapus", _deleteSelected),
          ],
        ),
      ],
    );
  }

  Widget _buildAvatar({bool addMode = false}) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              if (!addMode) await _pickAvatar();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child:
                  avatarPath != null
                      ? Image.file(
                        File(avatarPath!),
                        width: 95,
                        height: 95,
                        fit: BoxFit.cover,
                      )
                      : Image.asset(
                        "assets/images/user.png",
                        width: 95,
                        height: 95,
                        fit: BoxFit.cover,
                      ),
            ),
          ),
          const SizedBox(height: 12),

          if (!addMode)
            const Text(
              "Tap untuk ubah foto",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontFamily: 'Georgia',
              ),
            ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _tileUserNormal(AppUser u) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 19,
            backgroundImage:
                u.avatarPath != null
                    ? FileImage(File(u.avatarPath!))
                    : const AssetImage("assets/images/user.png")
                        as ImageProvider,
          ),
          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                u.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Georgia',
                ),
              ),
              Text(
                u.role,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontFamily: 'Georgia',
                ),
              ),
            ],
          ),

          const Spacer(),

          GestureDetector(
            onTap: () {
              editingUser = u;
              addNameC.text = u.username;
              addRoleC.text = u.role;
              addPassC.text = u.password;

              avatarPath = u.avatarPath;

              setState(() => mode = ProfileMode.editOtherUser);
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: maroon,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.settings, size: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tileUserSelect(AppUser u, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 19,
            backgroundImage:
                u.avatarPath != null
                    ? FileImage(File(u.avatarPath!))
                    : const AssetImage("assets/images/user.png")
                        as ImageProvider,
          ),
          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                u.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Georgia',
                ),
              ),
              Text(
                u.role,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontFamily: 'Georgia',
                ),
              ),
            ],
          ),

          const Spacer(),

          GestureDetector(
            onTap: () {
              setState(() {
                if (isSelected) {
                  selectedIds.remove(u.id);
                } else {
                  selectedIds.add(u.id);
                }
              });
            },
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isSelected ? Colors.red : Colors.white,
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(6),
              ),
              child:
                  isSelected
                      ? const Icon(Icons.check, color: Colors.white, size: 18)
                      : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'Georgia',
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _textFieldBox({
    required TextEditingController controller,
    bool obscure = false,
  }) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(
          fontFamily: 'Georgia',
          fontSize: 18,
          color: Colors.black,
        ),
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(color: Colors.black54, fontFamily: 'Georgia'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.white),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _clickText(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontFamily: 'Georgia',
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    switch (mode) {
      case ProfileMode.addUser:
        return _mainButton("Simpan", _saveNewUser);
      case ProfileMode.editOtherUser:
        return _mainButton("Simpan", _saveEditOtherUser);
      default:
        return _mainButton("Edit", _saveProfile);
    }
  }

  Widget _mainButton(String label, VoidCallback onTap) {
    return SizedBox(
      width: 160,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: maroon,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          elevation: 3,
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Georgia',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
