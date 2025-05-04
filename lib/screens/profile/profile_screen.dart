import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:brain_buddy/widgets/main_screen_com.dart';
import 'package:brain_buddy/config/app_color.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;
  final picker = ImagePicker();
  bool _isEditing = false;
  bool _hasChanges = false;

  final TextEditingController _firstNameController = TextEditingController(text: "John");
  final TextEditingController _lastNameController = TextEditingController(text: "Doe");
  final TextEditingController _emailController = TextEditingController(text: "john.doe@example.com");
  final TextEditingController _passwordController = TextEditingController(text: "password123");
  final TextEditingController _phoneController = TextEditingController(text: "0754167168");
  final TextEditingController _ageController = TextEditingController(text: "25");

  Map<String, String> _initialValues = {};

  @override
  void initState() {
    super.initState();
    _saveInitialValues();
  }

  void _saveInitialValues() {
    _initialValues = {
      "firstName": _firstNameController.text,
      "lastName": _lastNameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
      "phone": _phoneController.text,
      "age": _ageController.text,
    };
  }

  bool _checkIfChanged() {
    return _firstNameController.text != _initialValues["firstName"] ||
        _lastNameController.text != _initialValues["lastName"] ||
        _emailController.text != _initialValues["email"] ||
        _passwordController.text != _initialValues["password"] ||
        _phoneController.text != _initialValues["phone"] ||
        _ageController.text != _initialValues["age"] ||
        _profileImage != null;
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
        _hasChanges = true;
      });
    }
  }

  void _onSave() {
    if (_checkIfChanged()) {
      setState(() {
        _saveInitialValues();
        _hasChanges = false;
        _isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile saved")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenCom(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              GestureDetector(
                onTap: _isEditing ? _pickImage : null,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : const AssetImage('assets/images/deafult profile.jpg') as ImageProvider,
                  child: _isEditing
                      ? const Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.edit, size: 20),
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField("First Name", _firstNameController),
              _buildTextField("Last Name", _lastNameController),
              _buildTextField("Email", _emailController),
              _buildTextField("Password", _passwordController, isObscure: true),
              _buildTextField("Phone", _phoneController, keyboardType: TextInputType.phone),
              _buildTextField("Age", _ageController, keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _isEditing && _checkIfChanged() ? _onSave : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
                      foregroundColor: AppColors.textPrimary,
                      disabledForegroundColor: Colors.pink[300],
                    ),
                    child: const Text("Save", style: TextStyle(color: AppColors.textPrimary)),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
                      foregroundColor: AppColors.textPrimary,
                      disabledForegroundColor: Colors.pink[300],
                    ),
                    onPressed: () {
                      setState(() {
                        _isEditing = !_isEditing;
                        if (!_isEditing) {
                          _firstNameController.text = _initialValues["firstName"]!;
                          _lastNameController.text = _initialValues["lastName"]!;
                          _emailController.text = _initialValues["email"]!;
                          _passwordController.text = _initialValues["password"]!;
                          _phoneController.text = _initialValues["phone"]!;
                          _ageController.text = _initialValues["age"]!;
                          _profileImage = null;
                          _hasChanges = false;
                        }
                      });
                    },
                    child: Text(_isEditing ? "Cancel" : "Edit Profile",style: const TextStyle(color: AppColors.textPrimary)),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTextField(
  String label,
  TextEditingController controller, {
  bool isObscure = false,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: TextField(
      controller: controller,
      obscureText: isObscure,
      enabled: _isEditing,
      keyboardType: keyboardType,
      cursorColor: Theme.of(context).primaryColor,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: AppColors.primary,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 15, 15, 15),
          fontWeight: FontWeight.w500,
        ),
        floatingLabelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
        ),
      ),
      onChanged: (_) {
        setState(() {
          _hasChanges = _checkIfChanged();
        });
      },
    ),
  );
}


}
