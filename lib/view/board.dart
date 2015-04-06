part of ex09;

class Board extends Surface {
  static const int carCount = 8;

  Cars cars;
  RedCar redCar;
  Area space;
  Game won;
  bool isGameOver;

  SpanElement end;
  SpanElement win;

  SelectElement selectDifficulty;

  Board(CanvasElement canvas): super(canvas) {
    end = querySelector('#end');
    win = querySelector('#win');

    clear();
    querySelector('#play').onClick.listen((e){
      init();
        });
    selectDifficulty = querySelector('#difficulty');
    selectDifficulty.value = 'Easy';
    selectDifficulty.onChange.listen((Event e) {
          setDifficulty();
        });
        document.onMouseMove.listen((MouseEvent e) {
          redCar.x = e.offset.x - redCar.width  / 2;
          redCar.y = e.offset.y - redCar.height / 2;
          redCar.move();
        });
        init();
      }

  setDifficulty() {
      switch (selectDifficulty.value) {
        case 'Easy': won.box.position = new Position (won.box.x, won.box.y); break;
        case 'Medium': won.box.position = new Position (won.box.x, 200); break;
        case 'Expert': won.box.position = new Position (won.box.x, 400);
      }
    }

  init(){
      isGameOver = false;
      space = new Area(width, height);
      cars = new Cars(carCount);
      cars.forEach((Car car) {
         car.space = space;
         car.jump();
         });
      redCar = cars.redCar;
      redCar.space = space;
      redCar.box.position = new Position (0 , 240);

      won = cars.won;
      won.space = space;
      setDifficulty();
  }


 draw() {
    clear();
    bool isAccident = false;
    for (Truck car in cars) {
      if(!isGameOver){
      car.move();
      cars.avoidCollisions(car);
      cars.forEach((car) {
        if (redCar.hit(car)) {
          isAccident= true;
        }
      });
      drawPiece(car);
    }
    if (isAccident) {
      isGameOver;
      end.text = "Game Over !!";
      init();

    }
      if (redCar.hit(won)) {
      isGameOver;
     win.text = "You win !!";
      init();

    }
    drawPiece(redCar);
    drawPiece(won);
    }
  }
}