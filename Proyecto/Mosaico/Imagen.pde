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
  String directorioImg;  
  
  
  Imagen(PImage img,PImage imgOriginal,String datos){
    this.img         = img;
    this.imgOriginal = imgOriginal;
    this.directorioImg= datos;    
    } 
   
  public void setDirectorioImagenes(String directorioImg){
    this.directorioImg= directorioImg;
  }
  
  public PImage imagenColorSimilar(int clrImgOriginal){
   BufferedReader reader     = createReader(this.directorioImg);
   String line = null;
   float menor = 100000;
   String selec = "";
    PImage imagenSeleccionada = img ;
      try {
        while ((line = reader.readLine()) != null) {
        String[] pieces = split(line, ",");
        int colorImagenAux  = int(pieces[1]);
        float diferencia = distanciaEuclidiana(clrImgOriginal,colorImagenAux);
        if (diferencia < menor){
          menor = diferencia;
          imagenSeleccionada = loadImage(pieces[0]);
          selec = pieces[0];
        }
      }
      reader.close();
      } catch (IOException e) {
        e.printStackTrace();
       }
       return imagenSeleccionada;
  }
  /*
  *Mete una imagen a la hashtable
  */
  public float distanciaEuclidiana(int color1,int color2){
    int r1 = int(red(color1));
    int g1 = int(green(color1));
    int b1 = int(blue(color1));
    int r2 = int(red(color2));
    int g2 = int(green(color2));
    int b2 = int(blue(color2));
    return sqrt(pow(r2-r1,2)+pow(g2-g1,2)+pow(b2-b1,2));
    }
    
    
 /*
*
* Metodo que regresa el color promedio de un rectangulo de pixeles, el rectangulo ocupa "j" pixeles de ancho
* y "j" pixeles de alto
* @ param int x, coordenada x donde comienza el rectangulo
* @ param int y, coordenada y donde comienza el rectangulo
* @return un color correspondiente al rectangulo de tamaño resolucion x resolucion, que empieza en las coordenadas (x,y)
*/

  public color getColorBloque(int x, int y,int resolucion){
    float numeroPixeles = resolucion*resolucion;
    float rojo  = 0; float verde = 0; float azul  = 0;
    for(int j = 0 ; j < resolucion; j++){//y
      for(int i = 0 ; i < resolucion; i++){//x
      int pixelAux=y*img.width +x;
      constrain(pixelAux,0,(img.width*img.height)-2);
       rojo  += red(img.pixels[pixelAux]);
       verde += green(img.pixels[pixelAux]);
       azul  += blue(img.pixels[pixelAux]);
      }
    }
    rojo  /= numeroPixeles; verde /= numeroPixeles; azul  /= numeroPixeles; 
  return color(rojo,verde,azul);  
  } 
  
  public void mosaico(int resolucion){
   img.loadPixels();
   println("comenzando");
   for (int y = 0; y < img.height; y += resolucion) {
    for (int x = 0; x < img.width; x += resolucion) {
      color colorSeccion = getColorBloque(x,y,resolucion);
      PImage imgNueva = imagenColorSimilar(colorSeccion);
      imgNueva.resize(resolucion,resolucion);
      imgNueva.loadPixels();
       for(int j = 0; j <imgNueva.height; j++){//y
          for(int i = 0; i < imgNueva.width; i++){//x
          int pixelImagenOriginal =(x+i)+((y+j)*img.width);
          constrain(pixelImagenOriginal,0,(img.width*img.height)-3);
          int pixelNuevo = (i+j*imgNueva.width);
          constrain(pixelNuevo,0,(imgNueva.width*imgNueva.height)-2);
          if(pixelImagenOriginal>=img.width*img.height) pixelImagenOriginal=(img.width*img.height)-1;
          img.pixels[pixelImagenOriginal] = imgNueva.pixels[pixelNuevo]; 
          }
        }
    }
   }
   println("FINISH");
   img.updatePixels();
  }

}
