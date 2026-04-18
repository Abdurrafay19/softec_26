import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/database/hive_service.dart';
import '../../shared/widgets/editorial_text_field.dart';
import '../../shared/widgets/primary_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = HiveService.getUserName();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a name.'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    await HiveService.setUserName(name);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        title: Text(
          'Edit Profile',
          style: GoogleFonts.manrope(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              EditorialTextField(
                label: 'Full Name',
                hintText: 'e.g., Elena Richardson',
                controller: _nameController,
              ),
              const Spacer(),
              PrimaryButton(
                text: 'Save Changes',
                icon: Icons.check_circle_outline,
                onPressed: _saveProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
