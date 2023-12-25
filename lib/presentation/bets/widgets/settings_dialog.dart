import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:one_win/app_colors.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.darkGrey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Settings',
                  style: TextStyle(
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _imageFile == null
                ? Image.asset(
                    'as/placeholder_user.png',
                    width: 100,
                    height: 100,
                  )
                : ClipOval(
                    child: Image.file(
                      _imageFile!,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                final imagePicker = ImagePicker();
                final result =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                if (result == null) {
                  return;
                }
                setState(() {
                  _imageFile = File(result.path);
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.purple,
                      AppColors.primary,
                    ],
                  ),
                ),
                child: SvgPicture.asset(
                  'as/circle_plus.svg',
                  width: 24,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ],
            ),
            const Divider(
              thickness: 3,
              color: AppColors.grey,
              height: 32,
            ),
            const Row(
              children: [
                Expanded(
                  child: Text(
                    'Terms',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
