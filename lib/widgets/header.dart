import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class TodoHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const TodoHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: colors.primary,
              fontSize: 24,
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              color: colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
