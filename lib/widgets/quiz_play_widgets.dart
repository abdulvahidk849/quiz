import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;
  const OptionTile(
      {required this.optionSelected, required this.correctAnswer, required this.description, required this.option});
  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Container(
            height: 28,
            width: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                  color: widget.description  == widget.optionSelected ?
                  widget.optionSelected == widget.correctAnswer ? Colors.green.withOpacity(0.7) : Colors.green.withOpacity(0.7)
              : Colors.grey,
              width: 1.5)
            ),
            child: Text("${widget.option}", style:  TextStyle(
              color: widget.optionSelected == widget.description ? Colors.blue.withOpacity(0.7)
                  : Colors.black)
            ),
    ),
      const SizedBox(width: 8,),
      Text(widget.description,
        style: const TextStyle(fontSize: 17, color: Colors.black54),)
        ],
      ),
    );
  }
}

class NoOfQuestionTile extends StatefulWidget {
  final String text;
  final int number;

  const NoOfQuestionTile({required this.text, required this.number});

  @override
  _NoOfQuestionTileState createState() => _NoOfQuestionTileState();
}

class _NoOfQuestionTileState extends State<NoOfQuestionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14)),
                color: Colors.blue),
            child: Text(
              "${widget.number}",
              style: const TextStyle(color: Colors.black),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
                color: Colors.black54),
            child: Text(
              widget.text,
              style: const TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}

