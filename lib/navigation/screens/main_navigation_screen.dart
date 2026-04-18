import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import the Bottom Nav
import '../widgets/bottom_nav.dart';

// Import all Feature Screens
import '../../home/screens/home_screen.dart';
import '../../ledger/screens/ledger_screen.dart';
import '../../profile/screens/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // The list of screens in the exact order of the bottom nav items
  final List<Widget> _screens = const [
    HomeScreen(),
    LedgerScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Access the global theme tokens
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        // Colors.transparent lets the scaffoldBackgroundColor bleed through naturally
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 24,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                // Dynamic theme primary container
                color: colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                'S', // Consider updating this to an icon or your official logo later
                style: GoogleFonts.manrope(
                  // High contrast text inside the primary container
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Welcome Back, Alpha coders',
              style: GoogleFonts.manrope(
                // Adapts automatically to Light/Dark backgrounds
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        // actions: [
        //   IconButton(
        //     // Uses onSurfaceVariant for secondary/tertiary UI elements
        //     icon: Icon(Icons.menu, color: colorScheme.onSurfaceVariant),
        //     onPressed: () {},
        //   ),
        //   const SizedBox(width: 16),
        // ],
      ),
      // IndexedStack preserves the state of the screens when you switch tabs
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: PremiumBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}