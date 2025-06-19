import 'dart:io';
import 'package:flutter/material.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/widget/location_selection_page.dart';
import '../Bloc/profile_state.dart';

class EditProfileForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController mobileController;
  final TextEditingController locationController;
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
    required this.locationController,
  });

  void onSelectLocation(String location) {
    locationController.text = location;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          _buildCoolSentence(), // Move this to the top for more emphasis
          const SizedBox(height: 30),
          _buildProfilePicture(),
          const SizedBox(height: 30),
          _buildTextField(
            controller: usernameController,
            label: "Username",
            icon: Icons.person,
            validator: (val) => val!.isEmpty ? "Enter a username" : null,
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
            validator: (val) => val!.isEmpty ? "Enter a mobile number" : null,
          ),
          const SizedBox(height: 16),
          _buildLocationField(context),
          const SizedBox(height: 30),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildProfilePicture() {
    final hasImage = imageFile != null;
    final hasNetworkImage =
        networkImageUrl != null && networkImageUrl!.isNotEmpty;

    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: Container(
              color: Colors.blueGrey.shade50,
              child: CircleAvatar(
                radius: 70,
                backgroundImage:
                    hasImage
                        ? FileImage(imageFile!)
                        : hasNetworkImage
                        ? NetworkImage(networkImageUrl!)
                        : const AssetImage(
                              'Assets/Auth_Icon/icon-5359554_1280.png',
                            )
                            as ImageProvider,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onPickImage,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blueAccent.shade100,
                child: const Icon(Icons.edit, size: 18, color: Colors.white),
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
      style: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
        labelText: label,
        labelStyle: TextStyle(color: Colors.blueAccent.shade700),
        prefixIcon: Icon(icon, color: Colors.blueAccent.shade700),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blueAccent.shade700, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blueAccent.shade700, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blueAccent.shade700, width: 1),
        ),
        filled: true,
        fillColor: Colors.blueGrey.shade50,
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton.icon(
      icon: const Icon(Icons.save),
      label: const Text("Save Changes"),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        backgroundColor: Colors.blueAccent.shade700,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onSubmit,
    );
  }

  Widget _buildLocationField(BuildContext context) {
    return TextFormField(
      controller: locationController,
      readOnly: true,
      style: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
        labelText: 'Location',
        labelStyle: TextStyle(color: Colors.blueAccent.shade700),
        prefixIcon: Icon(Icons.location_on, color: Colors.blueAccent.shade700),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blueAccent.shade700, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blueAccent.shade700, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blueAccent.shade700, width: 1),
        ),
        filled: true,
        fillColor: Colors.blueGrey.shade50,
      ),
      onTap: () async {
        // ignore: unused_local_variable
        String? selected = await Navigator.push<String>(
          context,
          MaterialPageRoute(builder: (context) => const LocationPickerPage()),
        ).then((address) {
          if (address != null) {
            onSelectLocation(address);
          }
        });
      },
    );
  }

  Widget _buildCoolSentence() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        'Look cool, feel cooler. Make your profile shine with style!',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
