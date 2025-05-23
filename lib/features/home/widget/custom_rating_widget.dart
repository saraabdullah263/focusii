import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

class CustomRatingWidget extends StatefulWidget {
  final int starCount;
  final double initialRating;
  final String title;
  final Function(double)? onRatingChanged;

  const CustomRatingWidget({
    super.key,
    this.starCount = 5,
    this.initialRating = 0.0,
    this.onRatingChanged,
   required this.title
  });

  @override
  State<CustomRatingWidget> createState() => _CustomRatingWidgetState();
}

class _CustomRatingWidgetState extends State<CustomRatingWidget> {
  late double rating;

  @override
  void initState() {
    super.initState();
    rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: StarRating(
            size: 40.0,
            rating: rating,
            color: Colors.orange,
            borderColor: Colors.grey,
            allowHalfRating: true,
            starCount: widget.starCount,
            onRatingChanged: (newRating) {
              setState(() {
                rating = newRating;
              });
              if (widget.onRatingChanged != null) {
                widget.onRatingChanged!(newRating);
              }
            },
          ),
        ),
        const SizedBox(height: 12),
        const Divider(color: Colors.grey, thickness: 1,endIndent: 20,indent: 20,),
      ],
    );
  }
}


// Map<String, double> ratings = {
//   "content": 0.0,
//   "design": 0.0,
//   "usability": 0.0,
// };

// CustomRatingWidget(
//   initialRating: ratings["design"]!,
//   onRatingChanged: (value) {
//     setState(() {
//       ratings["design"] = value;
//     });
//   },
// );