import interfascia.*;
PGraphics lienso;
PImage img;
boolean imageSelected = false; 
String path_imagen="";
GUIController c;
IFLabel l,l1; 
IFTextField t, t1;
IFButton b0,b1;
Imagen imagen; 
  
void setup() {
  PFont mono = createFont("Courier", 20);
  textFont(mono);
  background(250);
  fullScreen();
  int lineaX1=int(width*.83); 
  int largo = 100;
  int lineaY1=int(height*.10);
  int lineaY2=int(height*.15);
  
  selectInput("Seleccione una imagen:", "fileSelected");
  c = new GUIController(this);
  b0 = new IFButton("Ecualizar", lineaX1, lineaY1,largo*2);
  b1 = new IFButton("Original", lineaX1, lineaY2,largo*2);
  
  c.add(b0);
  c.add(b1);
  
  b0.addActionListener(this);
  b1.addActionListener(this); 
}

void draw() {
  if(imageSelected){
    img = loadImage(path_imagen);
    lienso= createGraphics(img.width,img.height,JAVA2D);
    lienso.beginDraw();
    imagen = new Imagen(img, lienso);
    lienso.image(img, 0, 0,img.width,img.height);
    lienso.endDraw();
    image(lienso,0,0,img.width,img.height); 
  } 
}

void actionPerformed(GUIEvent e) {
  
  System.out.println(e.getSource());
  if (e.getSource() == b0) {
    background(250);
    imagen.contraste(256); 
    imageSelected = false;
  }
  
  else if (e.getSource() == b1) {
    background(250);
    imageSelected = true;
    }
  }

void fileSelected(File selection) {
  if (selection == null) {
    println("Programa terminado");
  } else {
    println("Imagen seleccionada " + selection.getAbsolutePath());
    path_imagen  = selection.getAbsolutePath();
    imageSelected = true;
    }
}
