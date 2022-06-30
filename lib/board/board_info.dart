enum BlockStateKind {
  //　マス目が存在しない(盤面外)
  notExistSpace,

  // 石が存在しない
  notExistStone,

  // 黒色
  blackStone,

  // 白色
  whiteStone,
}

List<List<BlockStateKind>> initBoardState = [
  [
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistSpace
  ],
  [
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistSpace
  ],
  [
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistSpace
  ],
  [
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistSpace
  ],
  [
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.blackStone,
    BlockStateKind.whiteStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistSpace
  ],
  [
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.whiteStone,
    BlockStateKind.blackStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistSpace
  ],
  [
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistSpace
  ],
  [
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistSpace
  ],
  [
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistStone,
    BlockStateKind.notExistSpace
  ],
  [
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistSpace,
    BlockStateKind.notExistSpace
  ]
];

class BoardUpdate {
  // 初期状態
  BoardUpdate.init() : boardState = initBoardState;

  List<List<BlockStateKind>> boardState;

  List<List<BlockStateKind>> updateUnder(int columnNumber, int rowNumber, BlockStateKind blockStateKind) {
    List<List<BlockStateKind>> result = boardState;
    result[columnNumber][rowNumber] = blockStateKind;

    for (var i = rowNumber + 1; i <= 8; i++) {
      if (boardState[columnNumber][i] == BlockStateKind.notExistStone || boardState[columnNumber][rowNumber + 1] == blockStateKind) break;
      if (result[columnNumber][i] == blockStateKind) {
        for (var j = rowNumber + 1; j < i; j++) {
          result[columnNumber][j] = blockStateKind;
        }
      }
    }
    return result;
  }

  List<List<BlockStateKind>> updateTop(int columnNumber, int rowNumber, BlockStateKind blockStateKind) {
    List<List<BlockStateKind>> result = boardState;
    result[columnNumber][rowNumber] = blockStateKind;

    for (var i = rowNumber - 1; i >= 1; i--) {
      if (boardState[columnNumber][i] == BlockStateKind.notExistStone || boardState[columnNumber][rowNumber - 1] == blockStateKind) break;
      if (result[columnNumber][i] == blockStateKind) {
        for (var j = rowNumber - 1; j > i; j--) {
          result[columnNumber][j] = blockStateKind;
        }
      }
    }
    return result;
  }

  List<List<BlockStateKind>> updateLeft(int columnNumber, int rowNumber, BlockStateKind blockStateKind) {
    List<List<BlockStateKind>> result = boardState;
    result[columnNumber][rowNumber] = blockStateKind;

    for (var i = columnNumber - 1; i >= 1; i--) {
      if (boardState[i][rowNumber] == BlockStateKind.notExistStone || boardState[columnNumber - 1][rowNumber] == blockStateKind) break;
      if (result[i][rowNumber] == blockStateKind) {
        for (var j = columnNumber - 1; j > i; j--) {
          result[j][rowNumber] = blockStateKind;
        }
      }
    }
    return result;
  }

  List<List<BlockStateKind>> updateRight(int columnNumber, int rowNumber, BlockStateKind blockStateKind) {
    List<List<BlockStateKind>> result = boardState;
    result[columnNumber][rowNumber] = blockStateKind;

    for (var i = columnNumber + 1; i <= 8; i++) {
      if (boardState[i][rowNumber] == BlockStateKind.notExistStone || boardState[columnNumber + 1][rowNumber] == blockStateKind) break;
      if (result[i][rowNumber] == blockStateKind) {
        for (var j = columnNumber + 1; j < i; j++) {
          result[j][rowNumber] = blockStateKind;
        }
      }
    }
    return result;
  }

  List<List<BlockStateKind>> updateRightUpper(int columnNumber, int rowNumber, BlockStateKind blockStateKind) {
    List<List<BlockStateKind>> result = boardState;
    result[columnNumber][rowNumber] = blockStateKind;
    List<List<int>> list = [];
    int count = 1;

    for (var i = columnNumber + 1; i <= 8; i++) {
      if (boardState[i][rowNumber - count] == BlockStateKind.notExistStone || boardState[i][rowNumber - count] == BlockStateKind.notExistSpace) break;
      if (boardState[i][rowNumber - count] == blockStateKind) {
        int count2 = 1;
        for (var j = columnNumber + 1; j < i; j++) {
          list.add([j, rowNumber - count2]);
          ++count2;
        }
        break;
      }
      ++count;
    }
    for (final e in list) {
      result[e[0]][e[1]] = blockStateKind;
    }
    return result;
  }

  List<List<BlockStateKind>> updateLeftLower(int columnNumber, int rowNumber, BlockStateKind blockStateKind) {
    List<List<BlockStateKind>> result = boardState;
    result[columnNumber][rowNumber] = blockStateKind;
    List<List<int>> list = [];
    int count = 1;

    for (var i = columnNumber - 1; i >= 1; i--) {
      if (boardState[i][rowNumber + count] == BlockStateKind.notExistStone || boardState[i][rowNumber + count] == BlockStateKind.notExistSpace) break;
      if (boardState[i][rowNumber + count] == blockStateKind) {
        int count2 = 1;
        for (var j = columnNumber - 1; j > i; j--) {
          list.add([j, rowNumber + count2]);
          ++count2;
        }
        break;
      }
      ++count;
    }
    for (final e in list) {
      result[e[0]][e[1]] = blockStateKind;
    }
    return result;
  }

  List<List<BlockStateKind>> updateLeftUpper(int columnNumber, int rowNumber, BlockStateKind blockStateKind) {
    List<List<BlockStateKind>> result = boardState;
    result[columnNumber][rowNumber] = blockStateKind;
    List<List<int>> list = [];
    int count = 1;

    for (var i = columnNumber - 1; i >= 1; i--) {
      if (boardState[i][rowNumber - count] == BlockStateKind.notExistStone || boardState[i][rowNumber - count] == BlockStateKind.notExistSpace) break;
      if (boardState[i][rowNumber - count] == blockStateKind) {
        int count2 = 1;
        for (var j = columnNumber - 1; j > i; j--) {
          list.add([j, rowNumber - count2]);
          ++count2;
        }
        break;
      }
      ++count;
    }
    for (final e in list) {
      result[e[0]][e[1]] = blockStateKind;
    }
    return result;
  }

  List<List<BlockStateKind>> updateRightLower(int columnNumber, int rowNumber, BlockStateKind blockStateKind) {
    List<List<BlockStateKind>> result = boardState;
    result[columnNumber][rowNumber] = blockStateKind;
    List<List<int>> list = [];
    int count = 1;

    for (var i = columnNumber + 1; i <= 8; i++) {
      if (boardState[i][rowNumber + count] == BlockStateKind.notExistStone || boardState[i][rowNumber + count] == BlockStateKind.notExistSpace) break;
      if (boardState[i][rowNumber + count] == blockStateKind) {
        int count2 = 1;
        for (var j = columnNumber + 1; j < i; j++) {
          list.add([j, rowNumber + count2]);
          ++count2;
        }
        break;
      }
      ++count;
    }
    for (final e in list) {
      result[e[0]][e[1]] = blockStateKind;
    }
    return result;
  }
}
