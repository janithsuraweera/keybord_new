import 'package:flutter/material.dart';
import 'package:jboard/models/keyboard_layout.dart';
import 'package:jboard/models/emoji_category.dart';

class KeyboardProvider extends ChangeNotifier {
  // Keyboard state
  bool _isShifted = false;
  bool _isCapsLocked = false;
  bool _isSymbolMode = false;
  bool _isEmojiMode = false;
  KeyboardLanguage _currentLanguage = KeyboardLanguage.english;
  
  // Text input
  String _currentText = '';
  int _cursorPosition = 0;
  List<String> _suggestions = [];
  
  // Emoji state
  EmojiCategory _selectedEmojiCategory = EmojiCategory.recent;
  
  // Getters
  bool get isShifted => _isShifted;
  bool get isCapsLocked => _isCapsLocked;
  bool get isSymbolMode => _isSymbolMode;
  bool get isEmojiMode => _isEmojiMode;
  KeyboardLanguage get currentLanguage => _currentLanguage;
  String get currentText => _currentText;
  int get cursorPosition => _cursorPosition;
  List<String> get suggestions => _suggestions;
  EmojiCategory get selectedEmojiCategory => _selectedEmojiCategory;
  
  // Methods
  void toggleShift() {
    if (_isCapsLocked) {
      _isCapsLocked = false;
    } else if (_isShifted) {
      _isShifted = false;
    } else {
      _isShifted = true;
    }
    notifyListeners();
  }
  
  void toggleCapsLock() {
    _isCapsLocked = !_isCapsLocked;
    _isShifted = false;
    notifyListeners();
  }
  
  void toggleSymbolMode() {
    _isSymbolMode = !_isSymbolMode;
    _isEmojiMode = false;
    notifyListeners();
  }
  
  void toggleEmojiMode() {
    _isEmojiMode = !_isEmojiMode;
    _isSymbolMode = false;
    notifyListeners();
  }
  
  void switchLanguage() {
    _currentLanguage = _currentLanguage == KeyboardLanguage.english 
        ? KeyboardLanguage.sinhala 
        : KeyboardLanguage.english;
    notifyListeners();
  }
  
  void insertText(String text) {
    if (_cursorPosition == _currentText.length) {
      _currentText += text;
    } else {
      _currentText = _currentText.substring(0, _cursorPosition) + 
                     text + 
                     _currentText.substring(_cursorPosition);
    }
    _cursorPosition += text.length;
    _updateSuggestions();
    notifyListeners();
  }
  
  void backspace() {
    if (_currentText.isNotEmpty && _cursorPosition > 0) {
      _currentText = _currentText.substring(0, _cursorPosition - 1) + 
                     _currentText.substring(_cursorPosition);
      _cursorPosition--;
      _updateSuggestions();
      notifyListeners();
    }
  }
  
  void moveCursor(int direction) {
    final newPosition = _cursorPosition + direction;
    if (newPosition >= 0 && newPosition <= _currentText.length) {
      _cursorPosition = newPosition;
      notifyListeners();
    }
  }
  
  void setCursorPosition(int position) {
    if (position >= 0 && position <= _currentText.length) {
      _cursorPosition = position;
      notifyListeners();
    }
  }
  
  void clearText() {
    _currentText = '';
    _cursorPosition = 0;
    _suggestions.clear();
    notifyListeners();
  }
  
  void selectSuggestion(String suggestion) {
    // Replace the last word with suggestion
    final words = _currentText.split(' ');
    if (words.isNotEmpty) {
      words[words.length - 1] = suggestion;
      _currentText = words.join(' ');
      _cursorPosition = _currentText.length;
      _updateSuggestions();
      notifyListeners();
    }
  }
  
  void setEmojiCategory(EmojiCategory category) {
    _selectedEmojiCategory = category;
    notifyListeners();
  }
  
  void _updateSuggestions() {
    // Simple suggestion logic - can be enhanced with ML models
    if (_currentLanguage == KeyboardLanguage.sinhala) {
      _suggestions = _getSinhalaSuggestions();
    } else {
      _suggestions = _getEnglishSuggestions();
    }
  }
  
  List<String> _getSinhalaSuggestions() {
    // Placeholder for Sinhala suggestions
    return ['ආයුබෝවන්', 'ස්තූතියි', 'කරුණාකර'];
  }
  
  List<String> _getEnglishSuggestions() {
    // Placeholder for English suggestions
    return ['hello', 'thank you', 'please'];
  }
} 