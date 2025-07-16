import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeatBottom extends StatelessWidget {
  SeatBottom(this.selectedRow, this.selectedCol);

  final int? selectedRow;
  final int? selectedCol;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            selectedRow == null && selectedCol == null
                ? '선택된 좌석 없음'
                : '좌석: $selectedRow - $selectedCol',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            height: 56,
            child: ElevatedButton(
              onPressed: selectedRow != null && selectedCol != null
                  ? () {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: const Text('예약확인'),
                            content: const Text('예약 하시겠습니까?'),
                            actions: [
                              CupertinoDialogAction(
                                isDefaultAction: true,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('취소'),
                              ),
                              CupertinoDialogAction(
                                isDestructiveAction: true,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "예매 완료! 좌석: $selectedRow - $selectedCol",
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('확인'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              child: const Text('Book now'),
            ),
          ),
        ],
      ),
    );
  }
}