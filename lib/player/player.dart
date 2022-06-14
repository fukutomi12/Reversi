import 'package:testoth/board/board_info.dart';
import 'package:testoth/player/player_base.dart';

class Player extends PlayerBase {
  Player({required this.blockStateKind, required this.boardInfo});

  final BlockStateKind blockStateKind;
  final BoardInfo boardInfo;

  @override
  List<List<BlockStateKind>> updateUnder(int columnNumber, int rowNumber) {
    super.updateUnder(columnNumber, rowNumber);
    var result = boardInfo.boardState;
    result[columnNumber][rowNumber] = blockStateKind;
    print(rowNumber);
    print(blockStateKind);

    for (var i = rowNumber + 1; i <= 8; i++) {
      // 更新方向。真下が同色ならすぐに抜けて、更新方向に抜けがある場合も更新せずに抜ける。
      if (boardInfo.boardState[columnNumber][i] == BlockStateKind.notExistStone || boardInfo.boardState[columnNumber][rowNumber + 1] == blockStateKind) break;
      if (result[columnNumber][i] == blockStateKind) {
        for (var j = rowNumber + 1; j < i; j++) {
          result[columnNumber][j] = blockStateKind;
        }
      }
    }

    return result;
  }

  @override
  List<List<BlockStateKind>> updateTop(int columnNumber, int rowNumber) {
    super.updateTop(columnNumber, rowNumber);
    var result = boardInfo.boardState;
    result[columnNumber][rowNumber] = blockStateKind;

    for (var i = rowNumber - 1; i >= 1; i--) {
      if (boardInfo.boardState[columnNumber][i] == BlockStateKind.notExistStone || boardInfo.boardState[columnNumber][rowNumber - 1] == blockStateKind) break;
      if (result[columnNumber][i] == blockStateKind) {
        for (var j = rowNumber - 1; j > i; j--) {
          result[columnNumber][j] = blockStateKind;
        }
      }
    }
    return result;
  }

  @override
  List<List<BlockStateKind>> updateLeft(int columnNumber, int rowNumber) {
    super.updateRight(columnNumber, rowNumber);
    var result = boardInfo.boardState;
    result[columnNumber][rowNumber] = blockStateKind;

    for (var i = columnNumber - 1; i >= 1; i--) {
      if (boardInfo.boardState[i][rowNumber] == BlockStateKind.notExistStone || boardInfo.boardState[columnNumber - 1][rowNumber] == blockStateKind) break;
      if (result[i][rowNumber] == blockStateKind) {
        for (var j = columnNumber - 1; j > i; j--) {
          result[j][rowNumber] = blockStateKind;
        }
      }
    }
    return result;
  }

  @override
  List<List<BlockStateKind>> updateRight(int columnNumber, int rowNumber) {
    super.updateRight(columnNumber, rowNumber);
    var result = boardInfo.boardState;
    result[columnNumber][rowNumber] = blockStateKind;

    for (var i = columnNumber + 1; i <= 8; i++) {
      if (boardInfo.boardState[i][rowNumber] == BlockStateKind.notExistStone || boardInfo.boardState[columnNumber + 1][rowNumber] == blockStateKind) break;
      if (result[i][rowNumber] == blockStateKind) {
        for (var j = columnNumber + 1; j < i; j++) {
          result[j][rowNumber] = blockStateKind;
        }
      }
    }
    return result;
  }

  @override
  List<List<BlockStateKind>> updateRightUpper(int columnNumber, int rowNumber) {
    super.updateRightUpper(columnNumber, rowNumber);
    var result = boardInfo.boardState;
    result[columnNumber][rowNumber] = blockStateKind;

    return result;
  }
}
