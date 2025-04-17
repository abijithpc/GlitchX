import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/widget/editprofileform.dart';
import 'package:image_picker/image_picker.dart';

import '../../Data/Models/user_model.dart';
import '../Bloc/profilebloc.dart';
import '../Bloc/profile_event.dart';
import '../Bloc/profile_state.dart';
import '../../../Auth/presentation/widget/screenbackground.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _mobileController;

  File? _imageFile;
  String? _networkImageUrl;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadUserProfile());
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _mobileController = TextEditingController();
    
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
  }

  void _submit(ProfileLoaded state) {
    if (_formKey.currentState!.validate()) {
      final updatedUser = UserModel(
        id: state.user.id,
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        mobile: _mobileController.text.trim(),
      );
      context.read<ProfileBloc>().add(SubmitProfileUpdateEvent(updatedUser));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is ProfileLoaded) {
            _usernameController.text = state.user.username;
            _emailController.text = state.user.email;
            _mobileController.text = state.user.mobile;
            _networkImageUrl = state.user.profilePictureUrl;
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ScreenBackGround(
            screenHeight: screen.height,
            screenWidth: screen.width,
            widget: Padding(
              padding: const EdgeInsets.all(16),
              child: EditProfileForm(
                formKey: _formKey,
                usernameController: _usernameController,
                emailController: _emailController,
                mobileController: _mobileController,
                imageFile: _imageFile,
                networkImageUrl: _networkImageUrl,
                state: state,
                onPickImage: _pickImage,
                onSubmit: () {
                  if (state is ProfileLoaded) _submit(state);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
