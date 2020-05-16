import java.util.Hashtable;
import java.util.Set;

public class FileMngr{
   private PrintWriter output;
   private BufferedReader reader;
   private String fileName;
   private String directory;
      
   public FileMngr(String fileName,String directory){
     this.fileName   = fileName;
     this.directory  = directory;
     println("Manejador Creado");
     
   }
  
  public String crearArchivo() {
    File file = new File(this.directory);
    output     = createWriter(this.fileName);
    String names[] = file.list();
      for(int i = 0 ; i< names.length;i++){
        String rutaImg = directory+"/"+names[i];
        int clrImagen = obtenerColorImagen(rutaImg);
        println(rutaImg); 
        output.println(rutaImg+","+clrImagen);
      }
      
      output.flush();
      output.close();
      File salida = new File(this.fileName);
    return salida.getAbsolutePath();
  }


  /*
  *Método que obtiene el color promedio(dominante) en la imagen 
  */
  private int obtenerColorImagen(String rutaImagen){
    PImage imagenActual = img = loadImage(rutaImagen);
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
