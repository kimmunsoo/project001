import 'dart:io';

// 상품 클래스
class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

// 쇼핑몰 클래스
class ShoppingMall {
  List<Product> productList = [
    Product('셔츠', 45000),
    Product('원피스', 30000),
    Product('반팔티', 35000),
    Product('반바지', 38000),
    Product('양말', 5000),
  ];

  int totalPrice = 0;

  // 상품 목록 출력
  void showProducts() {
    for (var product in productList) {
      print('${product.name} / ${product.price}원');
    }
  }

  // 장바구니에 상품 추가
  void addToCart() {
    stdout.write('상품 이름을 입력하세요: ');
    String? name = stdin.readLineSync()?.trim();

    if (name == null) {
      print('입력값이 올바르지 않아요 !');
      return;
    }

    stdout.write('상품 개수를 입력하세요: ');
    String? countInput = stdin.readLineSync()?.trim();

    // 입력값 유효성 검사
    if (countInput == null) {
      print('입력값이 올바르지 않아요 !');
      return;
    }

    int count;

    try {
      count = int.parse(countInput);
    } catch (e) {
      print('입력값이 올바르지 않아요 !');
      return;
    }

    if (count <= 0) {
      print('0개보다 많은 개수의 상품만 담을 수 있어요 !');
      return;
    }

    // 상품 존재 여부 확인
    Product? selectedProduct = productList.firstWhere(
      (p) => p.name == name,
      orElse: () => Product('', 0),
    );

    if (selectedProduct.name == '') {
      print('입력값이 올바르지 않아요 !');
      return;
    }

    totalPrice += selectedProduct.price * count;
    print('장바구니에 상품이 담겼어요 !');
  }

  // 장바구니 총 가격 출력
  void showTotal() {
    print('장바구니에 ${totalPrice}원 어치를 담으셨네요 !');
  }
}

// 메인 함수
void main() {
  ShoppingMall mall = ShoppingMall();
  bool isRunning = true;

  print('🛒 쇼핑몰에 오신 걸 환영합니다!\n');

  while (isRunning) {
    print('\n1: 상품 목록 보기');
    print('2: 장바구니에 상품 담기');
    print('3: 총 가격 보기');
    print('4: 종료');
    stdout.write('원하는 번호를 입력하세요: ');

    String? input = stdin.readLineSync();
    print('');

    switch (input) {
      case '1':
        mall.showProducts();
        break;
      case '2':
        mall.addToCart();
        break;
      case '3':
        mall.showTotal();
        break;
      case '4':
        print('이용해 주셔서 감사합니다 ~ 안녕히 가세요 !');
        isRunning = false;
        break;
      default:
        print('올바른 번호를 입력해주세요.');
    }
  }
}


