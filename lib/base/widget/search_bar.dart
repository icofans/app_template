import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  SearchBar({
    Key key,
    this.title,
    this.onCancel,
    this.onSearch,
    this.hint,
    this.backgroundColor,
    this.onChanged,
  }) : super(key: key);

  final String hint;

  final Color backgroundColor;
  // 标题
  final String title;

  // 点击取消回调
  final VoidCallback onCancel;

  // 点击键盘搜索回调
  final ValueChanged<String> onSearch;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return _AppBar(
      key: key,
      title: title,
      hint: hint,
      backgroundColor: backgroundColor,
      onSearch: onSearch,
      onCancel: onCancel,
      onChanged: onChanged,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBar extends StatefulWidget {
  _AppBar({
    Key key,
    this.title,
    this.onCancel,
    this.onSearch,
    this.onChanged,
    this.hint,
    this.backgroundColor,
  }) : super(key: key);

  // 标题 可选
  final String title;

  final String hint;

  final Color backgroundColor;

  // 点击取消回调 可选
  final VoidCallback onCancel;

  // 点击键盘搜索回调 可选
  final ValueChanged<String> onSearch;
  final ValueChanged<String> onChanged;

  @override
  _AppBarState createState() => _AppBarState();
}

class _AppBarState extends State<_AppBar> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool _showSearch = false; // 显示搜索框
  bool _showCancel = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _showCancel = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _focusNode?.dispose();
    super.dispose();
  }

  // 搜索面板 默认返回标题
  Widget _searchPanel() {
    String _title = widget.title ?? "";
    if (_title.isNotEmpty && !_showSearch) return Text(_title);
    ValueChanged<String> _onSearch = widget.onSearch ?? (val) {};
    ValueChanged<String> _onChanged = widget.onChanged ?? (val) {};
    return Container(
      height: kToolbarHeight - 18,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(2),
        // borderRadius: BorderRadius.circular((kToolbarHeight - 18) / 2),
      ),
      child: Stack(
        alignment: const Alignment(1.0, 1.0),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 16),
              Icon(Icons.search, size: 20, color: Color(0xFF999999)),
              SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: kToolbarHeight - 18,
                  child: TextField(
                    focusNode: _focusNode,
                    controller: _controller,
                    autofocus: _title.isNotEmpty,
                    style: TextStyle(fontSize: 15),
                    textInputAction: TextInputAction.search,
                    onChanged: (value) => _onChanged(value),
                    onEditingComplete: () => _onSearch(_controller.text),
                    decoration: InputDecoration(
                      hintText: widget.hint ?? "搜索",
                      hintStyle: TextStyle(color: Color(0xFF999999)),
                      // filled: true,
                      // fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          _showCancel
              ? InkWell(
                  onTap: () {
                    _controller.clear();
                    _focusNode.unfocus();
                    widget.onCancel?.call();
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 5),
                    height: kToolbarHeight - 18,
                    width: kToolbarHeight - 18,
                    child: Icon(
                      Icons.clear,
                      color: Colors.black54,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  // 搜索/取消按钮
  Widget action() {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    String _title = widget.title ?? "";
    VoidCallback _onCancel = widget.onCancel ?? () {};
    Widget _icon = _title.isNotEmpty && !_showSearch
        ? Icon(Icons.search)
        : Text(
            '取消',
            style: TextStyle(
                fontSize: 15,
                color: isDarkMode ? Color(0xFF999999) : Color(0xFF666666)),
          );
    return Container(
      height: kToolbarHeight - 18,
      margin: EdgeInsets.only(right: 10),
      child: IconButton(
        padding: EdgeInsets.all(0),
        icon: _icon,
        onPressed: () {
          setState(() {
            if (_title.isNotEmpty) _showSearch = !_showSearch;
          });
          if (!_showSearch) {
            _focusNode.unfocus();
            _controller.clear();
            _onCancel();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _searchPanel();
  }
}
