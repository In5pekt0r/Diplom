import 'package:flutter/material.dart';

class BlueRoundedButton extends StatelessWidget {
  BlueRoundedButton({
    this.child,
    this.text,
    this.dense = false,
    this.onPress
  });
  final Widget? child;
  final String? text;
  final bool dense;
  final void Function()? onPress;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Container(
        padding: dense
         ? const EdgeInsets.symmetric(vertical: 6, horizontal: 12)
         : const EdgeInsets.symmetric(vertical: 10, horizontal: 44),
        child: text != null ? FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              text ?? '',
              maxLines: 1,
              style: TextStyle(
                fontSize: dense ? 16 : 18,
                fontWeight: FontWeight.bold,
              ),
            )
        ) : child,
      ),
      style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.all(
            onPress != null
            ? Colors.lightBlue.shade300
            : Colors.lightBlue.shade600
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )
        )
      ),
    );
  }
}
