PImage img;

void setup()
{
  size(900, 500);
  img = loadImage("pintura.jpg");
  Imagen imagen = new Imagen(img, img.width ,img.height);
  //imagen.filtroAleatorio();
  //imagen.filtroGrisPromedio();
  //imagen.filtroGrisLuma();
  //imagen.filtroGrisDesaturacion();
  //imagen.filtroGrisMax();
  //imagen.filtroGrisMin();
  //imagen.filtroRGB("R");
  //imagen.filtroRGB("G");
  //imagen.filtroRGB("B");
  //imagen.filtroAltoContraste();  
  imagen.filtroInverso();  
}

void draw() {
image(img, 0, 0);

}
