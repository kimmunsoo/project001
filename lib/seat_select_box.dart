import 'package:flutter/material.dart';

class SeatSelectBox extends StatelessWidget {
  SeatSelectBox(this.selectedRow, this.selectedCol, this.onSelected);

  final int? selectedRow;
  final int? selectedCol;
  final void Function(int row, int col) onSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Screen',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          for (int i = 1; i <= 5; i++) ...[
            row(i),
            const SizedBox(height: 8),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              label('Available', Colors.grey),
              const SizedBox(width: 8),
              label('Selected', Colors.amber),
            ],
          ),
        ],
      ),
    );
  }

  Row label(String text, Color color) {
    return Row(
      children: [
        Text(text),
        const SizedBox(width: 4),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }

  Widget row(int rowNum) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                '$rowNum',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          for (int col = 1; col <= 10; col++) seat(rowNum, col),
        ],
      ),
    );
  }

  Widget seat(int rowNum, int colNum) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: GestureDetector(
          onTap: () {
            onSelected(rowNum, colNum);
          },
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: rowNum == selectedRow && colNum == selectedCol
                    ? Colors.amber
                    : Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
