
CirCol c = new CirCol(500, 500, 50);
BoxCol b = new BoxCol(460, 500, 50, 50);

void setup()
{
  size(1200,800);
}

void draw()
{
   c.render();
   b.render();
   
   println(c.checkCol(b));
}
