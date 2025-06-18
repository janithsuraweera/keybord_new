import 'package:flutter/material.dart';
import 'package:jboard/models/keyboard_layout.dart';

class KeyTile extends StatefulWidget {
  final KeyboardKey keyboardKey;
  final bool isShifted;
  final bool isCapsLocked;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  
  const KeyTile({
    super.key,
    required this.keyboardKey,
    required this.isShifted,
    required this.isCapsLocked,
    required this.onTap,
    this.onLongPress,
  });

  @override
  State<KeyTile> createState() => _KeyTileState();
}

class _KeyTileState extends State<KeyTile> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _animationController.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _animationController.reverse();
        widget.onTap();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _animationController.reverse();
      },
      onLongPress: widget.onLongPress,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: _getKeyColor(context),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 1.0,
                ),
                boxShadow: _isPressed ? [] : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Center(
                child: _buildKeyContent(context),
              ),
            ),
          );
        },
      ),
    );
  }
  
  Color _getKeyColor(BuildContext context) {
    if (_isPressed) {
      return Theme.of(context).primaryColor.withValues(alpha: 0.2);
    }
    
    switch (widget.keyboardKey.type) {
      case KeyType.shift:
        return (widget.isShifted || widget.isCapsLocked) 
            ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
            : Theme.of(context).cardColor;
      case KeyType.space:
        return Theme.of(context).primaryColor.withValues(alpha: 0.05);
      case KeyType.enter:
        return Theme.of(context).primaryColor.withValues(alpha: 0.1);
      case KeyType.backspace:
        return Theme.of(context).colorScheme.error.withValues(alpha: 0.1);
      default:
        return Theme.of(context).cardColor;
    }
  }
  
  Widget _buildKeyContent(BuildContext context) {
    final key = widget.keyboardKey;
    switch (key.type) {
      case KeyType.shift:
        return Icon(
          widget.isCapsLocked ? Icons.keyboard_capslock : Icons.keyboard_arrow_up,
          color: (widget.isShifted || widget.isCapsLocked) 
              ? Theme.of(context).primaryColor 
              : Theme.of(context).iconTheme.color,
        );
        
      case KeyType.backspace:
        return Icon(
          Icons.backspace_outlined,
          color: Theme.of(context).colorScheme.error,
        );
        
      case KeyType.space:
        return Text(
          'space',
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        );
        
      case KeyType.enter:
        return Icon(
          Icons.keyboard_return,
          color: Theme.of(context).primaryColor,
        );
        
      case KeyType.language:
        return Text(
          widget.isShifted ? 'සිං' : 'EN',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        );
        
      case KeyType.emoji:
        return Icon(
          Icons.emoji_emotions,
          color: Theme.of(context).primaryColor,
        );
        
      case KeyType.voice:
        return Icon(
          Icons.mic,
          color: Theme.of(context).primaryColor,
        );
        
      case KeyType.cursor:
        return Icon(
          Icons.keyboard_arrow_left,
          color: Theme.of(context).iconTheme.color,
        );
        
      case KeyType.function:
        return Text(
          key.primary,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        );
        
      case KeyType.character:
        String displayText = key.primary;
        if (widget.isShifted || widget.isCapsLocked) {
          displayText = displayText.toUpperCase();
        }
        
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              displayText,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            if (key.secondary != null) ...[
              const SizedBox(height: 2),
              Text(
                key.secondary!,
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
            ],
          ],
        );
    }
  }
} 