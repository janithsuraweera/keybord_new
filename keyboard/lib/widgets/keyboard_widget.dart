import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jboard/providers/keyboard_provider.dart';
import 'package:jboard/providers/theme_provider.dart';
import 'package:jboard/models/keyboard_layout.dart';
import 'package:jboard/widgets/key_tile.dart';

class KeyboardWidget extends StatelessWidget {
  const KeyboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<KeyboardProvider>(
      builder: (context, keyboardProvider, child) {
        final layout = _getCurrentLayout(keyboardProvider);
        
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(
              top: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1.0,
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Function bar with cursor controls
              _buildFunctionBar(context, keyboardProvider),
              
              // Main keyboard rows
              ...layout.rows.map((row) => _buildKeyboardRow(context, row, keyboardProvider)),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildFunctionBar(BuildContext context, KeyboardProvider provider) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          // Cursor controls
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_left),
            onPressed: () => provider.moveCursor(-1),
            tooltip: 'Move cursor left',
          ),
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_right),
            onPressed: () => provider.moveCursor(1),
            tooltip: 'Move cursor right',
          ),
          
          const Spacer(),
          
          // Language indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              provider.currentLanguage == KeyboardLanguage.english ? 'EN' : 'සිං',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          
          const SizedBox(width: 8),
          
          // Theme toggle
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark 
                  ? Icons.light_mode 
                  : Icons.dark_mode,
            ),
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
            tooltip: 'Toggle theme',
          ),
        ],
      ),
    );
  }
  
  Widget _buildKeyboardRow(BuildContext context, KeyboardRow row, KeyboardProvider provider) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: Row(
        children: row.keys.map((key) {
          return Expanded(
            flex: key.width?.round() ?? 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: KeyTile(
                keyboardKey: key,
                isShifted: provider.isShifted,
                isCapsLocked: provider.isCapsLocked,
                onTap: () => _handleKeyTap(context, key, provider),
                onLongPress: () => _handleKeyLongPress(context, key, provider),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
  
  KeyboardLayout _getCurrentLayout(KeyboardProvider provider) {
    if (provider.isSymbolMode) {
      return KeyboardLayout.getSymbolLayout();
    } else if (provider.currentLanguage == KeyboardLanguage.sinhala) {
      return KeyboardLayout.getSinhalaLayout();
    } else {
      return KeyboardLayout.getEnglishLayout();
    }
  }
  
  void _handleKeyTap(BuildContext context, KeyboardKey key, KeyboardProvider provider) {
    switch (key.type) {
      case KeyType.character:
        String text = key.primary;
        if (provider.isShifted || provider.isCapsLocked) {
          text = text.toUpperCase();
        }
        provider.insertText(text);
        if (provider.isShifted && !provider.isCapsLocked) {
          provider.toggleShift();
        }
        break;
        
      case KeyType.shift:
        provider.toggleShift();
        break;
        
      case KeyType.backspace:
        provider.backspace();
        break;
        
      case KeyType.space:
        provider.insertText(' ');
        break;
        
      case KeyType.enter:
        provider.insertText('\n');
        break;
        
      case KeyType.language:
        provider.switchLanguage();
        break;
        
      case KeyType.emoji:
        provider.toggleEmojiMode();
        break;
        
      case KeyType.voice:
        _handleVoiceInput(context, provider);
        break;
        
      case KeyType.cursor:
        // Handle cursor movement
        break;
        
      case KeyType.function:
        // Handle function keys
        break;
    }
  }
  
  void _handleKeyLongPress(BuildContext context, KeyboardKey key, KeyboardProvider provider) {
    if (key.longPress != null) {
      provider.insertText(key.longPress!);
    } else if (key.type == KeyType.shift) {
      provider.toggleCapsLock();
    } else if (key.type == KeyType.backspace) {
      // Long press backspace - delete word
      _deleteWord(provider);
    }
  }
  
  void _deleteWord(KeyboardProvider provider) {
    final text = provider.currentText;
    final position = provider.cursorPosition;
    
    if (position == 0) return;
    
    // Find the start of the current word
    int start = position - 1;
    while (start > 0 && text[start - 1] != ' ') {
      start--;
    }
    
    // Remove the word and update text
    provider.setCursorPosition(start);
    // TODO: Add a method to set text directly in KeyboardProvider
    // provider.setText(text.substring(0, start) + text.substring(position));
  }
  
  void _handleVoiceInput(BuildContext context, KeyboardProvider provider) {
    // Implement voice input functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Voice input coming soon!')),
    );
  }
} 