import 'package:flutter/material.dart';
import 'package:testoth/board/board_info.dart';

class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  BoardUpdate boardInfo = BoardUpdate.init();
  bool isWhite = false;
  late List<List<int>> canSetCoordinateList;

  @override
  void initState() {
    super.initState();
    canSetCoordinateList = _searchCoordinatesFromUpdatableCorrdinate(
        _collectCorrdinateCanSetStone(_collectCorrdinatePlacedStoneFromBoard(boardInfo), boardInfo), boardInfo, BlockStateKind.whiteStone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('オセロ Demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              canContinue(boardInfo)
                  ? isWhite
                      ? "黒の手番です"
                      : "白の手番です"
                  : judgeResult(boardInfo),
              style: const TextStyle(fontSize: 19)),
          Row(children: _buildBoardEntirety()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text("黒", style: TextStyle(fontSize: 19)),
                  SizedBox(child: _buildUnitBlockWithStone(BlockStateKind.blackStone), height: 40, width: 40),
                  Text("${countStone(boardInfo, BlockStateKind.blackStone)}個", style: const TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(width: 50),
              Column(
                children: [
                  const Text("白", style: TextStyle(fontSize: 19)),
                  SizedBox(child: _buildUnitBlockWithStone(BlockStateKind.whiteStone), height: 40, width: 40),
                  Text("${countStone(boardInfo, BlockStateKind.whiteStone)}個", style: const TextStyle(fontSize: 18)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Column> _buildBoardEntirety() {
    List<Column> columnList = [];

    for (int i = 0; i < boardInfo.boardState.length; i++) {
      List<Widget> blockList = [];
      for (int j = 0; j < boardInfo.boardState[i].length; j++) {
        blockList.add(_buildBlock(i, j, boardInfo));
      }
      Column unitColumn = Column(
        mainAxisSize: MainAxisSize.min,
        children: blockList,
      );
      columnList.add(unitColumn);
    }

    return columnList;
  }

  Widget _buildBlock(int i, int j, BoardUpdate boardInfo) {
    return Opacity(
      opacity: _decideOpacityValue(boardInfo.boardState[i][j]),
      child: Container(
        child: _builUnitBlock(i, j),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        height: 39,
        width: 39,
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

  Widget? _builUnitBlock(int columnNumber, int rowNumber) {
    for (final e in canSetCoordinateList) {
      if (columnNumber == e[0] && rowNumber == e[1]) return _buildUpdatableUnitBlock(columnNumber, rowNumber);
    }
    if (boardInfo.boardState[columnNumber][rowNumber] != BlockStateKind.notExistStone) {
      return _buildUnitBlockWithStone(boardInfo.boardState[columnNumber][rowNumber]);
    }
    return null;
  }

  Widget _buildUpdatableUnitBlock(int i, int j) {
    List<List<int>> updatableCordinates;
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isWhite) {
            boardInfo.boardState = boardInfo.updateUnder(i, j, BlockStateKind.blackStone);
            boardInfo.boardState = boardInfo.updateTop(i, j, BlockStateKind.blackStone);
            boardInfo.boardState = boardInfo.updateLeft(i, j, BlockStateKind.blackStone);
            boardInfo.boardState = boardInfo.updateRight(i, j, BlockStateKind.blackStone);
            boardInfo.boardState = boardInfo.updateRightUpper(i, j, BlockStateKind.blackStone);
            boardInfo.boardState = boardInfo.updateLeftLower(i, j, BlockStateKind.blackStone);
            boardInfo.boardState = boardInfo.updateLeftUpper(i, j, BlockStateKind.blackStone);
            boardInfo.boardState = boardInfo.updateRightLower(i, j, BlockStateKind.blackStone);
            updatableCordinates = _searchCoordinatesFromUpdatableCorrdinate(
                _collectCorrdinateCanSetStone(_collectCorrdinatePlacedStoneFromBoard(boardInfo), boardInfo), boardInfo, BlockStateKind.whiteStone);
            if (updatableCordinates.isEmpty) {
              canSetCoordinateList = _searchCoordinatesFromUpdatableCorrdinate(
                  _collectCorrdinateCanSetStone(_collectCorrdinatePlacedStoneFromBoard(boardInfo), boardInfo), boardInfo, BlockStateKind.blackStone);
            } else {
              canSetCoordinateList = updatableCordinates;
              isWhite = false;
            }
          } else {
            boardInfo.boardState = boardInfo.updateUnder(i, j, BlockStateKind.whiteStone);
            boardInfo.boardState = boardInfo.updateTop(i, j, BlockStateKind.whiteStone);
            boardInfo.boardState = boardInfo.updateLeft(i, j, BlockStateKind.whiteStone);
            boardInfo.boardState = boardInfo.updateRight(i, j, BlockStateKind.whiteStone);
            boardInfo.boardState = boardInfo.updateRightUpper(i, j, BlockStateKind.whiteStone);
            boardInfo.boardState = boardInfo.updateLeftLower(i, j, BlockStateKind.whiteStone);
            boardInfo.boardState = boardInfo.updateLeftUpper(i, j, BlockStateKind.whiteStone);
            boardInfo.boardState = boardInfo.updateRightLower(i, j, BlockStateKind.whiteStone);
            updatableCordinates = _searchCoordinatesFromUpdatableCorrdinate(
                _collectCorrdinateCanSetStone(_collectCorrdinatePlacedStoneFromBoard(boardInfo), boardInfo), boardInfo, BlockStateKind.blackStone);
            if (updatableCordinates.isEmpty) {
              canSetCoordinateList = _searchCoordinatesFromUpdatableCorrdinate(
                  _collectCorrdinateCanSetStone(_collectCorrdinatePlacedStoneFromBoard(boardInfo), boardInfo), boardInfo, BlockStateKind.whiteStone);
            } else {
              canSetCoordinateList = updatableCordinates;
              isWhite = true;
            }
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.amber),
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
    );
  }

  // 盤面外は透過する
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

  List<List<int>> _collectCorrdinatePlacedStoneFromBoard(BoardUpdate boardInfo) {
    List<List<int>> result = [];

    for (var i = 1; i <= 8; i++) {
      for (var j = 1; j <= 8; j++) {
        if (boardInfo.boardState[i][j] == BlockStateKind.blackStone || boardInfo.boardState[i][j] == BlockStateKind.whiteStone) result.add([i, j]);
      }
    }

    return result;
  }

//石を置ける座標を判定する
  List<List<int>> _collectCorrdinateCanSetStone(List<List<int>> list, BoardUpdate boardInfo) {
    List<List<int>> result = [];

    for (final e in list) {
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
  List<List<int>> _searchCoordinatesFromUpdatableCorrdinate(List<List<int>> list, BoardUpdate boardInfo, BlockStateKind kind) {
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

    return result;
  }

//更新できる座標を判定して集める(更新処理は行っていない)
  List<List<int>> _collectUpdatableCoordinate(List<List<int>> list, BlockStateKind kind, BoardUpdate boardInfo) {
    List<List<int>> result = [];
    bool canSetStone = false;

    for (final e in list) {
      // 上を更新できるか e[0]はColumn e[1]はRow
      for (var i = e[1] - 1; boardInfo.boardState[e[0]][i] != BlockStateKind.notExistSpace; i--) {
        if (boardInfo.boardState[e[0]][i] == BlockStateKind.notExistStone || boardInfo.boardState[e[0]][e[1] - 1] == kind) break;
        if (boardInfo.boardState[e[0]][i] == kind) canSetStone = true;
      }

      // 右上を更新できるか
      int rowNumberForRightUpper = e[1] - 1;
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
      int rowNumberForRightLower = e[1] + 1;
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
      int rowNumberForLeftLower = e[1] + 1;
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
      int rowNumberForLeftUpper = e[1] - 1;
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

  int countStone(BoardUpdate boardInfo, BlockStateKind kind) {
    int result = 0;
    for (var temp1 in boardInfo.boardState) {
      for (final temp2 in temp1) {
        if (temp2 == kind) ++result;
      }
    }

    return result;
  }

  bool canContinue(BoardUpdate boardInfo) {
    bool result = false;
    bool isExitWhiteStone = false;
    bool isExitBlackStone = false;

    for (final temp1 in boardInfo.boardState) {
      if (temp1.contains(BlockStateKind.notExistStone)) result = true;
      if (temp1.contains(BlockStateKind.blackStone)) isExitBlackStone = true;
      if (temp1.contains(BlockStateKind.whiteStone)) isExitWhiteStone = true;
    }
    // 盤面上に同色の石しかない場合はゲームは続行されない
    if (!isExitBlackStone && !isExitWhiteStone) result = false;
    return result;
  }

  String judgeResult(BoardUpdate boardInfo) {
    String result = "";
    final countBlackResult = countStone(boardInfo, BlockStateKind.blackStone);
    final countWhiteResult = countStone(boardInfo, BlockStateKind.whiteStone);

    if (countBlackResult > countWhiteResult) {
      result = "黒の勝ちです";
    } else if (countBlackResult < countWhiteResult) {
      result = "白の勝ちです";
    } else {
      result = "同点です";
    }
    return result;
  }
}
