enum KeyboardLanguage { english, sinhala }

class KeyboardKey {
  final String primary;
  final String? secondary;
  final String? longPress;
  final KeyType type;
  final double? width;
  
  const KeyboardKey({
    required this.primary,
    this.secondary,
    this.longPress,
    this.type = KeyType.character,
    this.width,
  });
}

enum KeyType {
  character,
  function,
  space,
  enter,
  backspace,
  shift,
  language,
  emoji,
  voice,
  cursor,
}

class KeyboardRow {
  final List<KeyboardKey> keys;
  
  const KeyboardRow(this.keys);
}

class KeyboardLayout {
  final List<KeyboardRow> rows;
  
  const KeyboardLayout(this.rows);
  
  static KeyboardLayout getEnglishLayout() {
    return const KeyboardLayout([
      KeyboardRow([
        KeyboardKey(primary: 'q'),
        KeyboardKey(primary: 'w'),
        KeyboardKey(primary: 'e'),
        KeyboardKey(primary: 'r'),
        KeyboardKey(primary: 't'),
        KeyboardKey(primary: 'y'),
        KeyboardKey(primary: 'u'),
        KeyboardKey(primary: 'i'),
        KeyboardKey(primary: 'o'),
        KeyboardKey(primary: 'p'),
      ]),
      KeyboardRow([
        KeyboardKey(primary: 'a'),
        KeyboardKey(primary: 's'),
        KeyboardKey(primary: 'd'),
        KeyboardKey(primary: 'f'),
        KeyboardKey(primary: 'g'),
        KeyboardKey(primary: 'h'),
        KeyboardKey(primary: 'j'),
        KeyboardKey(primary: 'k'),
        KeyboardKey(primary: 'l'),
      ]),
      KeyboardRow([
        KeyboardKey(primary: '', type: KeyType.shift),
        KeyboardKey(primary: 'z'),
        KeyboardKey(primary: 'x'),
        KeyboardKey(primary: 'c'),
        KeyboardKey(primary: 'v'),
        KeyboardKey(primary: 'b'),
        KeyboardKey(primary: 'n'),
        KeyboardKey(primary: 'm'),
        KeyboardKey(primary: '', type: KeyType.backspace),
      ]),
      KeyboardRow([
        KeyboardKey(primary: '', type: KeyType.language),
        KeyboardKey(primary: '', type: KeyType.emoji),
        KeyboardKey(primary: '', type: KeyType.voice),
        KeyboardKey(primary: '', type: KeyType.space, width: 3.0),
        KeyboardKey(primary: '', type: KeyType.enter),
      ]),
    ]);
  }
  
  static KeyboardLayout getSinhalaLayout() {
    return const KeyboardLayout([
      KeyboardRow([
        KeyboardKey(primary: 'අ'),
        KeyboardKey(primary: 'ආ'),
        KeyboardKey(primary: 'ඇ'),
        KeyboardKey(primary: 'ඈ'),
        KeyboardKey(primary: 'ඉ'),
        KeyboardKey(primary: 'ඊ'),
        KeyboardKey(primary: 'උ'),
        KeyboardKey(primary: 'ඌ'),
        KeyboardKey(primary: 'ඍ'),
        KeyboardKey(primary: 'ඎ'),
      ]),
      KeyboardRow([
        KeyboardKey(primary: 'ඏ'),
        KeyboardKey(primary: 'ඐ'),
        KeyboardKey(primary: 'එ'),
        KeyboardKey(primary: 'ඒ'),
        KeyboardKey(primary: 'ඓ'),
        KeyboardKey(primary: 'ඔ'),
        KeyboardKey(primary: 'ඕ'),
        KeyboardKey(primary: 'ඖ'),
        KeyboardKey(primary: 'ක'),
      ]),
      KeyboardRow([
        KeyboardKey(primary: '', type: KeyType.shift),
        KeyboardKey(primary: 'ඛ'),
        KeyboardKey(primary: 'ග'),
        KeyboardKey(primary: 'ඝ'),
        KeyboardKey(primary: 'ඞ'),
        KeyboardKey(primary: 'ඟ'),
        KeyboardKey(primary: 'ච'),
        KeyboardKey(primary: 'ඡ'),
        KeyboardKey(primary: '', type: KeyType.backspace),
      ]),
      KeyboardRow([
        KeyboardKey(primary: '', type: KeyType.language),
        KeyboardKey(primary: '', type: KeyType.emoji),
        KeyboardKey(primary: '', type: KeyType.voice),
        KeyboardKey(primary: '', type: KeyType.space, width: 3.0),
        KeyboardKey(primary: '', type: KeyType.enter),
      ]),
    ]);
  }
  
  static KeyboardLayout getSymbolLayout() {
    return const KeyboardLayout([
      KeyboardRow([
        KeyboardKey(primary: '1'),
        KeyboardKey(primary: '2'),
        KeyboardKey(primary: '3'),
        KeyboardKey(primary: '4'),
        KeyboardKey(primary: '5'),
        KeyboardKey(primary: '6'),
        KeyboardKey(primary: '7'),
        KeyboardKey(primary: '8'),
        KeyboardKey(primary: '9'),
        KeyboardKey(primary: '0'),
      ]),
      KeyboardRow([
        KeyboardKey(primary: '!'),
        KeyboardKey(primary: '@'),
        KeyboardKey(primary: '#'),
        KeyboardKey(primary: '\$'),
        KeyboardKey(primary: '%'),
        KeyboardKey(primary: '^'),
        KeyboardKey(primary: '&'),
        KeyboardKey(primary: '*'),
        KeyboardKey(primary: '('),
      ]),
      KeyboardRow([
        KeyboardKey(primary: '', type: KeyType.shift),
        KeyboardKey(primary: ')'),
        KeyboardKey(primary: '-'),
        KeyboardKey(primary: '_'),
        KeyboardKey(primary: '='),
        KeyboardKey(primary: '+'),
        KeyboardKey(primary: '['),
        KeyboardKey(primary: ']'),
        KeyboardKey(primary: '', type: KeyType.backspace),
      ]),
      KeyboardRow([
        KeyboardKey(primary: '', type: KeyType.language),
        KeyboardKey(primary: '', type: KeyType.emoji),
        KeyboardKey(primary: '', type: KeyType.voice),
        KeyboardKey(primary: '', type: KeyType.space, width: 3.0),
        KeyboardKey(primary: '', type: KeyType.enter),
      ]),
    ]);
  }
} 