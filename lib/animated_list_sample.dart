import 'package:flutter_web/material.dart';
import 'list_model.dart';
import 'cart_item.dart';

class AnimatedListSample extends StatefulWidget {
  _AnimatedListSampleState createState() => _AnimatedListSampleState();
}

class _AnimatedListSampleState extends State<AnimatedListSample> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  ListModel<int> _list;
  int _selectedItem;
  int _nextItem;

  void initState() {
    super.initState();
    _list = ListModel<int>(
      listKey: _listKey,
      removedItemBuilder: _buildRemovedItem,
      initialItems: <int>[0, 1, 2],
    );
    _nextItem = 3;
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      item: _list[index],
      animation: animation,
      selected: _selectedItem == _list[index],
      onTap: () {
        setState(() {
          _selectedItem = _selectedItem == _list[index] ? null : _list[index];
        });
      },
    );
  }

  Widget _buildRemovedItem(
      BuildContext context, int item, Animation<double> animation) {
    return CardItem(
      item: item,
      animation: animation,
      selected: false,
    );
  }

  void _insert() {
    final int index =
        _selectedItem == null ? _list.length : _list.indexOf(_selectedItem);
    _list.insert(index, _nextItem++);
  }

  void _remove() {
    if (_selectedItem != null) {
      _list.removeAt(_list.indexOf(_selectedItem));
      setState(() {
        _selectedItem = null;
      });
    }
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedList'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: _insert,
            tooltip: 'insert a new item',
          ),
          IconButton(
            icon: Icon(Icons.remove_circle),
            onPressed: _remove,
            tooltip: 'remove the selected item',
          ),
        ],
      ),
      body: AnimatedList(
        padding: EdgeInsets.all(16.0),
        key: _listKey,
        initialItemCount: _list.length,
        itemBuilder: _buildItem,
      ),
    );
  }
}
