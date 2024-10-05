import 'package:myskin_flutterbytes/src/cores/cores.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});
  static Future<void> show(BuildContext context) {
    return showAdaptiveDialog(
      context: context,
      barrierColor: Palette.transparent,
      barrierDismissible: false,
      builder: (context) => const LoadingWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: _SpinKitDoubleBounce(
        color: Palette.primaryColor,
      ),
    );
  }
}

class _SpinKitDoubleBounce extends StatefulWidget {
  const _SpinKitDoubleBounce({
    this.color,
    this.itemBuilder,
  }) : assert(
          !(itemBuilder is IndexedWidgetBuilder && color is Color) &&
              !(itemBuilder == null && color == null),
          'You should specify either a itemBuilder or a color',
        );

  final Color? color;
  final IndexedWidgetBuilder? itemBuilder;

  @override
  State<_SpinKitDoubleBounce> createState() => _SpinKitDoubleBounceState();
}

class _SpinKitDoubleBounceState extends State<_SpinKitDoubleBounce>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = (AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000)))
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      })
      ..repeat(reverse: true);
    _animation = Tween(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: List.generate(2, (i) {
          return Transform.scale(
            scale: (1.0 - i - _animation.value.abs()).abs(),
            child: SizedBox.fromSize(
              size: const Size.square(kfs50),
              child: _itemBuilder(i),
            ),
          );
        }),
      ),
    );
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color!.withOpacity(0.6),
          ),
        );
}
