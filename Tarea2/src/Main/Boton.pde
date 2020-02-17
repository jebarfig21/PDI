public class Boton{
 int x;
 int y;
 int ancho;
 int alto;
 String texto;
 
 public Boton(int x, int y, String texto){
 
 this.x=x;
 this.y=y;
 this.ancho=100;
 this.alto=60;
 fill(255);
 rect(x, y, ancho, alto);  
 fill(22);  
 text(texto, x+10, y+20);
 
 }
 
 public boolean isInBotonArea(int x, int y){
   if ((x>this.x) && (y>this.y) && (x<this.x+ancho) && (y<this.y+alto)) return true;

   return false;
 }
 
}
