import interfascia.*;

int RESOLUCION = 6;


PGraphics lienso;
PImage img;
boolean imageSelected = false; 
String path_imagen="";
GUIController c;
IFLabel l,l1,l2,l3; 
IFTextField t;
IFButton b0,b1,b2,b3,b4;
Imagen imagen; 

IFButton currentButton;
  
void setup() {
  PFont mono = createFont("Courier", 20);
  textFont(mono);
  background(250);
  fullScreen();
  int lineaX1=int(width*.83); 
  int largo = 100;
  int lineaY1=int(height*.10);
  int lineaY2=int(height*.20);
  int lineaY3=int(height*.28);
  int lineaY4=int(height*.35);
  int lineaY5=int(height*.45);
  
  selectInput("Seleccione una imagen:", "fileSelected");
  c = new GUIController(this);
 
  

  b0 = new IFButton("Filtro Maximo", lineaX1, lineaY1,largo*2);
  b1 = new IFButton("Filtro Minimo", lineaX1, lineaY2,largo*2);
  b2 = new IFButton("Mosaico Gris", lineaX1, lineaY3,largo*2);
  b3 = new IFButton("Mosaico Color", lineaX1, lineaY4,largo*2);
  b4 = new IFButton("Original", lineaX1, lineaY5,largo*2);
  
  
  c.add(b0);
  c.add(b1);
  c.add(b2);
  c.add(b3);
  c.add(b4);
  
  
  b0.addActionListener(this);
  b1.addActionListener(this);
  b2.addActionListener(this);
  b3.addActionListener(this);
  b4.addActionListener(this);
  
}

void draw() {
  if(imageSelected){
    img = loadImage(path_imagen);
    lienso= createGraphics(img.width,img.height,JAVA2D);
    lienso.beginDraw();
    imagen = new Imagen(img, lienso, RESOLUCION);
    lienso.image(img, 0, 0,img.width,img.height);
    lienso.endDraw();
    image(lienso,0,0,img.width,img.height); 
  } 
}

void actionPerformed(GUIEvent e) {
  
  System.out.println(e.getSource());
  if (e.getSource() == b0) {
    background(250);
    imagen.filtroMaximo(); 
    imageSelected = false;
  }
    
  
  else if (e.getSource() == b1) {
    currentButton = b1;
    background(250);
    if (e.getMessage().equals("Clicked")) {
        imagen.filtroMinimo();    
    }
      imageSelected = false;
}
  
 if (e.getSource() == b2) {
    background(250);
    imagen.mosaicoGris(); 
    imageSelected = false;
}
  
  
  else if (e.getSource() == b3) {
    background(250);
    imagen.mosaicoColor(); 
    imageSelected = false;
    
  }
  
  else if (e.getSource() == b4) {
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
