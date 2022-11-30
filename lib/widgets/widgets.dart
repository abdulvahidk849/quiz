import 'package:flutter/material.dart';


Widget appBar(BuildContext context) {
  return RichText(
    text: const TextSpan(
      style: TextStyle(fontSize: 21),
      children: <TextSpan>[
        TextSpan(
            text: 'MISSION',
            style:
            TextStyle(fontWeight: FontWeight.w500, color: Colors.black45)),
        TextSpan(
            text: 'KARIMUKKU',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xffFCCd00),)),
      ],
    ),
  );
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onTap;
  final AppBar appBar;

  const CustomAppBar({Key? key, required this.onTap,required this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(onTap: onTap,child: appBar);
  }

  // TODO: implement preferredSize
  @override
  Size get preferredSize =>  Size.fromHeight(kToolbarHeight);
}

Widget blueButton(BuildContext context, String label, buttonWidth) {
  return Container(
    
    padding: const EdgeInsets.symmetric(vertical: 18),
    decoration: BoxDecoration(
        color: Colors.blue, borderRadius: BorderRadius.circular(30)),
    //height: 50,
    alignment: Alignment.center,
    width: buttonWidth ?? MediaQuery.of(context).size.width - 48,
    child: Text(
      label,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}
