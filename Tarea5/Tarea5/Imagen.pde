public class Imagen{
    private PImage img;
    private PGraphics lienso;
    private int resolucion;
    
    Imagen(PImage img,PGraphics lienso,int resolucion){
      this.img        = img ;
      this.lienso     = lienso;
      this.resolucion = resolucion;
    }
  
  /*
  *Metodo que obtiene el color promedio de un bloque 
  *@param x, posicion en x donde inicia el bloque
  *@param y, posicion en y donde inicia el bloque
  */
  public color getColorBloque(int x, int y){
    float numeroPixeles = resolucion*resolucion;
    float rojo  = 0;
    float verde = 0;
    float azul  = 0;
    for(int j = 0 ; j < resolucion; j++){//y
      for(int i = 0 ; i < resolucion; i++){//x
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
* Metodo que crea imagenes en tono de gris y las guarda en el archivo fotosGris;
*/
 private void arrImagenesGris(){
   for(int j = 0; j < 256;j++){
     PImage imgCopy;
     imgCopy = img;
     for(int i = 0 ; i < img.width*img.height; i++){
          color c1 = img.pixels[i];
          float promedio = min(red(c1),green(c1),blue(c1));
          float c = map(j, 0, 255, 0, 2.5);
          float gris   = c;
          imgCopy.pixels[i] = color(promedio+gris);
      }       
       imgCopy.save("FotosGrises/"+str(j));
   }   
 }
  
 /*
 *Metodo que toma las fotos en grises y acomoda cada foto respecto asu tonalidad en un bloque
 */
 public void mosaicoGris(){
   lienso.beginDraw();
   lienso.background(250);
   arrImagenesGris();
   PImage imgCopy;
   for (int y = 0; y < lienso.height; y += resolucion){
     for (int x = 0; x < lienso.width; x += resolucion){
       color c = getColorBloque(x,y);
       float gris = min(red(c),green(c),blue(c));
       imgCopy=loadImage("FotosGrises/"+int(gris)+".tif");
       lienso.image(imgCopy, x, y,resolucion,resolucion);
      }
     }
   lienso.endDraw();
   image(lienso,0,0,lienso.width,lienso.height);
  for(int i = 0 ; i<256;i++){
    
    String fileName = sketchPath("FotosGrises/"+i+".tif");
    File file = sketchFile(fileName);
    if (file.exists()) { println(i+" Existe"); }
    System.gc(); // the key to succes
    boolean succes = file.delete();
    if (succes) { println(i+" Fue eliminado"); }
    if (!file.exists()) { println(i+" No existe"); }
  }
 } 
  /*
  *Metodo que genera imagenes con una mica de color real y als guarda en FotosColor.
  */
  private void imagenesColor(){
    for (int y = 0; y < lienso.height; y += resolucion){
     for (int x = 0; x < lienso.width; x += resolucion){
       PImage imgCopy = createImage(img.width, img.height, RGB);
       color c = getColorBloque(x,y);
       imgCopy.loadPixels();
       for (int i = 0; i < img.pixels.length; i++) {
           imgCopy.pixels[i] =color (red(c),green(c),blue(c), 20); 
       }
       imgCopy.updatePixels();
       for (int i = 0; i < img.pixels.length; i++) {
           color c1 = img.pixels[i];
           imgCopy.pixels[i] =color (red(c1)*red(c)/255,red(c1)*green(c)/255,red(c1)*blue(c)/255); 
       }
       imgCopy.save("FotosColor/"+hex(c,6));
    }
   }
  }
  
  
  /*
  *Metodo que crea una imagen recursiva con imagenes del color del bloque
  */
  public void mosaicoColor(){
    lienso.beginDraw();
    lienso.background(250);
    ArrayList<String> colores = new ArrayList<String>();
    imagenesColor();
    PImage imgCopy;
    for (int y = 0; y < lienso.height; y += resolucion){
     for (int x = 0; x < lienso.width; x += resolucion){
       img.loadPixels();
       color c = getColorBloque(x,y);
       imgCopy=loadImage("FotosColor/"+hex(c,6)+".tif");
       lienso.image(imgCopy, x, y,resolucion,resolucion);
       colores.add(hex(c,6));
       
    }
   }
    lienso.endDraw();
    image(lienso,0,0,lienso.width,lienso.height);
    for(int i = 0 ; i<colores.size();i++){
      String fileName = sketchPath("FotosColor/"+colores.get(i)+".tif");
      File file = sketchFile(fileName);
      if (file.exists()) { println(colores.get(i) +" Existe"); }
      System.gc(); // the key to succes
      boolean succes = file.delete();
    if (succes) { println(colores.get(i) +" Fue eliminado"); }
    if (!file.exists()) { println(colores.get(i) +"El archivo no existe mas"); }
   }
  }
  
  
  /*
  *Metodo que regresa true si la celda es maximo
  */
  public boolean esMaximo(int y, int x,int dim, boolean maximo){
      int dimension= img.width*img.height;  
      for (int kx = 0; kx < dim; kx++) {
        for (int ky = 0; ky < dim; ky++) {
          // Calculamos la posicion de cada pixel adyacente
          int xloc = x+kx;
          int yloc = y+ky;
          int pos = ((yloc*img.width + xloc)+dimension) % dimension;
          if(maximo){ 
          // Guardamos la suma de RGB de cada pixel adyacente
          if (red(img.pixels[pos])<50){
          return true;
          }
          }
          if(!maximo){
          if (red(img.pixels[pos])>180){
          return true;
          }
          }
        }
      }
      return false;
    }
    
    /*
    *Metodo que pinta la imagen con el mitro macimo o mínimo
    */
    public void pintaImagen(int dim,boolean maximo){
      lienso.beginDraw();
      lienso.background(250);
      img.loadPixels();
      for (int y = 0; y < img.height; y++) {   
       for (int x = 0; x < img.width; x++) {  
         if(maximo){
          if(esMaximo(y,x,dim,true))
            img.pixels[y*img.width + x] = color(0,0,0);
          else{
             img.pixels[y*img.width + x] = color(255,255,255);
           }
          }
         
         if(!maximo){
           if(esMaximo(y,x,dim,false))
              img.pixels[y*img.width + x] = color(255,255,255);
           else{
             img.pixels[y*img.width + x] = color(0,0,0);
           }
         }
        }
       }
       
       img.updatePixels();
       lienso.image(img, 0, 0,img.width,img.height);
       lienso.endDraw();
       image(lienso,0,0,lienso.width,lienso.height);
      }
    
 /*
 *Se ejecuta el filtro maximo
 */
  public void filtroMaximo(){
    int dimension = 5;  
    pintaImagen(dimension,true);
  }
   
  /*
  *Se ejecuta el filtro mínimo
  */
  public void filtroMinimo(){
    int dimension = 5;  
    pintaImagen(dimension,false);
  }
}
