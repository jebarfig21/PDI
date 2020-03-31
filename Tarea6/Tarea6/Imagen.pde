/*
*@author : José de Jesús Barajas Figueroa
*Programa que implementa los filtro de Minimizacion e Icono
*/
public class Imagen{
    private PImage img;
    private PGraphics lienso;
    
    Imagen(PImage img,PGraphics lienso){
      this.img        = img ;
      this.lienso     = lienso;
    }
  
  /*
  *Metodo que obtiene el color promedio de un bloque 
  *@param x, posicion en x donde inicia el bloque
  *@param y, posicion en y donde inicia el bloque
  *@param ancho, ancho de cada bloque
  *@param alto, alto de cada bloque
  */
  
  public color getColorBloque(int x, int y,  int ancho, int alto){
    float numeroPixeles = ancho*alto;
    float rojo  = 0;
    float verde = 0;
    float azul  = 0;
    for(int j = 0 ; j < alto; j++){//y
      for(int i = 0 ; i < ancho; i++){//x
       rojo  += red(img.pixels[y*img.width +x]);
       verde += green(img.pixels[y*img.width+x]);
       azul  += blue(img.pixels[y*img.width+x]);
      }
    }
    rojo = rojo/numeroPixeles;
    verde =verde/numeroPixeles;
    azul = azul/numeroPixeles; 
  return color(rojo,verde,azul);  
  } 

  /*
  *Metodo que reduce una imagen en x = procentajeX y y = porcentajeY
  *@param STRporcentajeX = Porcentaje que se quiere tener en X
  *@param STRporcentajeY = Porcentaje que se quiere tener en Y
  */
  public void reduceImagen(String STRporcentajeX,String STRporcentajeY){
    lienso.beginDraw();
    lienso.clear();
    lienso.background(250);
    float porcentajeX;
    float porcentajeY;
    
    if(STRporcentajeX!=""){
      porcentajeX = float(STRporcentajeX);}
    else{
      porcentajeX=50;}
  
    if(STRporcentajeX!=""){
      porcentajeY = float(STRporcentajeY);}
    else{
      porcentajeY=50;}
    
    porcentajeX = porcentajeX/100;
    porcentajeY = porcentajeY/100;
    PImage result = createImage(int(img.width*porcentajeX),int(img.height*porcentajeY),RGB);
    float bloqueAncho = float(img.width)/float(result.width);
    float bloqueAlto = float(img.height)/float(result.height);
    result.loadPixels();
    for (int x = 0; x < result.width ; x++){
        for (int y = 0; y < result.height ; y++){
          result.pixels[x+y*result.width]=
                  
                       img.pixels[int((x*bloqueAncho)+(int(y*bloqueAlto)*img.width))] ;
        }
    }
    
    result.updatePixels();
    lienso.image(result, 0, 0,result.width,result.height);
    lienso.endDraw();
    image(lienso,0,0,lienso.width,lienso.height);
  }
  
  /*
  *Metodo que vuelve una imagen un icono cuadrado 
  *@param resolucion : Dimension que va a tener el icono
  */
  public void imagenToIcono(int resolucion){
    lienso.beginDraw();
    lienso.background(250);
    PImage result = createImage(resolucion,resolucion,RGB);
    result.loadPixels();  
    int bloqueAncho = img.width/resolucion;
    int bloqueAlto = img.height/resolucion;
    for (int y = 0; y < result.height; y ++){
     for (int x = 0; x < result.width; x ++){
       color c = getColorBloque(x*bloqueAncho, y*bloqueAlto,bloqueAncho,bloqueAlto);
       result.pixels[x+y*result.width]=c;
    }
   }
   result.updatePixels();
   lienso.image(result, 0, 0,result.width,result.height);
   result.save("icono.png");
   lienso.endDraw();
   image(lienso,width*.45,height*.45,width*.45+lienso.width,height*.45+lienso.height);
  }
}
