part of ex09;

abstract class Car extends MovablePiece {
  static const num defaultWidth = 55;
  static const num defaultHeight = 20;

  Car(int id): super(id) {
    shape = PieceShape.VEHICLE;
    width = defaultWidth;
    height = defaultHeight;
  }
}

class Truck extends Car {

  Truck(int id): super(id) {
    color.main = 'green';
    speed = Speed.random();
    //shape = PieceShape.IMG();
    //imgId = 'truck';
  }
}


class RedCar extends Car {

  RedCar(int id): super(id) {
    color.main = "red";
    //shape = PieceShape.IMG();
    //imgId = 'redcar';
  }

  move([Direction direction]) {
    if (x > space.width - width) {
      x = space.width - width;
    }
    if (x < 0) {
      x = 0;
    }
    if (y > space.height - height) {
      y = space.height - height;
    }
    if (y < 0) {
      y = 0;
    }
  }
}

class Game extends Piece {
  static const defaultX = 600;
  static const defaultY = 50;
  static const defaultWidth = 32;
  static const defaultHeight = 480;

  Game(int id): super(id) {
     color.main = 'black';
     x = defaultX;
     y = defaultY;
     width = defaultWidth;
     height = defaultHeight;
     shape = PieceShape.RECT;
    }
}

class Cars extends MovablePieces {
  RedCar redCar;
  Game won;

  Cars(int count) : super(count) {
    redCar = new RedCar(0);
    won = new Game(count);
  }

  createMovablePieces(int count) {
    for (var i = 0; i < count - 1; i++) {
      add(new Truck(i + 1));
    }
  }
}