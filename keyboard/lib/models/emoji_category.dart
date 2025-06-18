enum EmojiCategory {
  recent,
  smileys,
  objects,
  animals,
  food,
  activities,
  travel,
  symbols,
}

class EmojiData {
  final String emoji;
  final String name;
  final EmojiCategory category;
  
  const EmojiData({
    required this.emoji,
    required this.name,
    required this.category,
  });
}

class EmojiCategoryData {
  final EmojiCategory category;
  final String name;
  final String icon;
  final List<EmojiData> emojis;
  
  const EmojiCategoryData({
    required this.category,
    required this.name,
    required this.icon,
    required this.emojis,
  });
  
  static List<EmojiCategoryData> getAllCategories() {
    return [
      EmojiCategoryData(
        category: EmojiCategory.recent,
        name: 'Recent',
        icon: '🕒',
        emojis: [
          const EmojiData(emoji: '😊', name: 'smile', category: EmojiCategory.smileys),
          const EmojiData(emoji: '❤️', name: 'heart', category: EmojiCategory.symbols),
        ],
      ),
      EmojiCategoryData(
        category: EmojiCategory.smileys,
        name: 'Smileys',
        icon: '😊',
        emojis: [
          const EmojiData(emoji: '😀', name: 'grinning', category: EmojiCategory.smileys),
          const EmojiData(emoji: '😃', name: 'grinning_face_with_big_eyes', category: EmojiCategory.smileys),
          const EmojiData(emoji: '😄', name: 'grinning_face_with_smiling_eyes', category: EmojiCategory.smileys),
          const EmojiData(emoji: '😁', name: 'beaming_face_with_smiling_eyes', category: EmojiCategory.smileys),
          const EmojiData(emoji: '😅', name: 'grinning_squinting_face', category: EmojiCategory.smileys),
          const EmojiData(emoji: '��', name: 'face_with_tears_of_joy', category: EmojiCategory.smileys),
          const EmojiData(emoji: '🤣', name: 'rolling_on_the_floor_laughing', category: EmojiCategory.smileys),
          const EmojiData(emoji: '😊', name: 'smiling_face_with_smiling_eyes', category: EmojiCategory.smileys),
          const EmojiData(emoji: '😇', name: 'smiling_face_with_halo', category: EmojiCategory.smileys),
          const EmojiData(emoji: '🙂', name: 'slightly_smiling_face', category: EmojiCategory.smileys),
        ],
      ),
      EmojiCategoryData(
        category: EmojiCategory.objects,
        name: 'Objects',
        icon: '📱',
        emojis: [
          const EmojiData(emoji: '📱', name: 'mobile_phone', category: EmojiCategory.objects),
          const EmojiData(emoji: '💻', name: 'laptop', category: EmojiCategory.objects),
          const EmojiData(emoji: '⌚', name: 'watch', category: EmojiCategory.objects),
          const EmojiData(emoji: '📷', name: 'camera', category: EmojiCategory.objects),
          const EmojiData(emoji: '🎧', name: 'headphones', category: EmojiCategory.objects),
        ],
      ),
      EmojiCategoryData(
        category: EmojiCategory.animals,
        name: 'Animals',
        icon: '🐶',
        emojis: [
          const EmojiData(emoji: '🐶', name: 'dog', category: EmojiCategory.animals),
          const EmojiData(emoji: '🐱', name: 'cat', category: EmojiCategory.animals),
          const EmojiData(emoji: '🐭', name: 'mouse', category: EmojiCategory.animals),
          const EmojiData(emoji: '🐹', name: 'hamster', category: EmojiCategory.animals),
          const EmojiData(emoji: '🐰', name: 'rabbit', category: EmojiCategory.animals),
        ],
      ),
      EmojiCategoryData(
        category: EmojiCategory.food,
        name: 'Food',
        icon: '🍕',
        emojis: [
          const EmojiData(emoji: '🍕', name: 'pizza', category: EmojiCategory.food),
          const EmojiData(emoji: '��', name: 'hamburger', category: EmojiCategory.food),
          const EmojiData(emoji: '🍟', name: 'french_fries', category: EmojiCategory.food),
          const EmojiData(emoji: '🌭', name: 'hot_dog', category: EmojiCategory.food),
          const EmojiData(emoji: '🍿', name: 'popcorn', category: EmojiCategory.food),
        ],
      ),
    ];
  }
} 