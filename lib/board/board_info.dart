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

/// 将来的にローカルに保存した盤面情報をコンストラクタで指定して
/// 途中からでも遊べるようにする
///
class BoardInfo {
  // ロールからの情報取得用
  BoardInfo({required this.boardState});

  // 初期状態
  BoardInfo.init() : boardState = initBoardState;

  List<List<BlockStateKind>> boardState;
}
