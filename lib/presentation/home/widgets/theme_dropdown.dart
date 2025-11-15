import 'package:flutter/material.dart';
import 'package:news/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeDropdown extends StatelessWidget {
  const ThemeDropdown({super.key});

  String _getThemeDisplayName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();
    final currentThemeMode = context.watch<ThemeProvider>().themeMode;
    final List<ThemeMode> supportedThemes = [ThemeMode.light, ThemeMode.dark];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButton<ThemeMode>(
        borderRadius: BorderRadius.circular(16),
        value: currentThemeMode,
        onChanged: (ThemeMode? newThemeMode) {
          if (newThemeMode != null) {
            themeProvider.setThemeMode(newThemeMode);
          }
        },
        isExpanded: true,
        selectedItemBuilder: (BuildContext context) {
          return supportedThemes.map<Widget>((ThemeMode mode) {
            return Text(
              _getThemeDisplayName(mode),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            );
          }).toList();
        },
        items: supportedThemes.map<DropdownMenuItem<ThemeMode>>((
          ThemeMode mode,
        ) {
          return DropdownMenuItem<ThemeMode>(
            value: mode,
            child: Text(
              _getThemeDisplayName(mode),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          );
        }).toList(),
        icon: Icon(
          Icons.arrow_drop_down,
          color: Theme.of(context).colorScheme.onSurface,
          size: 32,
        ),
      ),
    );
  }
}
