import java.util.Hashtable;
import java.util.Set;
/*
@author Jesus Barajas
* UNAM, Facultad de Ciencias
* PDI
*Clase que sirve para procesar nuestro directorio de imagenes 
*/
public class FileMngr{
   private PrintWriter output;
   private String fileName;
   private String directory;
   
   /*
   *Constructor de clase
   @param fileName, el nombre que va a tener nuestro archivo donde guardaremos la infromación de las imagenes
   @directory, la ruta del directorio de donde obtendremos las imagenes
   */
   public FileMngr(String fileName,String directory){
     this.fileName   = fileName;
     this.directory  = directory;
     println("Manejador Creado");
   }
  
  /*
  *Metodo para procesar las imagenes y crear un archivo de datos con su información
  @return la ruta del archivo donde hemos guardado esta información
  */
  public String crearArchivo() {
    File file = new File(this.directory);
    output     = createWriter(this.fileName);
    println(sketchPath()+"\\"+fileName);
    String names[] = file.list();
    int start =  millis();
      for(int i = 0 ; i< names.length;i++){
        try {
        String rutaImg = directory+"\\"+names[i];
        int clrImagen = obtenerColorImagen(rutaImg);
        println(rutaImg); 
        output.println(rutaImg+","+clrImagen);
        } catch (Exception e) {
          println("Tienes un archivo incompatible");
        }
      }
      
      output.flush();
      output.close();
      println( (millis()-start)/1000);
      println("segundos");
      println("FINISH");
    return sketchPath()+"\\"+fileName;
  }


  /*
  *Método que obtiene el color promedio(dominante) en la imagen 
  @param rutaImagen : La ruta donde se encuentra la imagen
  @ return Un entero que representa el color que predomina en la imagen
  */
  private int obtenerColorImagen(String rutaImagen){
    PImage imagenActual = loadImage(rutaImagen);
    imagenActual.resize(50,50);
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
    
}
