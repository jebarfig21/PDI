public class Imagen{
  private PImage img;  
  private int ancho;
  private int alto;
  private int dimension;
  
  Imagen(PImage img, int ancho, int alto){
  this.img       = img ;
  this.ancho     = ancho;
  this.alto      = alto;
  this.dimension = img.width * img.height;
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
    
  public float[] convolucion(int y, int x,float[][] kernel){
      float[] c = new float[3];
      int offset = kernel[0].length/2;
      c[0] = 0; // La suma del color rojo
      c[1] = 0; // La suma del color verde
      c[2] = 0; // La suma del color azul
      
      for (int ky = (-1)*offset; ky <= offset; ky++) {
        for (int kx = (-1)*offset; kx <= offset; kx++) {
          // Calculamos la posicion de cada pixel adyacente
          int pos = (y + ky)*img.width + (x + kx);
          pos = constrain(pos,0,img.pixels.length-1);
          // Multiply adjacent pixels based on the kernel values
          c[0] += kernel[ky+offset][kx+offset] * red(img.pixels[pos]);;
          c[1] += kernel[ky+offset][kx+offset] * green(img.pixels[pos]);;
          c[2] += kernel[ky+offset][kx+offset] * blue(img.pixels[pos]);;
        }
      }
      return c;
}

public void blur(){
  float factor = 1.0/13.0;
  float bias = 0.0;
  /*float[][] kernel = {{ 0, .2, 0 }, 
                      { .2, .2, .2 }, 
                      { 0, .2, 0 }};
    */
    float[][] kernel = {{0,0,1,0,0}, 
                        {0,1,1,1,0},
                        {1,1,1,1,1},
                        {0,1,1,1,0},
                        {0,0,1,0,0}};
    
  //img.loadPixels();
  int offset = kernel[0].length;
  // Create an opaque image of the same size as the original
  // Loop through every pixel in the image
  for (int y = offset; y < img.height-offset; y++) {   // Skip top and bottom edges
    for (int x = offset; x < img.width-offset; x++) {  // Skip left and right edges
      float[] c = convolucion(y,x,kernel);
      c[0]= factor * c[0] + bias;
      c[1]= factor * c[1] + bias;
      c[2]= factor * c[2] + bias;
      img.pixels[y*img.width + x] = color(c[0],c[1],c[2]);
    }
  }
  
  // State that there are changes to edgeImg.pixels[]
  //img.updatePixels();
 
 }
 
public void motionBlur(){
 float factor = 1.0 / 9.0;
 float bias = 0.0;
  float[][] matriz={
  {1,0,0,0,0,0,0,0,0},
  {0,1,0,0,0,0,0,0,0},
  {0,0,1,0,0,0,0,0,0},
  {0,0,0,1,0,0,0,0,0},
  {0,0,0,0,1,0,0,0,0},
  {0,0,0,0,0,1,0,0,0},
  {0,0,0,0,0,0,1,0,0},
  {0,0,0,0,0,0,0,1,0},
  {0,0,0,0,0,0,0,0,1}};
  
  getImagen().loadPixels();
  int offset = matriz[0].length;
  // Create an opaque image of the same size as the original
  // Loop through every pixel in the image
  for (int y = offset; y < img.height-offset; y++) {   // Skip top and bottom edges
    for (int x = offset; x < img.width-offset; x++) {  // Skip left and right edges
      float[] c = convolucion(y,x,matriz);
      c[0]= factor * c[0] + bias;
      c[1]= factor * c[1] + bias;
      c[2]= factor * c[2] + bias;
      img.pixels[y*img.width + x] = color(c[0],c[1],c[2]);
    }
  }
  
 img.updatePixels();

}


public void bordes(){
  
float factor = 1.0;
float bias = 0.0;
float[][] matriz={
   {-1,  0,  0,  0,  0},
   {0,  -2,  0,  0,  0},
   {0,   0,  6,  0,  0},
   {0,   0,  0, -2,  0},
   {0,   0,  0,  0, -1},
  
};

  getImagen().loadPixels();
  int offset = matriz[0].length;
  // Create an opaque image of the same size as the original
  // Loop through every pixel in the image
  for (int y = offset; y < img.height-offset; y++) {   // Skip top and bottom edges
    for (int x = offset; x < img.width-offset; x++) {  // Skip left and right edges
      float[] c = convolucion(y,x,matriz);
      c[0]= factor * c[0] + bias;
      c[1]= factor * c[1] + bias;
      c[2]= factor * c[2] + bias;
      img.pixels[y*img.width + x] = color(c[0],c[1],c[2]);
    }
  }
  
  
}

public void sharpen(){
  
  float factor = 1.0;
  float bias = 0.0;
  float[][] matriz={
  {1, 1, 1},
  {1,-7, 1},
  {1, 1, 1}};

  getImagen().loadPixels();
  int offset = matriz[0].length;
  // Create an opaque image of the same size as the original
  // Loop through every pixel in the image
  for (int y = offset; y < img.height-offset; y++) {   // Skip top and bottom edges
    for (int x = offset; x < img.width-offset; x++) {  // Skip left and right edges
      float[] c = convolucion(y,x,matriz);
      c[0]= factor * c[0] + bias;
      c[1]= factor * c[1] + bias;
      c[2]= factor * c[2] + bias;
      img.pixels[y*img.width + x] = color(c[0],c[1],c[2]);
    }
  }   
 img.updatePixels();
}

public void emboss(){
  float factor = 1.0;
  float bias = 0.0;
  
  float[][] matriz={
  {-1,-1,-1,-1, 0},
  {-1,-1,-1, 0, 1},
  {-1,-1, 0, 1, 1},
  {-1, 0, 1, 1, 1},
  { 0, 1, 1, 1, 1}};

  int offset = matriz[0].length;
  getImagen().loadPixels();
  
  for (int y = offset; y < img.height-offset; y++) {   // Skip top and bottom edges
    for (int x = offset; x < img.width-offset; x++) {  // Skip left and right edges
      float[] c = convolucion(y,x,matriz);
      c[0]= factor * c[0] + bias;
      c[1]= factor * c[1] + bias;
      c[2]= factor * c[2] + bias;
      img.pixels[y*img.width + x] = color(c[0],c[1],c[2]);
    }
  }
 img.updatePixels();
}



public void promedio(){
  float factor = 1.0/9;
  float bias = 0;
  
  float[][] matriz={
  {1,1, 1},
  {1, 1, 1},
  {1, 1, 1}};

  int offset = matriz[0].length;
  getImagen().loadPixels();
  
  for (int y = offset; y < img.height-offset; y++) {   // Skip top and bottom edges
    for (int x = offset; x < img.width-offset; x++) {  // Skip left and right edges
      float[] c = convolucion(y,x,matriz);
      c[0]= factor * c[0] + bias;
      c[1]= factor * c[1] + bias;
      c[2]= factor * c[2] + bias;
      img.pixels[y*img.width + x] = color(c[0],c[1],c[2]);
    }
  }
 img.updatePixels();
}


/*

public void mediana(){
}

 */  
}
