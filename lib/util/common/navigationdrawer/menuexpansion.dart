
import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  final String text;
  final IconData icon;
  final List<MenuItem> items;
  final bool initiallyExpanded;
  final Function(bool expanded) onExpansionChanged;

  const CustomExpansionTile({
    required this.text,
    required this.icon,
    required this.items,
    required this.initiallyExpanded,
    required this.onExpansionChanged,
  });

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  @override
  Widget build(BuildContext context) {
    const color = Colors.black;
    const hoverColor = Colors.greenAccent;

    return ExpansionTile(
      initiallyExpanded: widget.initiallyExpanded,
      onExpansionChanged: widget.onExpansionChanged,
      title: Row(
        children: [
          Icon(
            widget.icon,
            color: color,
          ),
          const SizedBox(width: 32),
          Text(
            widget.text,
            style: const TextStyle(color: color),
          ),
        ],
      ),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
      children:
      widget.items.map((item) => buildMenuItem(item, hoverColor)).toList(),
    );
  }

  Widget buildMenuItem(MenuItem item, Color hoverColor) {
    const color = Colors.black;

    return ListTile(
      hoverColor: hoverColor,
      subtitle: GestureDetector(
        onTap: item.onClicked,
        child: Text(
          item.text,
          style: const TextStyle(color: color),
        ),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final VoidCallback onClicked;

  MenuItem({
    required this.text,
    required this.onClicked,
  });
}
