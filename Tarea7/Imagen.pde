/*
*@author : José de Jesús Barajas Figueroa
*Programa que implementa los filtro de Minimizacion e Icono
*/
import java.util.Hashtable;
import java.util.Set;
public class Imagen{
  private PImage img;
  private PGraphics lienso;
    
  Imagen(PImage img,PGraphics lienso){
    this.img        = img ;
    this.lienso     = lienso;
    }

  public Hashtable <Integer, Integer>  obtenerVecinos(int x, int y, int msize){
    Hashtable <Integer, Integer> frecuencias = new Hashtable<Integer, Integer>();
    img.loadPixels();
    int dimension = img.height*img.width;
    for (int kx = 0; kx < msize; kx++) {
      for (int ky = 0; ky < msize; ky++) {
      // Calculamos la posicion de cada pixel adyacente
      int xloc = x+kx;
      int yloc = y+ky;
      int pos = ((yloc*img.width + xloc)+dimension) % dimension;
      // Guardamos la suma de RGB de cada pixel adyacente
       if(frecuencias.containsKey(img.pixels[pos])){
         Integer valorAnterior = frecuencias.get(img.pixels[pos]);
         valorAnterior = valorAnterior+1;
         //frecuencias.remove(img.pixels[pos]);
         frecuencias.put(img.pixels[pos],valorAnterior);
       }
       else{
         frecuencias.put(img.pixels[pos],1);
       }
      
      }
     }
      return frecuencias;
    }
    
  public int obtenerColorMayorFrecuencia(Hashtable<Integer,Integer> frecuencias){
        int colorActual=#000000;
        int valorActual=0;
        Set<Integer> llaves = frecuencias.keySet();
        for(Integer key : llaves){
         int valorElemento = frecuencias.get(key);//El valor que tiene la llave key
                if(valorElemento > valorActual){
                    colorActual = key;
                    valorActual = valorElemento;
                                    }
        }
        return int(colorActual);
    }
    
    
  public void acuarela(int matrix_dim, boolean grises){
    lienso.beginDraw();
    lienso.clear();
    lienso.background(250);
    
   img.loadPixels();
   for (int x = 0; x < img.width; x++) {
     for (int y = 0; y < img.height; y++) {
       Hashtable <Integer, Integer> frecuencias = obtenerVecinos(x,y,matrix_dim);
       color c = obtenerColorMayorFrecuencia(frecuencias);
       int i = x+y*img.width;
      if(grises)
       img.pixels[i]=color(red(c),red(c),red(c));
      else{
       img.pixels[i]=color(red(c),green(c),blue(c)); 
     }
   }
   }
   img.save("imagen.png");
   img.updatePixels();
   lienso.image(img, 0, 0,img.width,img.height);
   lienso.endDraw();
   image(lienso,0,0,lienso.width,lienso.height);
   println("FINISH");
  
 }
}
