import interfascia.*;
PGraphics lienso;
PImage img;
boolean imageSelected = false; 
String path_imagen="";
GUIController c;
IFLabel l,l1; 
IFTextField t, t1;
IFButton b0,b1,b2,b3,b4,b5,b6;
Imagen imagen; 
  
void setup() {
  PFont mono = createFont("Courier", 20);
  textFont(mono);
  background(250);
  fullScreen();
  int lineaX1=int(width*.83); 
  int lineaX2=int(width*.88); 
  int largo = 100;
  int lineaY1=int(height*.10);
  int lineaY1_5 =int(height*.15);
  int lineaY2=int(height*.17);
  int lineaY3=int(height*.28);
  int lineaY4=int(height*.35);
  int lineaY5=int(height*.45);
  int lineaY6=int(height*.45);
  
  selectInput("Seleccione una imagen:", "fileSelected");
  c = new GUIController(this);
 
  

  b0 = new IFButton("Minimizar imagen", lineaX1, lineaY1,largo);
  l = new IFLabel("% X", lineaX1, lineaY1_5);
  t  = new IFTextField("Ancho",lineaX1,lineaY2);
  l1 = new IFLabel("% Y", lineaX2, lineaY1_5);
  t1  = new IFTextField("Alto",lineaX2,lineaY2);
  
  b1 = new IFButton("Icono 16 x 16", lineaX1, lineaY3,largo);
  b2 = new IFButton("Icono 24 x 24", lineaX2, lineaY3,largo);
  b3 = new IFButton("Icono 32 x 32", lineaX1, lineaY4,largo);
  b4 = new IFButton("Icono 48 x 48", lineaX2, lineaY4,largo);
  b5 = new IFButton("Icono 64 x 64", lineaX1, lineaY5,largo);
  b6 = new IFButton("Original", lineaX1, lineaY6,largo*2);
  
  
  c.add(b0);
  c.add(b1);
  c.add(b2);
  c.add(b3);
  c.add(b4);
  c.add(b5);
  c.add(b6);
  c.add(t);
  c.add(t1);
  c.add(l);
  c.add(l1);
  
  
  b0.addActionListener(this);
  b1.addActionListener(this);
  b2.addActionListener(this);
  b3.addActionListener(this);
  b4.addActionListener(this);
  b5.addActionListener(this);
  b6.addActionListener(this);
  t.addActionListener(this);
  t1.addActionListener(this);
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
    imagen.reduceImagen(t.getValue(),t1.getValue()); 
    imageSelected = false;
  }
    
  
  else if (e.getSource() == b1) {
    background(250);
    if (e.getMessage().equals("Clicked")) {
        imagen.imagenToIcono(16);    
    }
      imageSelected = false;
}
  
 if (e.getSource() == b2) {
    background(250);
    imagen.imagenToIcono(24); 
    imageSelected = false;
}
  
  
  else if (e.getSource() == b3) {
    background(250);
    imagen.imagenToIcono(32); 
    imageSelected = false;
    
  }
  
  else if (e.getSource() == b4) {
    background(250);
    imagen.imagenToIcono(48); 
    imageSelected = false;
    
  }
  
  else if (e.getSource() == b5) {
    background(250);
    imagen.imagenToIcono(64); 
    imageSelected = false;
    
  }
  
  else if (e.getSource() == b6) {
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
