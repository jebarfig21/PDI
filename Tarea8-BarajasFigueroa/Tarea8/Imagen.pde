/*
*@author : José de Jesús Barajas Figueroa
*Programa que implementa los filtro de Minimizacion e Icono
*/
public class Imagen{
  private PImage img;
  private PGraphics lienso;
  private int[] histograma;
  private int[] distribucion;
  private int[] ecualizar;
  private int cdf_min ;
  private int MxN;

  Imagen(PImage img,PGraphics lienso){
    this.img        = img ;
    this.lienso     = lienso;
    this.MxN        = img.width * img.height;
    }
  
  /*
  *Genera el histograma de la imagen
  */
  private void histograma(int L){
    histograma = new int[L];
    img.loadPixels();
    inicializarArreglo(histograma);
    for(int i = 0; i<img.pixels.length ; i++){//Creamos histograma
      color c = img.pixels[i];
      int gris= (int)red(c);
      histograma[gris]++; 
    }
  }
  
  
  /*
  *Genera la distribucion del histograma de la imagen
  */
  private void cdf(int L){
    histograma(L);
    distribucion = new int[histograma.length];
    inicializarArreglo(distribucion);
    int anterior = 0;
    for(int i = 0; i<histograma.length ; i++){//Inicializamos valores
      if(histograma[i]>0){
        distribucion[i]=distribucion[anterior]+histograma[i];
        anterior=i;
      }
    }
  }
  
  
  /*
  *Regresa el elemento mínimo de un arreglo
  */
  private int obtenerMinimo(int[] arreglo){
    int min = 0;
    for(int i = 0 ; i<arreglo.length ; i++){
      if(min == 0 && arreglo[i]!=0){
       min =  arreglo[i];
      }
      if(arreglo[i]<min & arreglo[i]!=0){
       min = arreglo[i]; 
      }
    }
    return min;
  }
  
  /*
  *Inicializa un arreglo de enteros con valor 0 en todas sus localidades
  */
  private void inicializarArreglo(int[] arreglo){
    for(int i = 0; i<arreglo.length ; i++) arreglo[i]=0; 
  }
  
  /*
  *Ecualiza la imagen usando el histograma y la distribucion
  */
  private void ecualizar(int L){
    cdf(L);
    ecualizar = new int[L];
    cdf_min = obtenerMinimo(distribucion);
    inicializarArreglo(ecualizar);
    for (int i = 0; i < ecualizar.length ; i++) {
      if(distribucion[i]!=0)
       ecualizar[i]=round(((float(distribucion[i]-cdf_min))/float((MxN - cdf_min))) * (L-1));     
    }
  }
  
  /*
  *Dibuja la imagen con la ecualizacion de histograma
  */
  public void contraste(int L){
    lienso.beginDraw();
    lienso.clear();
    lienso.background(250);
    img.loadPixels();
    ecualizar(L); 
    
    for (int i = 0; i < img.pixels.length ; i++) {
       int gris = int(red(color(img.pixels[i])));
       int gris_nuevo = ecualizar[gris];
       img.pixels[i]= color(gris_nuevo); 
       
     }
     
   println("FINISH");       
   img.updatePixels();
   lienso.image(img, 0, 0,img.width,img.height);
   lienso.endDraw();
   image(lienso,0,0,lienso.width,lienso.height);  
 }
 
}
