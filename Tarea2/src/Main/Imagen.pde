public class Imagen{
    private PImage img;  
    private int ancho;
    private int alto;
    private PImage imgAux;
    private int dimension;
    
    Imagen(PImage img, int ancho, int alto){
    	this.img       = img ;
	    this.ancho     = ancho;
	    this.alto      = alto;
	    this.imgAux = img;
	    this.dimension= img.width*img.height;	
    }
    
    public float[] convolucion(int y, int x,float[][] kernel){
	    imgAux.loadPixels();
	    float[] c = {0,0,0};//Iniciamos el arreglo que guarda el valor R,G,B total 
	    int msize = kernel[0].length; //Tamaño de la matriz
	    for (int kx = 0; kx < msize; kx++) {
	      for (int ky = 0; ky < msize; ky++) {
		    // Calculamos la posicion de cada pixel adyacente
		    int xloc = x+kx;
		    int yloc = y+ky;
		    int pos = ((yloc*img.width + xloc)+dimension) % dimension;
		
		    // Guardamos la suma de RGB de cada pixel adyacente
		    c[0] += kernel[kx][ky] * red(imgAux.pixels[pos]);
		    c[1] += kernel[kx][ky] * green(imgAux.pixels[pos]);
		    c[2] += kernel[kx][ky] * blue(imgAux.pixels[pos]);
	      }
	    }
	    return c;
    }
    
    /*
     *Metodo que le aplica la convolución a cada pixel de la imagen y despues le aplica el filtro
     */
    public void pintaImagen(float factor, float bias, float[][] kernel){
	   for (int y = 0; y < img.height; y++) {   
	     for (int x = 0; x < img.width; x++) {  
		    float[] c = convolucion(y,x,kernel);
		    c[0]= factor * c[0] + bias;
		    c[1]= factor * c[1] + bias;
		    c[2]= factor * c[2] + bias;
		    img.pixels[y*img.width + x] = color(c[0],c[1],c[2]);
	      }
	    }
    }
    
  public void blur(){
	  float factor = 1.0/13.0;
	  float bias = 0.0;
	  float[][] kernel = {{0,0,1,0,0}, 
			                  {0,1,1,1,0},
			                  {1,1,1,1,1},
			                  {0,1,1,1,0},
			                  {0,0,1,0,0}};
	
	  pintaImagen(factor,bias,kernel);
  }
    
  public void motionBlur(){
	  float factor = 1.0 / 9.0;
	  float bias = 0.0;
	  float[][] matriz={{1,0,0,0,0,0,0,0,0},
		              	  {0,1,0,0,0,0,0,0,0},
			                {0,0,1,0,0,0,0,0,0},
			                {0,0,0,1,0,0,0,0,0},
			                {0,0,0,0,1,0,0,0,0},
			                {0,0,0,0,0,1,0,0,0},
			                {0,0,0,0,0,0,1,0,0},
			                {0,0,0,0,0,0,0,1,0},
			                {0,0,0,0,0,0,0,0,1}};
	  pintaImagen(factor,bias,matriz);  
  }
    
  //EDGES  
  public void bordes(){
	  float factor = 1.0;
	  float bias = 0.0;
	  float[][] matriz={{-1, -1, -1, -1, -1},
			                {-1, -1, -1, -1, -1},
			                {-1, -1, 24, -1, -1},
			                {-1, -1, -1, -1, -1},
			                {-1, -1, -1, -1, -1}};
	  pintaImagen(factor,bias,matriz);
  }
    
  public void sharpen(){
	  float factor = 1.0;
	  float bias = 0.0;
	  float[][] matriz={{-1,-1,-1,-1,-1},
		              	  {-1,-1,-1,-1,-1},
			                {-1,-1,25,-1,-1},
			                {-1,-1,-1,-1,-1},
			                {-1,-1,-1,-1,-1}};
	  pintaImagen(factor,bias,matriz);
    }
    
  public void emboss(){
      float factor = 1.0;
      float bias = 128.0;
      float[][] matriz={{-1,-1,-1,-1, 0},
			                  {-1,-1,-1, 0, 1},
			                  {-1,-1, 0, 1, 1},
			                  {-1, 0, 1, 1, 1},
			                  { 0, 1, 1, 1, 1}};
      pintaImagen(factor,bias,matriz);
  }
    
  public void promedio(){
	  float factor = 1.0/9;
	  float bias = 0;
	  float[][] matriz={{1,1,1},
		              	  {1,1,1},
			                {1,1,1}};
	  pintaImagen(factor,bias,matriz);
  }
    
  /*
   *Funciones auxiliares correspondientes a la obtencion del filtro mediana
   */
  public float[][] medianaAux(int y, int x,float[][] kernel){
	  float[][] c = new float[3][9];
	  int msize = kernel[0].length;
	  int it = 0;
	  for (int ky = 0 ; ky < msize; ky++) {
	    for (int kx = 0; kx < msize; kx++) {
		  // Calculamos la posicion de cada pixel adyacente
		  int pos = (y + ky)*img.width + (x + kx);
		  pos = constrain(pos,0,img.pixels.length-1);
		  // Guardamos la suma de RGB de cada pixel adyacente
		  c[0][it] = kernel[ky][kx] * red(img.pixels[pos]);;
		  c[1][it] = kernel[ky][kx] * green(img.pixels[pos]);;
		  c[2][it] = kernel[ky][kx] * blue(img.pixels[pos]);;
		  it++;
	    }
	  }
	  return c;
  }
    
  
  public void pintaMediana(float[][] kernel){
	for (int y = 0; y < img.height; y++) {   
	    for (int x = 0; x < img.width; x++) {  
		float[][] c = medianaAux(y,x,kernel);
		c[0]= sort(c[0]);
		c[1]= sort(c[1]);
		c[2]= sort(c[2]);
		img.pixels[y*img.width + x] = color(c[0][4],c[1][4],c[2][4]);
	    }
	}
    }
    
    public void mediana(){
	float[][] matriz={{1,1,1},
			  {1,1,1},
			  {1,1,1}};
	pintaMediana(matriz);
    }
}
