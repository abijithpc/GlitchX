import 'dart:io';
import 'package:flutter/material.dart';
import '../Bloc/profile_state.dart';

class EditProfileForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController mobileController;
  final File? imageFile;
  final String? networkImageUrl;
  final ProfileState state;
  final void Function() onPickImage;
  final void Function() onSubmit;

  const EditProfileForm({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.emailController,
    required this.mobileController,
    required this.imageFile,
    required this.networkImageUrl,
    required this.state,
    required this.onPickImage,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          _buildProfilePicture(),
          const SizedBox(height: 30),
          _buildTextField(
            controller: usernameController,
            label: "Username",
            icon: Icons.person,
            validator: (val) =>
                val!.isEmpty ? "Enter a username" : null,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: emailController,
            label: "Email",
            icon: Icons.email,
            readOnly: true,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: mobileController,
            label: "Mobile Number",
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            validator: (val) =>
                val!.isEmpty ? "Enter a mobile number" : null,
          ),
          const SizedBox(height: 30),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildProfilePicture() {
    final hasImage = imageFile != null;
    final hasNetworkImage = networkImageUrl != null && networkImageUrl!.isNotEmpty;

    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: hasImage
                ? FileImage(imageFile!)
                : hasNetworkImage
                    ? NetworkImage(networkImageUrl!)
                    : const AssetImage('Assets/Auth_Icon/icon-5359554_1280.png') as ImageProvider,
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: GestureDetector(
              onTap: onPickImage,
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                child: const Icon(Icons.edit, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton.icon(
      icon: const Icon(Icons.save),
      label: const Text("Save Changes"),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        textStyle: const TextStyle(fontSize: 16),
      ),
      onPressed: onSubmit,
    );
  }
}
