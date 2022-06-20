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
  late List<List<int>> canSetCoordinate;

  @override
  void initState() {
    super.initState();
    canSetCoordinate = _searchCoordinatesFromUpdatableCorrdinate(
        _collectCorrdinateCanSetStone(_collectCorrdinatePlacedStoneFromBoard(boardInfo), boardInfo), boardInfo, BlockStateKind.whiteStone);
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
                  boardInfo.boardState = player.updateRightUpper(i, j);
                  boardInfo.boardState = player.updateLeftLower(i, j);
                  boardInfo.boardState = player.updateLeftUpper(i, j);
                  boardInfo.boardState = player.updateRightLower(i, j);
                  isMovePlayer1 = false;
                } else {
                  boardInfo.boardState = player2.updateUnder(i, j);
                  boardInfo.boardState = player2.updateTop(i, j);
                  boardInfo.boardState = player2.updateLeft(i, j);
                  boardInfo.boardState = player2.updateRight(i, j);
                  boardInfo.boardState = player2.updateRightUpper(i, j);
                  boardInfo.boardState = player2.updateLeftLower(i, j);
                  boardInfo.boardState = player2.updateLeftUpper(i, j);
                  boardInfo.boardState = player2.updateRightLower(i, j);
                  isMovePlayer1 = true;
                }
              });
            }
          } else {
            return;
          }
        },
        child: Container(
          child: _builCanSetUnitBlock(i, j),
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

  Widget? _builCanSetUnitBlock(int columnNumber, int rowNumber) {
    for (var e in canSetCoordinate) {
      if (columnNumber == e[0] && rowNumber == e[1]) return _buildUnitBlocCanSet();
    }

    if (boardInfo.boardState[columnNumber][rowNumber] != BlockStateKind.notExistStone) {
      return _buildUnitBlockWithStone(boardInfo.boardState[columnNumber][rowNumber]);
    }
    return null;
  }

  Widget _buildUnitBlocCanSet() {
    return Container(
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber),
        borderRadius: BorderRadius.circular(40.0),
      ),
    );
  }

  double _decideOpacityValue(BlockStateKind blocState) {
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

///
///ここから下がまだ試作段階
///
///
List<List<int>> _collectCorrdinatePlacedStoneFromBoard(BoardInfo boardInfo) {
  /// i = column j = row
  List<List<int>> result = [];

  for (var i = 1; i <= 8; i++) {
    for (var j = 1; j <= 8; j++) {
      if (boardInfo.boardState[i][j] == BlockStateKind.blackStone || boardInfo.boardState[i][j] == BlockStateKind.whiteStone) result.add([i, j]);
    }
  }

  return result;
}

//石が存在する座標から石を置ける座標を判定する
List<List<int>> _collectCorrdinateCanSetStone(List<List<int>> list, BoardInfo boardInfo) {
  /// i = column j = row
  /// ８方向 上(0,-1) 右上(1)
  List<List<int>> result = [];

  for (var e in list) {
    if (boardInfo.boardState[e[0]][e[1] - 1] == BlockStateKind.notExistStone) result.add([e[0], e[1] - 1]); //石が置かれた座標の上の座標に石が存在していない場合
    if (boardInfo.boardState[e[0] + 1][e[1] - 1] == BlockStateKind.notExistStone) result.add([e[0] + 1, e[1] - 1]); //石が置かれた座標の右上の座標に石が存在していない場合
    if (boardInfo.boardState[e[0] + 1][e[1]] == BlockStateKind.notExistStone) result.add([e[0] + 1, e[1]]); //石が置かれた座標の右の座標に石が存在していない場合
    if (boardInfo.boardState[e[0] + 1][e[1] + 1] == BlockStateKind.notExistStone) result.add([e[0] + 1, e[1] + 1]); //石が置かれた座標の右下の座標に石が存在しない場合
    if (boardInfo.boardState[e[0]][e[1] + 1] == BlockStateKind.notExistStone) result.add([e[0], e[1] + 1]); //石が置かれた座標の下の座標に石が存在しない場合
    if (boardInfo.boardState[e[0] - 1][e[1] + 1] == BlockStateKind.notExistStone) result.add([e[0] - 1, e[1] + 1]); //石が置かれた座標の左下の座標に石が存在しない場合
    if (boardInfo.boardState[e[0] - 1][e[1]] == BlockStateKind.notExistStone) result.add([e[0] - 1, e[1]]); //石が置かれた座標の左の座標に石が存在しない場合
    if (boardInfo.boardState[e[0] - 1][e[1] - 1] == BlockStateKind.notExistStone) result.add([e[0] - 1, e[1] - 1]); //石が置かれた座標の左上の座標に石が存在しない場合
  }

  return result;
}

//石を置ける場所から更新できる座標だけを返す
List<List<int>> _searchCoordinatesFromUpdatableCorrdinate(List<List<int>> list, BoardInfo boardInfo, BlockStateKind kind) {
  List<List<int>> result = [];

  switch (kind) {
    case BlockStateKind.blackStone:
      result.addAll(_collectUpdatableCoordinate(list, kind, boardInfo));
      break;
    case BlockStateKind.whiteStone:
      result.addAll(_collectUpdatableCoordinate(list, kind, boardInfo));
      break;
    default:
      break;
  }

  // print(result);

  return result;
}

//更新できる座標を判定して集める(更新処理は行っていない)
List<List<int>> _collectUpdatableCoordinate(List<List<int>> list, BlockStateKind kind, BoardInfo boardInfo) {
  List<List<int>> result = [];
  bool canSetStone = false;

  for (var e in list) {
    // 上を更新できるか e[0]はColumn e[1]はRow
    for (var i = e[1] - 1; boardInfo.boardState[e[0]][i] != BlockStateKind.notExistSpace; i--) {
      if (boardInfo.boardState[e[0]][i] == BlockStateKind.notExistStone || boardInfo.boardState[e[0]][e[1] - 1] == kind) break;
      if (boardInfo.boardState[e[0]][i] == kind) canSetStone = true;
    }

    // 右上を更新できるか
    var rowNumberForRightUpper = e[1] - 1;
    for (var i = e[0] + 1; boardInfo.boardState[i][rowNumberForRightUpper] != BlockStateKind.notExistSpace; i++) {
      if (boardInfo.boardState[i][rowNumberForRightUpper] == BlockStateKind.notExistStone || boardInfo.boardState[e[0] + 1][e[1] - 1] == kind) break;
      if (boardInfo.boardState[i][rowNumberForRightUpper] == kind) canSetStone = true;

      --rowNumberForRightUpper;
    }

    // 右を更新できるか
    for (var i = e[0] + 1; boardInfo.boardState[i][e[1]] != BlockStateKind.notExistSpace; i++) {
      if (boardInfo.boardState[i][e[1]] == BlockStateKind.notExistStone || boardInfo.boardState[e[0] + 1][e[1]] == kind) break;
      if (boardInfo.boardState[i][e[1]] == kind) canSetStone = true;
    }

    // 右下を更新できるか
    var rowNumberForRightLower = e[1] + 1;
    for (var i = e[0] + 1; boardInfo.boardState[i][rowNumberForRightLower] != BlockStateKind.notExistSpace; i++) {
      if (boardInfo.boardState[i][rowNumberForRightLower] == BlockStateKind.notExistStone || boardInfo.boardState[e[0] + 1][e[1] + 1] == kind) break;
      if (boardInfo.boardState[i][rowNumberForRightLower] == kind) canSetStone = true;
      ++rowNumberForRightLower;
    }

    // 下を更新できるか
    for (var i = e[1] + 1; boardInfo.boardState[e[0]][i] != BlockStateKind.notExistSpace; i++) {
      if (boardInfo.boardState[e[0]][i] == BlockStateKind.notExistStone || boardInfo.boardState[e[0]][e[1] + 1] == kind) break;

      if (boardInfo.boardState[e[0]][i] == kind) canSetStone = true;
    }

    // 左下を更新できるか
    var rowNumberForLeftLower = e[1] + 1;
    for (var i = e[0] - 1; boardInfo.boardState[i][rowNumberForLeftLower] != BlockStateKind.notExistSpace; i--) {
      if (boardInfo.boardState[i][rowNumberForLeftLower] == BlockStateKind.notExistStone || boardInfo.boardState[e[0] - 1][e[1] + 1] == kind) break;
      if (boardInfo.boardState[i][rowNumberForLeftLower] == kind) canSetStone = true;
      ++rowNumberForLeftLower;
    }

    //　左を更新できるか
    for (var i = e[0] - 1; boardInfo.boardState[i][e[1]] != BlockStateKind.notExistSpace; i--) {
      if (boardInfo.boardState[i][e[1]] == BlockStateKind.notExistStone || boardInfo.boardState[e[0] - 1][e[1]] == kind) break;
      if (boardInfo.boardState[i][e[1]] == kind) canSetStone = true;
    }

    // 左上を更新できるか
    var rowNumberForLeftUpper = e[1] - 1;
    for (var i = e[0] - 1; boardInfo.boardState[i][rowNumberForLeftUpper] != BlockStateKind.notExistSpace; i--) {
      if (boardInfo.boardState[i][rowNumberForLeftUpper] == BlockStateKind.notExistStone || boardInfo.boardState[e[0] - 1][e[1] - 1] == kind) break;
      if (boardInfo.boardState[i][rowNumberForLeftUpper] == kind) canSetStone = true;
      --rowNumberForLeftUpper;
    }

    if (canSetStone) result.add(e);
    canSetStone = false;
  }

  return result;
}
