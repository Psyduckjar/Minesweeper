
private int NUM_ROWS = 20; 
private int NUM_COLS = 20;
//private int NUM_BOMBS = 8

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int row = 0; row < buttons.length; row++) {
    for (int col = 0; col < buttons[row].length; col++) {
      buttons[row][col] = new MSButton(row, col);
    }
  }
  bombs = new ArrayList<MSButton>();


  setBombs();
}
public void setBombs()
{
  int r = (int)(Math.random() * NUM_ROWS);
  int c = (int)(Math.random() * NUM_COLS);
  if (!(bombs.contains(buttons[r][c]))) {
    bombs.add(buttons[r][c]); 
    println(r + "," + c);
  }
}

public void draw ()
{
  background( 0 );
  if (isWon())
    displayWinningMessage();
}
public boolean isWon()
{
  for (int row = 0; row < buttons.length; row++) {
    for (int col = 0; col < buttons[row].length; col++) {
      if (bombs.contains(buttons[row][col]) && buttons[row][col].isMarked() == true) {
        return true;
      }
    }
  }
  return false;
}
public void displayLosingMessage()
{
  //your code here
}
public void displayWinningMessage()
{
  //your code here
}

public class MSButton
{
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, marked;
  private String label;

  public MSButton ( int rr, int cc )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = rr;
    c = cc; 
    x = c*width;
    y = r*height;
    label = "";
    marked = clicked = false;
    Interactive.add( this ); // register it with the manager
  }
  public boolean isMarked()
  {
    return marked;
  }
  public boolean isClicked()
  {
    return clicked;
  }
  // called by manager

  public void mousePressed () 
  {
    clicked = true;
    if (mouseButton == RIGHT) {
      marked = !marked;
      if (marked == false) {
        clicked = false;
      }
    } else if (bombs.contains(this)) {
      displayLosingMessage();
    } else if (countBombs(r, c) > 0) {
      fill(0, 255, 0);
      setLabel("" + countBombs(r, c));
    } else {
      if (isValid(r-1, c-1) && buttons[r-1][c-1].isClicked() == false) {
        buttons[r-1][c-1].mousePressed();
      }
      if (isValid(r-1, c) && buttons[r-1][c].isClicked() == false) {
        buttons[r-1][c].mousePressed();
      }
      if (isValid(r-1, c+1) && buttons[r-1][c+1].isClicked() == false) {
        buttons[r-1][c+1].mousePressed();
      }
      if (isValid(r, c-1) && buttons[r][c-1].isClicked() == false) {
        buttons[r][c-1].mousePressed();
      }
      if (isValid(r, c+1) && buttons[r][c+1].isClicked() == false) {
        buttons[r][c+1].mousePressed();
      }
      if (isValid(r+1, c-1) && buttons[r+1][c-1].isClicked() == false) {
        buttons[r+1][c-1].mousePressed();
      }
      if (isValid(r+1, c) && buttons[r+1][c].isClicked() == false) {
        buttons[r+1][c].mousePressed();
      }
      if (isValid(r, c+1) && buttons[r][c+1].isClicked() == false) {
        buttons[r][c+1].mousePressed();
      }
    }
  }

  public void draw () 
  {    
    if (marked)
      fill(0);
    else if ( clicked && bombs.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
  public boolean isValid(int r, int c)
  {
    if (r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS) {
      return true;
    } else {
      return false;
    }
  }
  public int countBombs(int row, int col)
  {
    int numBombs = 0;
    for (int ro = row - 1; ro <= row + 1; ro++) {
      for (int co = col - 1; co <= col + 1; co++) {
        if (isValid(ro, co) && bombs.contains(buttons[ro][co])) {
          numBombs++;
        }
      }
    }
    return numBombs;
  }
}
