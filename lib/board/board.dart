import 'package:flutter/material.dart';
import 'package:testoth/board/board_info.dart';

class Board extends StatefulWidget {
  const Board({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BoardInfo boardInfo = BoardInfo.init();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          children: _buildBoardEntirety(boardInfo.boardState),
        ),
      ),
    );
  }

  List<Column> _buildBoardEntirety(List<List<BlockStateKind>> boardState) {
    List<Column> columnList = [];

    for (int i = 0; i < boardState.length; i++) {
      List<Widget> blockList = [];
      for (int j = 0; j < boardState[i].length; j++) {
        blockList.add(_buildUnitBlock(i, j, boardState[i][j]));
      }
      Column unitColumn = Column(
        mainAxisSize: MainAxisSize.min,
        children: blockList,
      );
      columnList.add(unitColumn);
    }

    return columnList;
  }

  Widget _buildUnitBlock(int i, int j, BlockStateKind blockState) {
    return Opacity(
      opacity: _decideOpacityValue(blockState),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          child: blockState == BlockStateKind.notExistStone ? null : _buildUnitBlockWithStone(blockState),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          height: 39,
          width: 39,
        ),
      ),
    );
  }

  Widget _buildUnitBlockWithStone(BlockStateKind blockState) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(40.0),
        color: blockState == BlockStateKind.blackStone ? Colors.black : Colors.white,
      ),
    );
  }

  double _decideOpacityValue(BlockStateKind blocState) {
    //double opacityValue;
    switch (blocState) {
      case BlockStateKind.notExistStone:
      case BlockStateKind.blackStone:
      case BlockStateKind.whiteStone:
        return 1.0;
      default:
        return 0.0;
    }
  }
}
