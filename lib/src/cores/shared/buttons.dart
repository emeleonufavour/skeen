import 'package:myskin_flutterbytes/src/cores/cores.dart';

class Button extends StatefulWidget {
  const Button({
    super.key,
    this.text,
    required this.onTap,
    this.color,
    this.textColor,
    this.textSize = kfsTiny,
    this.height,
    this.width,
    this.useHeightOrWidth = true,
    this.textFontWeight = w500,
    this.circular = true,
    this.active = true,
    this.child,
  })  : busy = false,
        iconData = null,
        borderColor = null,
        iconSize = null,
        iconColor = null;

  const Button.withBorderLine({
    super.key,
    this.text,
    this.onTap,
    this.color,
    this.borderColor,
    this.textColor,
    this.textSize = kfsTiny,
    this.height,
    this.width,
    this.useHeightOrWidth = true,
    this.textFontWeight = w500,
    this.circular = true,
    this.active = true,
    this.child,
  })  : busy = false,
        iconData = null,
        iconSize = null,
        iconColor = null;

  const Button.loading({
    super.key,
    this.onTap,
    this.color,
    this.height,
    this.useHeightOrWidth = true,
    this.width,
  })  : busy = true,
        iconData = null,
        text = null,
        textColor = null,
        textSize = kfsTiny,
        textFontWeight = null,
        iconSize = null,
        iconColor = null,
        borderColor = null,
        child = null,
        active = true,
        circular = false;

  const Button.smallSized({
    super.key,
    this.text,
    required this.onTap,
    this.color,
    this.textColor,
    this.useHeightOrWidth = true,
    this.textSize = kfsTiny,
    this.height,
    this.width,
    this.textFontWeight = w500,
    this.circular = true,
    this.active = true,
    this.child,
  })  : busy = false,
        iconData = null,
        iconSize = null,
        borderColor = null,
        iconColor = null;

  const Button.textOnly({
    super.key,
    required this.text,
    required this.onTap,
    this.textColor,
    this.textSize = kfsTiny,
    this.textFontWeight = w500,
    this.useHeightOrWidth = false,
  })  : active = false,
        borderColor = null,
        busy = false,
        circular = false,
        color = null,
        height = null,
        child = null,
        iconColor = null,
        iconData = null,
        iconSize = null,
        width = null;

  const Button.icon({
    super.key,
    required this.iconData,
    required this.height,
    required this.width,
    required this.onTap,
    this.useHeightOrWidth = true,
    this.color,
    this.iconColor,
    this.iconSize,
    this.circular = true,
    this.active = true,
  })  : busy = false,
        text = null,
        borderColor = null,
        textColor = null,
        textSize = kfsTiny,
        child = null,
        textFontWeight = null;

  final String? text;
  final IconData? iconData;
  final void Function()? onTap;
  final bool busy;
  final bool active;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? textSize;
  final double? height;
  final double? width;
  final FontWeight? textFontWeight;
  final Color? iconColor;
  final double? iconSize;
  final bool circular;
  final bool? useHeightOrWidth;
  final Widget? child;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    double defaultHeight = kfs56;

    return SizedBox(
      height: widget.useHeightOrWidth == false
          ? null
          : widget.height ?? defaultHeight,
      width: widget.width,
      child: TextButton(
        onPressed: widget.onTap,
        style: getButtonStyle(),
        child: widget.child ?? getButtonChild(),
      ),
    );
  }

  ButtonStyle getButtonStyle() {
    WidgetStateProperty<RoundedRectangleBorder> shape;

    if (widget.circular) {
      shape = WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kfsMedium.w),
          side: BorderSide(color: widget.borderColor ?? Palette.transparent),
        ),
      );
    } else {
      shape = WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kfsMedium.w),
          side: BorderSide(color: widget.borderColor ?? Palette.transparent),
        ),
      );
    }

    WidgetStateProperty<Color> backgroundColor;
    if (widget.busy) {
      backgroundColor = WidgetStateProperty.all(Palette.primaryColor);
    } else if (widget.active == false) {
      backgroundColor = WidgetStateProperty.all(Palette.primaryColor);
    } else {
      backgroundColor =
          WidgetStateProperty.all(widget.color ?? Palette.primaryColor);
    }

    return ButtonStyle(
      shape: shape,
      overlayColor:
          WidgetStateColor.resolveWith((states) => Palette.transparent),
      backgroundColor: backgroundColor,
    );
  }

  Widget getButtonChild() {
    if (widget.text == null) {
      if (widget.busy) {
        return const SizedBox(
          height: 21,
          width: 21,
          child: CircularProgressIndicator(),
        );
      } else {
        return Icon(
          widget.iconData,
          color: widget.iconColor ?? Palette.white,
          size: widget.iconSize ?? 20.0,
        );
      }
    } else {
      return Center(
        child: TextWidget(
          widget.text ?? 'no text',
          onTap: widget.onTap,
          textColor: widget.textColor ?? Palette.white,
          fontSize: widget.textSize,
          fontWeight: widget.textFontWeight,
        ),
      );
    }
  }
}
