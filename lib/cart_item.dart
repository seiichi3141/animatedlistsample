import 'package:flutter_web/material.dart';

class CardItem extends StatelessWidget {
  final int item;
  final Animation<double> animation;
  final bool selected;
  final VoidCallback onTap;

  CardItem({
    Key key,
    @required this.item,
    @required this.animation,
    this.selected: false,
    this.onTap,
  })  : assert(item != null && item >= 0),
        super(key: key);

  Widget build(context) {
    print('build $item');

    final textStyle = !selected
        ? Theme.of(context).textTheme.display1
        : Theme.of(context)
            .textTheme
            .display1
            .copyWith(color: Colors.lightGreenAccent[400]);

    return Padding(
      padding: EdgeInsets.all(2.0),
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: SizedBox(
            height: 128.0,
            child: Card(
              color: Colors.primaries[item % Colors.primaries.length],
              child: Center(
                child: Text('Item $item', style: textStyle),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
