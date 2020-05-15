/*
*@author : José de Jesús Barajas Figueroa
*Programa que hace esteganografia
*/
public class Imagen{
  private PImage img;
  private PImage imgOriginal;
  
  
  Imagen(PImage img,PImage imgOriginal){
    this.img         = img;
    this.imgOriginal = imgOriginal;
    } 
 
  public void sepia(int depth){
    imgOriginal.loadPixels();
    for(int i  = 0 ; i<img.pixels.length;i++){
     int rojo  = int(red(imgOriginal.pixels[i]));
     int verde = int(green(imgOriginal.pixels[i]));
     int azul  = int(blue(imgOriginal.pixels[i]));
     int gris  = (rojo+verde+azul)/3;
     rojo = gris+(depth*2);
     verde = gris+depth;
     if (rojo <= ((depth*2)-1))
       rojo = 255;
     if (verde <= (depth-1))
       verde = 255;
     img.pixels[i]=color(rojo,verde,azul);
    }
     
   img.updatePixels();
   println("FINISH");          
 }
 
}
