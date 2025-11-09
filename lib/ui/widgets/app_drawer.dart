import 'package:flutter/material.dart';
import 'package:news/core/utils/app_routes.dart';
import 'package:news/ui/widgets/theme_dropdown.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Theme.of(context).colorScheme.primary,
            child: Center(
              child: Text(
                "News App",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  title: Text(
                    "Go to Home",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.home.routeName,
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.format_paint_outlined,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  title: Text(
                    "Theme",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const ThemeDropdown(),
                const SizedBox(height: 16),
                const Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
