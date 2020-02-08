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
  
  
color convolucion(int x, int y, float[][] matriz, int matrizsize)
{
  float rojo = 0.0;
  float verde = 0.0;
  float azul = 0.0;
  int offset = matrizsize / 2;
  
  for (int i = 0; i < matrizsize; i++){
    for (int j= 0; j < matrizsize; j++){
      int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + this.ancho*yloc;//Ubicación en el arreglo de pixeles
      
      // Make sure we haven't walked off our image, we could do better here
      loc = constrain(loc,0,img.pixels.length-1);
      // Calculate the convolution
      rojo += (red(img.pixels[loc]) * matriz[i][j]);
      verde += (green(img.pixels[loc]) * matriz[i][j]);
      azul += (blue(img.pixels[loc]) * matriz[i][j]);
    }
  }
  // Make sure RGB is within range
  rojo = constrain(rojo, 0, 255);
  verde = constrain(verde, 0, 255);
  azul = constrain(azul, 0, 255);
  // Return the resulting color
  return color(rojo, verde, azul);
}

public void blur(){
  /*
  float[][] matriz={{0.0, 0.2, 0.0},
                    {0.2, 0.2, 0.2},
                    {0.0, 0.2, 0.0}};
                    */
 float[][] matriz={
  {0.0, 0.0, 1.0, 0.0, 0.0},
  {0.0, 1.0, 1.0, 1.0, 1.0},
  {1.0, 1.0, 1.0, 1.0, 1.0},
  {0.0, 1.0, 1.0, 1.0, 0.0},
  {0.0, 0.0, 1.0, 0.0, 0.0}
};

  int tam=matriz[0].length;
  getImagen().loadPixels();
  
  for (int i = 0; i < ancho; i++){//x
    for (int j= 0; j < alto; j++){//y
      color c = convolucion(i, j, matriz, tam);
      int indices = i*j+ancho;
      indices = constrain(indices,0,dimension-1);
      img.pixels[indices] = c;
     }
  }
 img.updatePixels();
}


public void motionBlur(){
 float[][] matriz={
  {1.0,0.0,0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
  {0.0,1.0,0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
  {0.0,0.0,1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
  {0.0,0.0,0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0},
  {0.0,0.0,0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0},
  {0.0,0.0,0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0},
  {0.0,0.0,0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0},
  {0.0,0.0,0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0},
  {0.0,0.0,0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0},
  
};

  int tam=matriz[0].length;
  getImagen().loadPixels();
  
  for (int i = 0; i < ancho; i++){//x
    for (int j= 0; j < alto; j++){//y
      color c = convolucion(i, j, matriz, tam);
      int indices = i*j+ancho;
      indices = constrain(indices,0,dimension-1);
      img.pixels[indices] = c;
     }
  }
 img.updatePixels();

}

public void bordes(){
float[][] matriz={
   {0,  0, -1,  0,  0},
   {0,  0, -1,  0,  0},
   {0,  0,  2,  0,  0},
   {0,  0,  0,  0,  0},
   {0,  0,  0,  0,  0},
  
};

  int tam=matriz[0].length;
  getImagen().loadPixels();
  
  for (int i = 0; i < ancho; i++){//x
    for (int j= 0; j < alto; j++){//y
      color c = convolucion(i, j, matriz, tam);
      int indices = i*j+ancho;
      indices = constrain(indices,0,dimension-1);
      img.pixels[indices] = c;
     }
  }
 img.updatePixels();

}


public void sharpen(){
  float[][] matriz={
  {-1, -1, -1},
  {-1,  9, -1},
  {-1, -1, -1}};

  int tam=matriz[0].length;
  getImagen().loadPixels();
  
  for (int i = 0; i < ancho; i++){//x
    for (int j= 0; j < alto; j++){//y
      color c = convolucion(i, j, matriz, tam);
      int indices = i*j+ancho;
      indices = constrain(indices,0,dimension-1);
      img.pixels[indices] = c;
     }
  }
 img.updatePixels();
}

public void emboss(){
  float[][] matriz={
  {-1, -1, 0},
  {-1,  0, 1},
  {0 ,   1, 1}};

  int tam=matriz[0].length;
  getImagen().loadPixels();
  
  for (int i = 0; i < ancho; i++){//x
    for (int j= 0; j < alto; j++){//y
      color c = convolucion(i, j, matriz, tam);
      int indices = i*j+ancho;
      indices = constrain(indices,0,dimension-1);
      img.pixels[indices] = c;
     }
  }
 img.updatePixels();
}

}
/*
public void promedio(){
}


public void mediana(){
}

 */  
