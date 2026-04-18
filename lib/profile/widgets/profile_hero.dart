import 'package:flutter/material.dart';

class ProfileHeroSection extends StatelessWidget {
  const ProfileHeroSection({
    super.key,
    required this.displayName,
    this.onEdit,
  });

  final String displayName;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (onEdit != null)
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: onEdit,
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.primary,
              ),
              tooltip: 'Edit profile',
            ),
          ),
        
      
        Text(
          displayName,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800, 
            letterSpacing: -0.5, 
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),  
      ],
    );
  }
}