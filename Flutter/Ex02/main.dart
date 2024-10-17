import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('플러터 앱 만들기'),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                print('아이콘 버튼이 눌렸습니다');
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Text'),
              SizedBox(height: 10), // 버튼과 텍스트 사이의 간격
              ElevatedButton(
                onPressed: () {
                  print('버튼이 눌렸습니다');
                },
                child: Text('button'),
              ),
              SizedBox(height: 20), // 버튼과 컨테이너 사이의 간격
              // 6개의 크기가 다른 Container를 겹쳐서 배치
              Stack(
                alignment: Alignment.center,
                children: List.generate(6, (index) {
                  return Container(
                    width: 300 - index * 60.0,
                    height: 300 - index * 60.0,
                    color: Colors.blue[(index + 1) * 100], // 각 Container 색상 다르게 설정
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
