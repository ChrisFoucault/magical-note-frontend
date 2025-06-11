import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: NoteEditorPage()));
}

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({Key? key}) : super(key: key);

  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _showToolbar = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _showToolbar = _focusNode.hasFocus;
      });
    });
  }

  void _insertText(String text) {
    final selection = _controller.selection;
    final newText = _controller.text.replaceRange(
      selection.start,
      selection.end,
      text,
    );
    _controller.text = newText;
    _controller.selection = TextSelection.collapsed(offset: selection.start + text.length);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      appBar: AppBar(title: const Text("笔记编辑器")),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: _showToolbar ? 50 : 0),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(16),
                hintText: '输入你的笔记...',
                border: InputBorder.none,
              ),
            ),
          ),
          if (_showToolbar)
            Positioned(
              bottom: bottomInset,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                color: Colors.grey[200],
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.format_bold),
                      onPressed: () => _insertText("**粗体**"),
                    ),
                    IconButton(
                      icon: const Icon(Icons.format_italic),
                      onPressed: () => _insertText("_斜体_"),
                    ),
                    IconButton(
                      icon: const Icon(Icons.image),
                      onPressed: () => _insertText("![图片](url)"),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
