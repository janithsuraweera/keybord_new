import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jboard/providers/keyboard_provider.dart';
import 'package:jboard/widgets/keyboard_widget.dart';
import 'package:jboard/widgets/suggestion_bar.dart';
import 'package:jboard/widgets/emoji_panel.dart';

class KeyboardScreen extends StatelessWidget {
  const KeyboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Text display area
            Expanded(
              child: _buildTextDisplayArea(context),
            ),
            
            // Suggestions bar
            Consumer<KeyboardProvider>(
              builder: (context, keyboardProvider, child) {
                if (keyboardProvider.suggestions.isNotEmpty) {
                  return SuggestionBar(
                    suggestions: keyboardProvider.suggestions,
                    onSuggestionSelected: keyboardProvider.selectSuggestion,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            
            // Emoji panel (if active)
            Consumer<KeyboardProvider>(
              builder: (context, keyboardProvider, child) {
                if (keyboardProvider.isEmojiMode) {
                  return const EmojiPanel();
                }
                return const SizedBox.shrink();
              },
            ),
            
            // Main keyboard
            const KeyboardWidget(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTextDisplayArea(BuildContext context) {
    return Consumer<KeyboardProvider>(
      builder: (context, keyboardProvider, child) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Jboard',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: keyboardProvider.clearText,
                    tooltip: 'Clear text',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GestureDetector(
                  onTapUp: (details) {
                    // Calculate cursor position based on tap
                    final renderBox = context.findRenderObject() as RenderBox;
                    final localPosition = renderBox.globalToLocal(details.globalPosition);
                    // This is a simplified calculation - you'd need more complex logic
                    // for accurate cursor positioning
                    final estimatedPosition = (localPosition.dx / 10).round();
                    keyboardProvider.setCursorPosition(estimatedPosition);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: [
                          TextSpan(
                            text: keyboardProvider.currentText.substring(
                              0, 
                              keyboardProvider.cursorPosition,
                            ),
                          ),
                          WidgetSpan(
                            child: Container(
                              width: 2,
                              height: 20,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          TextSpan(
                            text: keyboardProvider.currentText.substring(
                              keyboardProvider.cursorPosition,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}