import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jboard/providers/keyboard_provider.dart';
import 'package:jboard/models/emoji_category.dart';

class EmojiPanel extends StatelessWidget {
  const EmojiPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
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
        children: [
          // Category tabs
          _buildCategoryTabs(context),
          
          // Emoji grid
          Expanded(
            child: _buildEmojiGrid(context),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoryTabs(BuildContext context) {
    final categories = EmojiCategoryData.getAllCategories();
    
    return Consumer<KeyboardProvider>(
      builder: (context, keyboardProvider, child) {
        return Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1.0,
              ),
            ),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () => keyboardProvider.setEmojiCategory(category.category),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    category.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: keyboardProvider.selectedEmojiCategory == category.category
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
  
  Widget _buildEmojiGrid(BuildContext context) {
    final categories = EmojiCategoryData.getAllCategories();
    
    return Consumer<KeyboardProvider>(
      builder: (context, keyboardProvider, child) {
        final selectedCategory = categories.firstWhere(
          (category) => category.category == keyboardProvider.selectedEmojiCategory,
        );
        
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          padding: const EdgeInsets.all(8.0),
          itemCount: selectedCategory.emojis.length,
          itemBuilder: (context, index) {
            final emoji = selectedCategory.emojis[index];
            return GestureDetector(
              onTap: () => keyboardProvider.insertText(emoji.emoji),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                    width: 1.0,
                  ),
                ),
                child: Center(
                  child: Text(
                    emoji.emoji,
                    style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
} 