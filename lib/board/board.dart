import 'package:flutter/material.dart';
import 'package:testoth/board/board_info.dart';
import 'package:testoth/player/player.dart';

class Board extends StatefulWidget {
  const Board({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  BoardInfo boardInfo = BoardInfo.init();
  bool isMovePlayer1 = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Player player1 = Player(boardInfo: boardInfo, blockStateKind: BlockStateKind.blackStone);
    Player player2 = Player(boardInfo: boardInfo, blockStateKind: BlockStateKind.whiteStone);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          children: _buildBoardEntirety(player1, player2),
        ),
      ),
    );
  }

  List<Column> _buildBoardEntirety(Player player, Player player2) {
    List<Column> columnList = [];

    for (int i = 0; i < boardInfo.boardState.length; i++) {
      List<Widget> blockList = [];
      for (int j = 0; j < boardInfo.boardState[i].length; j++) {
        blockList.add(_buildUnitBlock(i, j, boardInfo, player, player2));
      }
      Column unitColumn = Column(
        mainAxisSize: MainAxisSize.min,
        children: blockList,
      );
      columnList.add(unitColumn);
    }

    return columnList;
  }

  Widget _buildUnitBlock(int i, int j, BoardInfo boardInfo, Player player, Player player2) {
    return Opacity(
      opacity: _decideOpacityValue(boardInfo.boardState[i][j]),
      child: GestureDetector(
        onTap: () {
          if (boardInfo.boardState[i][j] == BlockStateKind.notExistStone) {
            if (_canSetStone(i, j, boardInfo)) {
              setState(() {
                if (isMovePlayer1) {
                  boardInfo.boardState = player.updateUnder(i, j);
                  boardInfo.boardState = player.updateTop(i, j);
                  boardInfo.boardState = player.updateLeft(i, j);
                  boardInfo.boardState = player.updateRight(i, j);
                  isMovePlayer1 = false;
                } else {
                  boardInfo.boardState = player2.updateUnder(i, j);
                  boardInfo.boardState = player2.updateTop(i, j);
                  boardInfo.boardState = player2.updateLeft(i, j);
                  boardInfo.boardState = player2.updateRight(i, j);
                  isMovePlayer1 = true;
                }
              });
            }
          } else {
            return;
          }
        },
        child: Container(
          child: boardInfo.boardState[i][j] == BlockStateKind.notExistStone ? null : _buildUnitBlockWithStone(boardInfo.boardState[i][j]),
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

bool _canSetStone(int i, int j, BoardInfo boardInfo) {
  if ((boardInfo.boardState[i][j - 1] == BlockStateKind.blackStone) || (boardInfo.boardState[i][j - 1] == BlockStateKind.whiteStone)) return true;
  if ((boardInfo.boardState[i][j + 1] == BlockStateKind.blackStone) || (boardInfo.boardState[i][j + 1] == BlockStateKind.whiteStone)) return true;
  if ((boardInfo.boardState[i - 1][j] == BlockStateKind.blackStone) || (boardInfo.boardState[i - 1][j] == BlockStateKind.whiteStone)) return true;
  if ((boardInfo.boardState[i + 1][j] == BlockStateKind.blackStone) || (boardInfo.boardState[i + 1][j] == BlockStateKind.whiteStone)) return true;
  if ((boardInfo.boardState[i - 1][j - 1] == BlockStateKind.blackStone) || (boardInfo.boardState[i - 1][j - 1] == BlockStateKind.whiteStone)) return true;
  if ((boardInfo.boardState[i - 1][j + 1] == BlockStateKind.blackStone) || (boardInfo.boardState[i - 1][j + 1] == BlockStateKind.whiteStone)) return true;
  if ((boardInfo.boardState[i + 1][j - 1] == BlockStateKind.blackStone) || (boardInfo.boardState[i + 1][j - 1] == BlockStateKind.whiteStone)) return true;
  if ((boardInfo.boardState[i + 1][j + 1] == BlockStateKind.blackStone) || (boardInfo.boardState[i + 1][j + 1] == BlockStateKind.whiteStone)) return true;

  return false;
}
