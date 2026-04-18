import 'package:flutter/material.dart';

class ProfileHeroSection extends StatelessWidget {
  const ProfileHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1. The Avatar & Edit Button Stack
        Stack(
          children: [
            // Gradient "Border" Container
            Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(4), // Thickness of the gradient border
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Theme.of(context).colorScheme.primary, // #005bbf
                    Theme.of(context).colorScheme.secondaryContainer, // #69e8fe
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(24, 28, 32, 0.04), // Editorial shadow
                    offset: Offset(0, 4),
                    blurRadius: 24,
                  ),
                ],
              ),
              // Inner Image
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://i.pravatar.cc/150?img=47', // Mock Elena image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            
         
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  // Handle edit profile tap
                },
                customBorder: const CircleBorder(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(24, 28, 32, 0.08), 
                        offset: Offset(0, 2),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.edit,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary, // primary icon color
                  ),
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
      
        Text(
          "Elena Richardson",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800, 
            letterSpacing: -0.5, 
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        
        const SizedBox(height: 4),
        Text(
          "Founder & CEO, Lumen Creative Agency",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        
        const SizedBox(height: 16),
          Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer.withValues(alpha:0.2), // Light teal fill
            borderRadius: BorderRadius.circular(100), 
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.verified, 
                size: 16, 
                color: Theme.of(context).colorScheme.secondary, // Teal icon
              ),
              const SizedBox(width: 6),
              Text(
                "Premium SME Account",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.secondary, // Teal text
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}