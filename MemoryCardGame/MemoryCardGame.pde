public GameStatus gameStatus = GameStatus.START;
private CardList cardList;
private int cardsSelected;
public PImage backOfCard;

final int delay = 30; // aantal frames 
int delayCounter = 0;

void setup() {
  size(1500,850);
  frameRate(60);
  cardList = new CardList(20);
}

void draw() {
  
  drawStartScreen();
  
  switch(gameStatus) {
     case NO_CARDS_SELECTED:
       cardsSelected = 0;
       break;
     case DELAY:
      delayCounter++; //<>//
      if(delayCounter >= delay) {
        delayCounter = 0;
        
        // KAARTEN VERWIJDEREN
        cardList.removeCardsIfEqual();
        
        gameStatus = GameStatus.NO_CARDS_SELECTED;
      }
     break;
  }
}

void mousePressed() {
  for (int i = 0; i < cardList.cards.size(); i++) {
    if (cardList.cards.get(i).mouseOverCard() && cardList.cards.get(i).status != CardStatus.FLIPPED) {
        switch(gameStatus) {
      case NO_CARDS_SELECTED:
        cardList.flipCurrentCard();
        gameStatus = GameStatus.ONE_CARD_SELECTED;
        cardsSelected = 1;
      break;
      case ONE_CARD_SELECTED:
        cardList.flipCurrentCard();
        gameStatus = GameStatus.TWO_CARDS_SELECTED;
        cardsSelected = 2;
        // geen break hier
      case TWO_CARDS_SELECTED:
        gameStatus = GameStatus.DELAY;
       break;
      }
    }
  }
}

void drawStartScreen() {
  background(205);
  DiffEasy easy = new DiffEasy();
  DiffMedium medium = new DiffMedium();
  DiffHard hard = new DiffHard();
  fill(0);
  textSize(50);
  text("Memory Card Game", width/2 - textWidth("Memory Card Game")/2, 60);
  textSize(30);
  text("Select your difficulty", width/2 - textWidth("Select your difficulty")/2, 150);
  easy.drawPanel();
  rect(width/2-200, 250, 400, 500);
  rect(1000, 250, 400, 500);

  text("Medium", width/2 - 100, 450);
  text("Hard", 1140, 450);
}

void drawGameScreen() {
  background(205);
  textSize(28);
  fill(0);
  text("Memory Card Game", 10, 40);
  strokeWeight(3);
  line(0,60,300,60);
  line(300,0,300,height);
  text("Cards selected: " + cardsSelected, 10, 150);
  text("Cards left: " + cardList.cards.size(), 10, 300);
  
  cardList.drawAllCards();
}