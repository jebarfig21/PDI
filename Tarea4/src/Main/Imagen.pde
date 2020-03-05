public class Imagen{
    private PImage img;
    private PGraphics lienso;
    

    Imagen(PImage img,PGraphics lienso){
      this.img    = img ;
      this.lienso = lienso;
    }
    
/*
*
* Metodo que regresa el color promedio de un rectangulo de pixeles, el rectangulo ocupa "j" pixeles de ancho
* y "j" pixeles de alto
*
*/

/*
  public void writeOnImage(String txt, int tamText){
  PFont mono = createFont("Courier", tamText);
   textFont(mono);
   img.loadPixels();
   lienso.text(txt,100,100);
  
    
    
  }*/
  
  public void writeOnImage(String txt, int tamText,float alpha,int x ,int y){
    background(250);
   
    PFont mono = createFont("Courier", tamText);
    textFont(mono);
    lienso.beginDraw();
    lienso.background(250);
    lienso.textFont(mono,tamText);
    String letters = "PROCESO DIGITAL DE IMAGENES";
    if(txt!=""){
    letters = txt;}
    img.updatePixels();
    lienso.image(img, 0, 0,lienso.width,lienso.height);
    lienso.fill(255,255,255,alpha);
    lienso.text(letters,x,y);
    lienso.endDraw();
    image(lienso,0,0,lienso.width,lienso.height);
    
  }
  
  public void quitaMarcaAguaRoja(){
    background(250);
    lienso.beginDraw();
    lienso.background(250);
    img.loadPixels();
    for(int i = 0 ; i < img.width*img.height; i++){
            color c = img.pixels[i];
            int gris = (int)(blue(c)+blue(c)+green(c))/3;
            
              
            if(red(c)>blue(c)+5 ){
              if(gris<171){
                 img.pixels[i]=color(blue(c),blue(c),green(c));
                }else{
                  img.pixels[i]=color(255,255,255);
                 }
              }
              else{
                if(red(c)!=blue(c))
                  System.out.println(red(c)+" "+blue(c));
              }
    }
    
    img.updatePixels();
    lienso.image(img, 0, 0,img.width,img.height);
    lienso.endDraw();
    image(lienso,0,0,lienso.width,lienso.height);
    
    }
  }  
