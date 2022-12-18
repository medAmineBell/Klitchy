import 'package:flutter/material.dart';

class ReviewItem extends StatelessWidget {
  final String name;
  final String review;
  const ReviewItem({Key? key, required this.name, required this.review})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, right: 10, left: 10),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          tileColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          leading: Icon(
            Icons.person_outline,
            size: 40,
            color: Theme.of(context).primaryColor,
          ),
          subtitle: Text(
            review,
            style: TextStyle(
              // fontWeight: FontWeight.w600,
              color: Colors.grey[700], fontSize: 16,
            ),
          ),
          title: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          trailing: Container(
            width: 75,
            child: Row(
              children: [
                Icon(Icons.star, size: 15, color: Colors.orange),
                Icon(Icons.star, size: 15, color: Colors.orange),
                Icon(Icons.star, size: 15, color: Colors.orange),
                Icon(Icons.star_border, size: 15, color: Colors.orange),
                Icon(Icons.star_border, size: 15, color: Colors.orange),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
