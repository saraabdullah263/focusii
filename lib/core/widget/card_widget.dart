import 'package:flutter/material.dart';
import 'package:focusi/features/children_test/children_test_pages/game_test/model_veiw/card_model.dart';



class CardWidget extends StatelessWidget {
  final CardModel card;
  final VoidCallback onTap;

  const CardWidget({super.key, required this.card, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: card.flipped || card.matched ? Colors.white : Colors.green,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: card.flipped || card.matched ? Colors.green : Colors.transparent),
        ),
        child: Center(
          child: Text(
            card.flipped || card.matched ? card.value : '?',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: card.flipped || card.matched ? Colors.green : Colors.white),
          ),
        ),
      ),
    );
  }
}
