public class Imagen{
    private PImage img;  
    private int ancho;
    private int alto;
    private int resolucion;
    private char[] ascii;

    Imagen(PImage img, int ancho, int alto){
      this.img       = img ;
      this.ancho     = ancho;
      this.alto      = alto;
      this.resolucion= 8;
      this.ascii = new char[256];
    }
    
/*
*
* Metodo que regresa el color promedio de un rectangulo de pixeles, el rectangulo ocupa "j" pixeles de ancho
* y "j" pixeles de alto
*
*/


  public color getColorBloque(int x, int y){
    float numeroPixeles = resolucion*resolucion;
    float rojo  = 0;
    float verde = 0;
    float azul  = 0;
    for(int j = 0 ; j < resolucion; j++){//y
      for(int i = 0 ; i < resolucion; i++){//x
       //System.out.println(y+" "+x);
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

  public void M_Color(String string_res){
   int resolucion;
   if(string_res!=""){
     resolucion = int(string_res);}
   else{resolucion=this.resolucion;}
   if(resolucion == 0)resolucion=this.resolucion;
  
   PFont mono = createFont("Courier", resolucion+2);
   textFont(mono);
   img.loadPixels();
   for (int y = 0; y < img.height; y += resolucion) {
    for (int x = 0; x < img.width; x += resolucion) {
      color colorSeccion = getColorBloque(x,y);
      fill(colorSeccion);
      text("M", x, y);
    }
   }
  }
  
  
  public void M_Gris(String string_res){
   int resolucion;
   if(string_res!=""){
   resolucion = int(string_res);}
  
   else{resolucion=this.resolucion;}
   if(resolucion == 0)resolucion=this.resolucion;
  
   PFont mono = createFont("Courier", resolucion + 2);
   textFont(mono);
   img.loadPixels();
  for (int y = 0; y < img.height; y += resolucion) {
      for (int x = 0; x < img.width; x += resolucion) {
      //System.out.println(x+" " + " " + y + " "+ x*y );
      color colorSeccion = getColorBloque(x,y);
      float gris = (red(colorSeccion)+green(colorSeccion)+blue(colorSeccion))/3;
      fill(gris);
     text("M", x, y);
      }
  }
}
  
  public void MNSQ_Gris(String string_res){
    int resolucion;
    if(string_res!=""){
    resolucion = int(string_res);}
    else{resolucion=this.resolucion;}
    if(resolucion == 0)resolucion=this.resolucion;
    PFont mono = createFont("Courier", resolucion + 2);
    textFont(mono);
    String letters = "MNH#QUAD0Y2$%;. ";
    for (int i = 0; i < 256; i++) {
      int index = int(map(i, 0, 256, 0, letters.length()));
      ascii[i] = letters.charAt(index);
      }
     img.loadPixels();
     for (int y = 0; y < img.height; y += resolucion) {
      for (int x = 0; x < img.width; x += resolucion) {
      //System.out.println(x+" " + " " + y + " "+ x*y );
      color colorSeccion = getColorBloque(x,y);
      float gris = (red(colorSeccion)+green(colorSeccion)+blue(colorSeccion))/3;
      fill(gris);
      text(ascii[(int)gris], x, y);
      }
    } 
  }
    public void MNSQ_Color(String string_res){
      int resolucion;
      if(string_res!=""){
        resolucion = int(string_res);}
      else{resolucion=this.resolucion;}
     if(resolucion == 0)resolucion=this.resolucion;
  
    PFont mono = createFont("Courier", resolucion + 2);
    textFont(mono);
    String letters = "MNH#QUAD0Y2$%;. ";
    for (int i = 0; i < 256; i++) {
      int index = int(map(i, 0, 256, 0, letters.length()));
      ascii[i] = letters.charAt(index);
      }
     img.loadPixels();
     for (int y = 0; y < img.height; y += resolucion) {
      for (int x = 0; x < img.width; x += resolucion) {
      //System.out.println(x+" " + " " + y + " "+ x*y );
      color colorSeccion = getColorBloque(x,y);
      float gris = (red(colorSeccion)+green(colorSeccion)+blue(colorSeccion))/3;
      fill(colorSeccion);
      text(ascii[(int)gris], x, y);
        
    }
    }   
  }

  public void MNSQ_ByN(String string_res){
    int resolucion;
      if(string_res!=""){
        resolucion = int(string_res);}
  
      else{resolucion=this.resolucion;}
   if(resolucion == 0)resolucion=this.resolucion;
  
    PFont mono = createFont("Courier", resolucion + 2);
    textFont(mono);
    String letters = "MNH#QUAD0Y2$%;. ";
    for (int i = 0; i < 256; i++) {
      int index = int(map(i, 0, 256, 0, letters.length()));
      ascii[i] = letters.charAt(index);
      }
     img.loadPixels();
     for (int y = 0; y < img.height; y += resolucion) {
      for (int x = 0; x < img.width; x += resolucion) {
      //System.out.println(x+" " + " " + y + " "+ x*y );
      color colorSeccion = getColorBloque(x,y);
      float gris = (red(colorSeccion)+green(colorSeccion)+blue(colorSeccion))/3;
      fill(0);
      text(ascii[(int)gris], x, y);
        
    }
    }
  }

public void texto(String string_res,String txt){
  txt=txt.replace(" ","");
  int resolucion;
  if(string_res!=""){
    resolucion = int(string_res);}
  else{
  resolucion=this.resolucion;}
  String letters = "PROCESODIGITALDEIMAGEES";
  if(resolucion == 0)resolucion=this.resolucion;
  if(txt!=""){
    letters = txt;}
    
   int aux = 0;
   img.loadPixels();
   PFont mono = createFont("Courier", resolucion + 2);
   textFont(mono);
   for (int y = 0; y < img.height; y += resolucion){
    for (int x = 0; x < img.width; x += resolucion){
      color colorSeccion = getColorBloque(x,y);
      fill(colorSeccion);
      text(letters.charAt(aux % letters.length()), x, y);
      aux++;
      }
    }
  }
 
  
  public void DominoNegro(String string_res){
     int resolucion;
     if(string_res!=""){
      resolucion = int(string_res);}
     else{resolucion=this.resolucion;}
     if(resolucion == 0)resolucion=this.resolucion;
      PFont mono = createFont("lasvbld_.TTF", resolucion + 2);
      textFont(mono);
      //String letters = "lkjihXWURQOLFEDCHBA";  
      String letters = "0123456";
    
    for (int i = 0; i < 256; i++) {
      int index = int(map(i, 0, 256, 0, letters.length()));
      ascii[i] = letters.charAt(index);
      }
     img.loadPixels();
     for (int y = 0; y < img.height; y += resolucion) {
      for (int x = 0; x < img.width; x += resolucion) {
      //System.out.println(x+" " + " " + y + " "+ x*y );
      color colorSeccion = getColorBloque(x,y);
      float gris = (red(colorSeccion)+green(colorSeccion)+blue(colorSeccion))/3;
      fill(0);
      text(ascii[(int)gris], x, y);
        
    }
    }
  }
  
  public void DominoBlanco(String string_res){
    int resolucion;
     if(string_res!=""){
       resolucion = int(string_res);}
       else{resolucion=this.resolucion;}
      if(resolucion == 0)resolucion=this.resolucion;
  
    PFont mono = createFont("lasvwd__.TTF", resolucion + 2);
      textFont(mono);  
     String letters = "654321";
    for (int i = 0; i < 256; i++) {
      int index = int(map(i, 0, 256, 0, letters.length()));
      ascii[i] = letters.charAt(index);
      }
     img.loadPixels();
     for (int y = 0; y < img.height; y += resolucion) {
      for (int x = 0; x < img.width; x += resolucion) {
      //System.out.println(x+" " + " " + y + " "+ x*y );
      color colorSeccion = getColorBloque(x,y);
      float gris = (red(colorSeccion)+green(colorSeccion)+blue(colorSeccion))/3;
      fill(0);
      text(ascii[(int)gris], x, y);
        
    }
    }
  }
  
    public void Naipes(String string_res){
     int resolucion;
     if(string_res!=""){
       resolucion = int(string_res);}
  
     else{resolucion=this.resolucion;}
if(resolucion == 0)resolucion=this.resolucion;
       
      PFont mono = createFont("Playcrds.TTF", resolucion + 2);
      textFont(mono);
     String letters = "MLKJIHGFEDCBA";
    for (int i = 0; i < 256; i++) {
      int index = int(map(i, 0, 256, 0, letters.length()));
      ascii[i] = letters.charAt(index);
      }
     img.loadPixels();
     for (int y = 0; y < img.height; y += resolucion) {
      for (int x = 0; x < img.width; x += resolucion) {
      //System.out.println(x+" " + " " + y + " "+ x*y );
      color colorSeccion = getColorBloque(x,y);
      float gris = (red(colorSeccion)+green(colorSeccion)+blue(colorSeccion))/3;
      fill(0);
      text(ascii[(int)gris], x, y);
        
    }
    }
  }

   public void NaipesColor(String string_res){
     int resolucion;
     if(string_res!=""){
     resolucion = int(string_res);}
  
     else{resolucion=this.resolucion;}
     if(resolucion == 0)resolucion=this.resolucion;
  
      PFont mono = createFont("Playcrds.TTF", resolucion + 2);
      textFont(mono);
     String letters = "MLKJIHGFEDCBA";
    for (int i = 0; i < 256; i++) {
      int index = int(map(i, 0, 256, 0, letters.length()));
      ascii[i] = letters.charAt(index);
      }
     img.loadPixels();
     for (int y = 0; y < img.height; y += resolucion) {
      for (int x = 0; x < img.width; x += resolucion) {
        color colorSeccion = getColorBloque(x,y);
        float gris = (red(colorSeccion)+green(colorSeccion)+blue(colorSeccion))/3;
        fill(colorSeccion);
        text(ascii[(int)gris], x, y);
      }
    }
  }

      
  
  color filtroGris(color clr){
  return color(red(clr)+green(clr)+blue(clr))/3;
  }
}
