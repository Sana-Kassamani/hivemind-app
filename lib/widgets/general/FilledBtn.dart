import 'package:flutter/material.dart';

class FilledBtn extends StatelessWidget {
  const FilledBtn(
      {super.key, this.icon, required this.text, required this.onPress});
  final icon;
  final text;
  final onPress;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      child: FilledButton.icon(
        onPressed: onPress,
        icon: icon,
        label: Text(text),
        style: ButtonStyle(
            padding: WidgetStatePropertyAll(
                EdgeInsets.only(left: 54, top: 10, right: 54, bottom: 10))),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class CustomFilledButton extends StatelessWidget {
//   final String label;
//   final IconData? icon;
//   final VoidCallback onPressed;
//   final Color? backgroundColor;
//   final Color? textColor;

//   const CustomFilledButton({
//     super.key,
//     required this.label,
//     required this.onPressed,
//     this.icon,
//     this.backgroundColor,
//     this.textColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return FilledButton.icon(
//       onPressed: onPressed,
//       icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
//       label: Text(
//         label,
//         style: TextStyle(
//           color: textColor ?? Theme.of(context).colorScheme.onPrimary,
//         ),
//       ),
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(
//           backgroundColor ?? Theme.of(context).colorScheme.primary,
//         ),
//         padding: MaterialStateProperty.all(
//           const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
//         ),
//       ),
//     );
//   }
// }
