
import java.util.Hashtable;
import java.util.Set;
  
/*
@author : José de Jesús Barajas Figueroa
*UNAM,PDI
*Programa que  busca en el archivo de datos y realiza un fitro mosaico
*/
public class Imagen{
  private PImage img;
  private PImage copiaSmall;  
  Hashtable <Integer, PImage> colores; //Mejora el desempenio
  private int resolucion;
  private int w;                       //variable de ancho 
  private int h;                       //variable de alto
  private int avance;
  String directorioImg;  
  
  /*
  * Constructor del objeto Imagen
  @param img : La imagen que se va a modificar
  @param datos : la ruta dela rchivo de datos
  @param resolucion : El tamaño de cada bloque de mosaico por lado
  */
  Imagen(PImage img,String datos,int resolucion){
    this.img         = img;   
    this.directorioImg= datos;
    this.resolucion = resolucion;
    w = ceil(float(img.width)/float(resolucion));
    h = ceil(float(img.height)/float(resolucion));
    avance = 0;
    copiaSmall =createImage(w,h,RGB);
    this.copiaSmall.copy(img,0,0,img.width,img.height,0,0,w,h);
    colores = new Hashtable<Integer,PImage>();
    } 
    
  /*
  *Método que modifica el valor dela resolucion de los bloques de mosaico
  @param resolucion : entero que indica el numero ed pixeles de cada lado del recuadro que tendra cada bloque del mosaico
  */
  public void  setResolucion(int resolucion){
    this.resolucion = resolucion;
    w = ceil(float(img.width)/float(resolucion));
    h = ceil(float(img.height)/float(resolucion));
  }
  
  /*
  *Método que modifica la ruta del directorio donde estan los archivos
  @param directorioImg : Nueva ruta del directorio
  */
  public void setDirectorioImagenes(String directorioImg){
    this.directorioImg= directorioImg;
  }
  
  /*
  *Método que utilizo para mi mejora de tiempo, normaliza el espacio de colores, pasa de 16,000,000 de posibilidades a 25,000, cambia el tono de manera imperceptible
  @param colorOriginal : entero que representa un color
  @return un entero que es el color de parametro normalizdo al numero multiplo de 10 inmediato inferior
  */
  public int normalizaColor(int colorOriginal){
   int rojo = int(red(colorOriginal)/10)*10;
   int verde = int(green(colorOriginal)/10)*10;
   int azul = int(blue(colorOriginal)/10)*10;
   return color(rojo,verde,azul);  
  }
  
  /*
  * Método para buscar una imagen con el tono de color similar al bloque que estamos analizando
  @param clrImgOriginal : entero que representa el color del bloque de la imagen
  @param distancia : True para rimersma, False para euclidiana
  @return Una imagen que tiene un color similar al bloque 
  */
  public PImage imagenColorSimilar(int clrImgOriginal,boolean distancia){
   BufferedReader reader     = createReader(this.directorioImg);
   String line = null;
   float menor = 100000;
   PImage imagenSeleccionada = img ;
   clrImgOriginal = normalizaColor(clrImgOriginal);
   if(colores.containsKey(clrImgOriginal)){
     return colores.get(clrImgOriginal);
   }
   else{
      try {
        while ((line = reader.readLine()) != null) {
        String[] pieces = split(line, ",");
        int colorImagenAux  = int(pieces[1]);
        float diferencia = distanciaColor(clrImgOriginal,colorImagenAux,distancia);
        if (diferencia < menor){
          menor = diferencia;
          imagenSeleccionada = loadImage(pieces[0]);
        }
        if(menor < 30.0) break;
      }
      reader.close();
      } catch (IOException e) {
        e.printStackTrace();
       }
     }
     colores.put(clrImgOriginal,imagenSeleccionada);
     return imagenSeleccionada;
  }
  /*
  *Método que calcula la distancia entre 2 colores
  @param color1 : color con el que se va a comparar
  @param color2 : el color que quieres conocer su distnacia con otro
  @distnaciaRiemersma : True si se quiere la distancia de Riemersma, False si se quiere distancia euclidiana
  @return : número decimal que representa la distancia en el espacioentre 2 colores 
  */
  public float distanciaColor(int color1,int color2, boolean distanciaRiemersma){
   /* float r1 = red(color1);
    float g1 = green(color1);
    float b1 = blue(color1);
    float r2 = red(color2);
    float g2 = green(color2);
    float b2 = blue(color2);*/
    float deltaR = red(color2)-red(color1);
    float deltaG = green(color2)-green(color1);
    float deltaB = blue(color2)-blue(color1);
    float f = (red(color2)+red(color1))/2;
      
    if( distanciaRiemersma){
      return sqrt(((2+(f/256))*pow(deltaR,2))+(4*pow(deltaG,2))+((2+((255-f)/256))*pow(deltaB,2)));
    }
    return sqrt(pow(deltaR,2)+pow(deltaG,2)+pow(deltaB,2));
    }
    
    
 /*
  * Metodo que regresa el color promedio de un rectangulo de pixeles, el rectangulo ocupa "j" pixeles de ancho
  * y "j" pixeles de alto
  @ param int x, coordenada x donde comienza el rectangulo
  @ param int y, coordenada y donde comienza el rectangulo
  @return un color correspondiente al rectangulo de tamaño resolucion x resolucion, que empieza en las coordenadas (x,y)
  */

  public color getColorBloque(int x, int y){
    int pixelAux=y*w +x;
    return copiaSmall.pixels[pixelAux]; 
   }
  
  /*
  * Metodo que dibuja una imagen con mosaicos hechos de imagenes que previamente se procesaron
  @param distanciaRimersma : True si se quiere calcular la distancia  con la fomrula de riemersma
                             False si se quiere distancia euclidiana
  */
  public void mosaico(boolean distanciaRiemersma){
   copiaSmall.loadPixels();
   println("comenzando");
   int start =  millis();
   for (int y = 0; y < h; y ++) {
    for (int x = 0; x < w; x ++) {
      color colorSeccion = getColorBloque(x,y);
      PImage imgNueva = imagenColorSimilar(colorSeccion,distanciaRiemersma);
      imgNueva.resize(resolucion,resolucion);
      imgNueva.loadPixels();
      img.copy(imgNueva,0,0,imgNueva.width,imgNueva.height,x*resolucion,y*resolucion,resolucion,resolucion);
      avance = x+y*w;
      println(avance);
    }
  }
   print( (millis()-start)/1000);
   println(" segundos");
   println("FINISH");
   img.updatePixels();
  }
}
