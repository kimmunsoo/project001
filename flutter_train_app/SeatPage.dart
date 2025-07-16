import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  final String departure;
  final String arrival;

  const SeatPage({super.key, required this.departure, required this.arrival});

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  int? selectedRow;
  int? selectedCol;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("좌석 선택"), // ❶ 앱바 타이틀 스타일 X
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          const SizedBox(height: 20),
          _stationHeader(), // 출발역, 도착역
          const SizedBox(height: 20),
          Expanded(child: _seatGrid()), // 스크롤 가능 좌석 영역
          _bookButton(), // 예매 버튼
        ],
      ),
    );
  }

  /// ❷❸ 출발역, 도착역 + 화살표
  Widget _stationHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.departure,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple,
                fontSize: 30)),
        const SizedBox(width: 10),
        const Icon(Icons.arrow_circle_right_outlined,
            size: 30, color: Colors.purple), // ❹
        const SizedBox(width: 10),
        Text(widget.arrival,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple,
                fontSize: 30)),
      ],
    );
  }

  /// ❺❼❽ 좌석 선택 영역 (스크롤)
  Widget _seatGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
        itemCount: 20, // 총 20행
        itemBuilder: (context, rowIndex) {
          int row = rowIndex + 1;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8), // 세로 간격 8
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 행 번호
                Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text("$row", style: const TextStyle(fontSize: 18)),
                ),
                const SizedBox(width: 4),
                // A, B, C, D 좌석
                for (int colIndex = 1; colIndex <= 4; colIndex++) ...[
                  _seatWidget(row, colIndex),
                  if (colIndex != 4) const SizedBox(width: 4),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  /// 좌석 위젯
  Widget _seatWidget(int row, int col) {
    bool isSelected = (selectedRow == row && selectedCol == col);
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRow = row;
          selectedCol = col;
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(String.fromCharCode(64 + col), // A, B, C, D
            style: const TextStyle(fontSize: 18)),
      ),
    );
  }

  /// ❾ 예매 버튼
  Widget _bookButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: selectedRow != null
              ? () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "예매 완료! 좌석: ${selectedRow}행 ${String.fromCharCode(64 + selectedCol!)}열",
                      ),
                    ),
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            "예매 하기",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}