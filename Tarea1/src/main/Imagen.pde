public class Imagen{
  private PImage img;
  private int ancho;
  private int alto;
  private int dimension;
  
  Imagen(PImage img, int ancho, int alto){
  this.img       = img ;
  this.ancho     = ancho;
  this.alto      = alto;
  this.dimension = img.width* img.height;
  }
  
  Imagen(PImage img){
  this.img       = img;
  this.ancho     = 900;
  this.alto      = 500;
  this.dimension = img.width* img.height;
  }
  
  public int getAncho(){return this.ancho;}
  public int getAlto(){return this.alto;}
  public PImage getImagen(){return this.img;}
  //public void setImagen(PImage img){this.img=img;}
  
  
  public void filtroAleatorio(){
    getImagen().loadPixels();
    for(int i = 0 ; i < dimension; i++){
      img.pixels[i] = color(random(256),random(256),random(256));
     }
  }
  
  
  public void filtroGrisPromedio(){
    getImagen().loadPixels();
    for(int i = 0 ; i < dimension; i++){
      color c = img.pixels[i];
      int rojo= (int)red(c);
      int verde= (int)green(c);
      int azul= (int)blue(c);
      int promedio = (rojo+verde+azul)/3;
      img.pixels[i] = color(promedio,promedio,promedio);
     }
  }
  
  public void filtroGrisLuma(){
    getImagen().loadPixels();
    for(int i = 0 ; i < dimension; i++){
      color c = img.pixels[i];
      int rojo= (int)red(c);
      int verde= (int)green(c);
      int azul= (int)blue(c);
      int gris = (int)(rojo * 0.3 + verde * 0.59 + azul * 0.11);
      img.pixels[i] = color(gris,gris,gris);
     }
  }
  
  public void filtroGrisDesaturacion(){
    getImagen().loadPixels();
    for(int i = 0 ; i < dimension; i++){
      color c = img.pixels[i];
      int rojo= (int)red(c);
      int verde= (int)green(c);
      int azul= (int)blue(c);
      int maximo = max(rojo,verde,azul);
      int minimo = min(rojo,verde,azul);
      int gris = (maximo+minimo)/2;
      img.pixels[i] = color(gris,gris,gris);
     }
  }
  
  
  public void filtroGrisMax(){
    getImagen().loadPixels();
    for(int i = 0 ; i < dimension; i++){
      color c = img.pixels[i];
      int rojo= (int)red(c);
      int verde= (int)green(c);
      int azul= (int)blue(c);
      int maximo = max(rojo,verde,azul);
      img.pixels[i] = color(maximo,maximo,maximo);
     }
  }
  
  
  public void filtroGrisMin(){
    getImagen().loadPixels();
    for(int i = 0 ; i < dimension; i++){
      color c = img.pixels[i];
      int rojo= (int)red(c);
      int verde= (int)green(c);
      int azul= (int)blue(c);
      int minimo = max(rojo,verde,azul);
      img.pixels[i] = color(minimo,minimo,minimo);
     }
  }
  
  public void filtroRGB(String RGB){
    getImagen().loadPixels();
    switch(RGB){
        case("R"):
          for(int i = 0 ; i < dimension; i++){
            color c = img.pixels[i];
            img.pixels[i] = color(red(c),0,0);
            }
        break;
        case("G"):
          for(int i = 0 ; i < dimension; i++){
            color c = img.pixels[i];
            img.pixels[i] = color(0,green(c),0);
            }
        break;
        case("B"):
          for(int i = 0 ; i < dimension; i++){
            color c = img.pixels[i];
            img.pixels[i] = color(0,0,blue(c));
            }
        break;
     }
  }
  
  public void filtroAltoContraste(){
    this.filtroGrisPromedio();
     getImagen().loadPixels();
      for(int i = 0 ; i < dimension; i++){
      color c = img.pixels[i];
      if(red(c)>128){
      img.pixels[i] = color(0,0,0);
       }else{
         img.pixels[i] = color(255,255,255);
       }
   
  }
}
    
    
  public void filtroInverso(){
    this.filtroGrisPromedio();
     getImagen().loadPixels();
      for(int i = 0 ; i < dimension; i++){
      color c = img.pixels[i];
      if(red(c)<128){
      img.pixels[i] = color(0,0,0);
       }else{
         img.pixels[i] = color(255,255,255);
       }
   
  }
}
  
  
  
  
  
}
