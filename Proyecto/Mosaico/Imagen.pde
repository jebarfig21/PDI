import java.util.Hashtable;
import java.util.Set;
  
/*
*@author : José de Jesús Barajas Figueroa
*Programa que hace esteganografia
*/

public class Imagen{
  private PImage img;
  private PImage imgOriginal;
  Hashtable <Integer, PImage> colores;
  PrintWriter output;
  String directorioImg;  
  
  
  Imagen(PImage img,PImage imgOriginal){
    this.img         = img;
    this.imgOriginal = imgOriginal;
    this.directorioImg= null;    
    } 
   
  public void setDirectorioImagenes(String directorioImg){
    this.directorioImg= directorioImg;
  }
  
  /*
  *Método que obtiene el color promedio(dominante) en la imagen 
  */
  private int obtenerColorImagen(PImage imagenActual){
    imagenActual.loadPixels();
    int dimension = imagenActual.height*imagenActual.width;
    int rojo = 0; int verde = 0; int azul = 0;
    for (int i = 0; i < dimension; i++) {
      rojo  += red(imagenActual.pixels[i]);
      verde += green(imagenActual.pixels[i]);
      azul  += blue(imagenActual.pixels[i]);
      }
     rojo/=dimension;verde/=dimension; azul/=dimension;
     return color(rojo,verde,azul);
    }
  
  /*
  *Esribe y calcula su valor en el archivo de datos
  */
  public void escribirDatosImagen(PImage imagenActual){
    int colorImagen =obtenerColorImagen(imagenActual);
    output.println(colorImagen+","+imagenActual);
   }
 
  /*
  *Mete una imagen a la hashtable
  */
  public float distanciaEuclidiana(int r1,int r2,int g1,int g2,int b1,int b2){
    return sqrt(pow(r2-r1,2)+pow(g2-g1,2)+pow(b2-b1,2));
    }
    
    
    
  public void crearMosaico(int anchoCuadro){
    imgOriginal.loadPixels();
    for(int i  = 0 ; i<img.pixels.length;i++){
     int rojo  = int(red(imgOriginal.pixels[i]));
     int verde = int(green(imgOriginal.pixels[i]));
     int azul  = int(blue(imgOriginal.pixels[i]));
     
     
   img.updatePixels();
    }
   println("FINISH");          
    
 }
  
 

}
