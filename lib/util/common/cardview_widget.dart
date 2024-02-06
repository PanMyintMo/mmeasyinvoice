import 'package:flutter/material.dart';

Widget buildCardView(String image, String cardText, String profileText,
    String sign, VoidCallback onTap) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
    elevation: 5,
    shadowColor: Colors.blueAccent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.only(left: 12,top: 10,right: 12,bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: onTap, 
                child: Text(
                  cardText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decorationColor: Colors.black,
                    decoration: (cardText == "Total Revenue" ||
                            cardText == "Total Sale" ||
                            cardText == "Total Profit")
                        ? TextDecoration
                            .none // No underline for these titles
                        : TextDecoration.underline,
                    // Underline style for other titles
                    color: (cardText == "Total Revenue" ||
                            cardText == "Total Sale" ||
                            cardText == "Total Profit")
                        ? Colors.black
                        : Colors.blue, 
                  ),
                ),
              ),
              Text(
                profileText + sign,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.lightGreen.shade900,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Image.asset(image, width: 50,)
          ),
        ],
      ),
    ),
  );
}
