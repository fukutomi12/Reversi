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
    List<List<int>> list = [];
    var count = 1;
    for (var i = columnNumber + 1; i <= 8; i++) {
      if (boardInfo.boardState[i][rowNumber - count] == BlockStateKind.notExistStone ||
          boardInfo.boardState[i][rowNumber - count] == BlockStateKind.notExistSpace) break;

      if (boardInfo.boardState[i][rowNumber - count] == blockStateKind) {
        var count2 = 1;
        for (var j = columnNumber + 1; j < i; j++) {
          list.add([j, rowNumber - count2]);
          ++count2;
        }
        break;
      }

      ++count;
    }

    for (var e in list) {
      result[e[0]][e[1]] = blockStateKind;
    }

    return result;
  }

  @override
  List<List<BlockStateKind>> updateLeftLower(int columnNumber, int rowNumber) {
    super.updateLeftLower(columnNumber, rowNumber);
    var result = boardInfo.boardState;
    result[columnNumber][rowNumber] = blockStateKind;
    List<List<int>> list = [];
    var count = 1;
    for (var i = columnNumber - 1; i >= 1; i--) {
      if (boardInfo.boardState[i][rowNumber + count] == BlockStateKind.notExistStone ||
          boardInfo.boardState[i][rowNumber + count] == BlockStateKind.notExistSpace) break;

      if (boardInfo.boardState[i][rowNumber + count] == blockStateKind) {
        var count2 = 1;
        for (var j = columnNumber - 1; j > i; j--) {
          list.add([j, rowNumber + count2]);
          ++count2;
        }
        break;
      }

      ++count;
    }
    for (var e in list) {
      result[e[0]][e[1]] = blockStateKind;
    }

    return result;
  }

  @override
  List<List<BlockStateKind>> updateLeftUpper(int columnNumber, int rowNumber) {
    super.updateLeftUpper(columnNumber, rowNumber);
    var result = boardInfo.boardState;
    result[columnNumber][rowNumber] = blockStateKind;
    List<List<int>> list = [];
    var count = 1;
    for (var i = columnNumber - 1; i >= 1; i--) {
      if (boardInfo.boardState[i][rowNumber - count] == BlockStateKind.notExistStone ||
          boardInfo.boardState[i][rowNumber - count] == BlockStateKind.notExistSpace) break;

      if (boardInfo.boardState[i][rowNumber - count] == blockStateKind) {
        var count2 = 1;
        for (var j = columnNumber - 1; j > i; j--) {
          list.add([j, rowNumber - count2]);
          ++count2;
        }
        break;
      }

      ++count;
    }
    for (var e in list) {
      result[e[0]][e[1]] = blockStateKind;
    }

    return result;
  }

  @override
  List<List<BlockStateKind>> updateRightLower(int columnNumber, int rowNumber) {
    super.updateRightLower(columnNumber, rowNumber);
    var result = boardInfo.boardState;
    result[columnNumber][rowNumber] = blockStateKind;
    List<List<int>> list = [];
    var count = 1;
    for (var i = columnNumber + 1; i <= 8; i++) {
      if (boardInfo.boardState[i][rowNumber + count] == BlockStateKind.notExistStone ||
          boardInfo.boardState[i][rowNumber + count] == BlockStateKind.notExistSpace) break;

      if (boardInfo.boardState[i][rowNumber + count] == blockStateKind) {
        var count2 = 1;
        for (var j = columnNumber + 1; j < i; j++) {
          list.add([j, rowNumber + count2]);
          ++count2;
        }
        break;
      }

      ++count;
    }

    for (var e in list) {
      result[e[0]][e[1]] = blockStateKind;
    }

    return result;
  }
}
