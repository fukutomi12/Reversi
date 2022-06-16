import 'package:testoth/board/board_info.dart';

abstract class PlayerBase {
  List<List<BlockStateKind>>? updateUnder(int columnNumber, int rowNumber) {}
  List<List<BlockStateKind>>? updateRight(int columnNumber, int rowNumber) {}
  List<List<BlockStateKind>>? updateTop(int columnNumber, int rowNumber) {}
  List<List<BlockStateKind>>? updateLeft(int columnNumber, int rowNumber) {}
  List<List<BlockStateKind>>? updateRightUpper(int columnNumber, int rowNumber) {}
  List<List<BlockStateKind>>? updateLeftLower(int columnNumber, int rowNumber) {}
  List<List<BlockStateKind>>? updateLeftUpper(int columnNumber, int rowNumber) {}
  List<List<BlockStateKind>>? updateRightLower(int columnNumber, int rowNumber) {}
}
