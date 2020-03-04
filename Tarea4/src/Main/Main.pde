import interfascia.*;

PGraphics lienso;
PImage img;
boolean imageSelected = false; 
String path_imagen="";
int xMouse = 50;
int yMouse = 50;
  
GUIController c;
IFLabel l,l1; 
IFTextField t,t1;
IFButton b0,b1,b2,b3;
IFButton down,up,right,left;

Imagen imagen; 


IFButton currentButton;
  
void setup() {
  PFont mono = createFont("Courier", 20);
  textFont(mono);
  background(250);
  fullScreen();
  int lineaX1=int(width*.83); 
  int lineaX2=lineaX1+100;
  int largo = 100;
  int lineaY1=int(height*.10);
  int lineaY2=int(height*.80);
  int lineaY3=int(height*.70);
  int lineaY7=int(height*.28);
  int lineaY8=int(height*.35);
  int lineaY5=int(height*.40);
  int lineaY6=int(height*.50);
  int lineaY9=int(height*.45);
  
  selectInput("Seleccione una imagen:", "fileSelected");
  c = new GUIController(this);
  t = new IFTextField("Text Field", lineaX1, lineaY7, 200);
  l = new IFLabel("Size, 32 Default", lineaX1, lineaY7-30);
  t1 = new IFTextField("Text Field2", lineaX1, lineaY8, 200);
  l1 = new IFLabel("Texto", lineaX1, lineaY8-20);
  b0 = new IFButton("Poner marca de agua", lineaX1, lineaY1,largo*2);
  b1 = new IFButton("Quitar Marca de agua", lineaX1, lineaY3,largo*2);
  b2 = new IFButton("Guardar", lineaX2, lineaY2,largo);
  b3 = new IFButton("Original", lineaX1, lineaY2,largo);
  
  down =new IFButton("DOWN", lineaX1, lineaY6,largo*2);
  up =new IFButton("UP", lineaX1, lineaY5,largo*2);
  right =new IFButton("RIGHT", lineaX2, lineaY9,largo);
  left =new IFButton("LEFT", lineaX1, lineaY9,largo);
  
  c.add(t);
  c.add(l);
  c.add(t1);
  c.add(l1);
  c.add(b0);
  c.add(b1);
  c.add(b2);
  c.add(b3);
  c.add(down);
  c.add(up);
  c.add(right);
  c.add(left);
  
  t.addActionListener(this);
  b0.addActionListener(this);
  b1.addActionListener(this);
  b2.addActionListener(this);
  b3.addActionListener(this);
  down.addActionListener(this);
  up.addActionListener(this);
  right.addActionListener(this);
  left.addActionListener(this);
  
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
    currentButton = b0;
    background(250);
    imagen.writeOnImage(t1.getValue(),t.getValue(),150,xMouse,yMouse);
    imageSelected = false;
  }
    
  
  else if (e.getSource() == b1) {
    currentButton = b1;
    background(250);
    if (e.getMessage().equals("Clicked")) {
        imagen.quitaMarcaAguaRoja(); 
       
    }
      imageSelected = false;
}
  
  else if (e.getSource() == b2) {
    
    lienso.save("PGallo.jpeg");
    background(250);
    image(lienso,0,0,lienso.width,lienso.height);   
  }
  
  
  else if (e.getSource() == b3) {
    background(250);
    imageSelected = true;
    
  }
  else if (e.getSource() == down && currentButton == b0) {
    background(250);
    yMouse++;
    imagen.writeOnImage(t1.getValue(),t.getValue(),150,xMouse,yMouse);
    imageSelected = false;
    
  }
  else if (e.getSource() == up && currentButton == b0) {
    background(250);
    yMouse--;
    imagen.writeOnImage(t1.getValue(),t.getValue(),150,xMouse,yMouse);
    imageSelected = false;
    
  }
  
  else if (e.getSource() == right && currentButton == b0) {
    background(250);
    xMouse++;
    imagen.writeOnImage(t1.getValue(),t.getValue(),150,xMouse,yMouse);
    imageSelected = false;
    
  }
  
  else if (e.getSource() == left && currentButton == b0) {
    background(250);
    xMouse--;
    imagen.writeOnImage(t1.getValue(),t.getValue(),150,xMouse,yMouse);
    imageSelected = false;
    
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
