import 'package:testoth/board/board_info.dart';
import 'package:testoth/player/player_base.dart';

class Player extends PlayerBase {
  Player({required this.blockStateKind, required this.boardInfo});

  final BlockStateKind blockStateKind;
  final BoardInfo boardInfo;

  @override
  List<List<BlockStateKind>> updateUnder(int rowNumber, int columnNumber) {
    super.updateUnder(rowNumber, columnNumber);
    var result = boardInfo.boardState;
    result[rowNumber][columnNumber] = blockStateKind;

    for (var i = columnNumber + 1; i <= 8; i++) {
      if (boardInfo.boardState[rowNumber][i] == BlockStateKind.notExistStone || boardInfo.boardState[rowNumber][i] == blockStateKind) break;
      if (result[rowNumber][i] == blockStateKind) {
        for (var j = columnNumber + 1; j < i; j++) {
          result[rowNumber][j] = blockStateKind;
        }
      }
    }

    return result;
  }

  @override
  List<List<BlockStateKind>> updateTop(int rowNumber, int columnNumber) {
    super.updateTop(rowNumber, columnNumber);
    var result = boardInfo.boardState;
    result[rowNumber][columnNumber] = blockStateKind;

    for (var i = columnNumber - 1; i >= 1; i--) {
      if (boardInfo.boardState[rowNumber][i] == BlockStateKind.notExistStone || boardInfo.boardState[rowNumber][i] == blockStateKind) break;
      if (result[rowNumber][i] == blockStateKind) {
        for (var j = columnNumber - 1; j > i; j--) {
          result[rowNumber][j] = blockStateKind;
        }
      }
    }
    return result;
  }

  @override
  List<List<BlockStateKind>> updateLeft(int rowNumber, int columnNumber) {
    super.updateRight(rowNumber, columnNumber);
    var result = boardInfo.boardState;
    result[rowNumber][columnNumber] = blockStateKind;

    for (var i = rowNumber - 1; i >= 1; i--) {
      if (boardInfo.boardState[i][columnNumber] == BlockStateKind.notExistStone || boardInfo.boardState[i][columnNumber] == blockStateKind) break;
      if (result[i][columnNumber] == blockStateKind) {
        for (var j = rowNumber - 1; j > i; j--) {
          result[j][columnNumber] = blockStateKind;
        }
      }
    }
    return result;
  }

  @override
  List<List<BlockStateKind>> updateRight(int rowNumber, int columnNumber) {
    super.updateRight(rowNumber, columnNumber);
    var result = boardInfo.boardState;
    result[rowNumber][columnNumber] = blockStateKind;

    for (var i = rowNumber + 1; i <= 8; i++) {
      if (boardInfo.boardState[i][columnNumber] == BlockStateKind.notExistStone || boardInfo.boardState[i][columnNumber] == blockStateKind) break;
      if (result[i][columnNumber] == blockStateKind) {
        for (var j = rowNumber + 1; j < i; j++) {
          result[j][columnNumber] = blockStateKind;
        }
      }
    }
    return result;
  }
}
