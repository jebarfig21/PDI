/*
*@author : José de Jesús Barajas Figueroa
*Programa que hace esteganografia
*/
public class Imagen{
  private PImage img;
  
  Imagen(PImage img){
    this.img        = img ;
    } 
 
  public void encriptar(String texto){
    String[] arregloCadenasBits = stringToArregloBits(texto);  
    int indicePixel = 0;
    img.loadPixels();
    for (int i = 0; i < arregloCadenasBits.length ; i++) {
       for (int j = 0; j < arregloCadenasBits[i].length() ; j++) {
         int byteColor = int(red(img.pixels[indicePixel])); 
         String strByteColor = intToBinario(byteColor);   
         String strNewColor = juntarLetraEnImagen(strByteColor, str(arregloCadenasBits[i].charAt(j)));
         int newColor = binarioToInt(strNewColor);
         img.pixels[indicePixel] = color(newColor,green(img.pixels[indicePixel]),blue(img.pixels[indicePixel]));
         indicePixel++;
       }
    }
    for (int k = 0 ; k <8 ; k++){
       int byteColor = int(red(img.pixels[indicePixel])); 
       String strByteColor = intToBinario(byteColor);   
       String strNewColor = juntarLetraEnImagen(strByteColor,"0");
       int newColor = binarioToInt(strNewColor);
       img.pixels[indicePixel] = color(newColor,green(img.pixels[indicePixel]),blue(img.pixels[indicePixel]));
       indicePixel++;
     }
     
   img.updatePixels();
   println("FINISH");          
 }
 
 /*
 *Metodo para obtener menaje de salida
 */
 public String desencriptar(){
   String mensajeOculto ="";
   String letra ="";
   img.loadPixels();
   int indicePixel = 0;
   for (int i = 0; i < img.pixels.length ; i++) {
       int byteColor = int(red(img.pixels[indicePixel])); 
       String strByteColor = intToBinario(byteColor);   
       letra += obtenerUltimoBit(strByteColor);
       
       if(letra.length()==8){
        if (binarioToInt(letra)==0){
          break;
          }
        else{
          int num_aux = binarioToInt(letra);
          mensajeOculto+=intToAscii(num_aux);
          letra="";
          }
         }
       indicePixel++;
       }
   return mensajeOculto;
 }
 
 
  /*
  *Metodo devuelve un arreglo donde cada elemento representa una letra del mensaje en bits
  ***********100
  */
  private String[] stringToArregloBits(String mensaje){
    int longitud;
    longitud = mensaje.length();
    String[] cadenaBinaria = new String[longitud];
    for(int i=0;i<longitud;i++){
      cadenaBinaria[i]=Integer.toBinaryString(mensaje.charAt(i));
      while(cadenaBinaria[i].length()<8){
       cadenaBinaria[i]="0"+cadenaBinaria[i];
      }
    }
    return cadenaBinaria;
  }
 
  /*
   *
   *Recive una cadena de bits correspondiente a un color de un pixel y un bit de una leta, va a sustituir el valor 
   *del bit menos significativo de byteImagen por el valor de bitTexto
   ("10101100","1") =return 10101101
   ***********100
   */
 
  private String juntarLetraEnImagen(String byteImagen, String bitTexto){
    int bImagen=int(byteImagen);
    int bTexto=int(bitTexto);
    if(byteImagen.charAt(byteImagen.length()-1)!='1')//SI el ultimo bit NO es 1
      bImagen+=bTexto;
    else{//SI el ultimo bit es 1
      if(bTexto==0){
        bImagen-=1;
      }
    }
    String cadenaBits = str(bImagen);  
    while(cadenaBits.length()<8){
       cadenaBits="0"+cadenaBits;
     }
     
    return cadenaBits;
  }
 
  private String intToBinario(int numero){
    String cadenaNum = Integer.toBinaryString(numero);
    while (cadenaNum.length()<8){
     cadenaNum = "0"+cadenaNum;
    }
    
    return cadenaNum; 
 }
 
 
 private int binarioToInt(String newByte){
   return Integer.parseInt(newByte,2); 
 }
 
 private String intToAscii(int num_aux){
   return str((char)num_aux); 
 }
 
 private String obtenerUltimoBit(String cadenaBits){
    return str(cadenaBits.charAt(cadenaBits.length()-1));
     } 

}
