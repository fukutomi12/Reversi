import 'package:testoth/board/board_info.dart';

abstract class PlayerBase {
  List<List<BlockStateKind>>? updateUnder(int rowNumber, int columnNumber) {}
  List<List<BlockStateKind>>? updateRight(int rowNumber, int columnNumber) {}
  List<List<BlockStateKind>>? updateTop(int rowNumber, int columnNumber) {}
  List<List<BlockStateKind>>? updateLeft(int rowNumber, int columnNumber) {}
}
