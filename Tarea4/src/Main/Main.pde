import interfascia.*;

PGraphics lienso;
PImage img;
boolean imageSelected = false; 
String path_imagen="";
int xMouse = 50;
int yMouse = 50;
int alpha = 100;
int tamTxt = 32;
GUIController c;
IFLabel l,l1,l2,l3; 
IFTextField t;
IFButton b0,b1,b2,b3;
IFButton down,up,right,left;
IFButton plus,minus;
IFButton plusSize,minusSize;

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
  int lineaY2=int(height*.20);
  int lineaY3=int(height*.28);
  int lineaY4=int(height*.35);
  int lineaY5=int(height*.45);
  int lineaY6=int(height*.50);
  int lineaY7=int(height*.55);
  int lineaY8=int(height*.70);
  int lineaY9=int(height*.80);
  
  selectInput("Seleccione una imagen:", "fileSelected");
  c = new GUIController(this);
 
  b0 = new IFButton("Poner marca de agua", lineaX1, lineaY1,largo*2);
  
  l1 = new IFLabel("Texto", lineaX1, lineaY2-20);
  t = new IFTextField("TextoMarcaDEAgua", lineaX1, lineaY2, 200);
  
  l = new IFLabel("Size, 32 Default", lineaX1, lineaY3-20);
  minusSize =new IFButton("-", lineaX1, lineaY3,largo);
  plusSize =new IFButton("+", lineaX2, lineaY3,largo);
  
  l2 = new IFLabel("Alpha", lineaX1, lineaY4-20);
  minus =new IFButton("-", lineaX1, lineaY4,largo);
  plus =new IFButton("+", lineaX2, lineaY4,largo);
  
  
  l3 = new IFLabel("Posicion", lineaX1, lineaY5-20);
  up =new IFButton("UP", lineaX1, lineaY5,largo*2);
  right =new IFButton("RIGHT", lineaX2, lineaY6,largo);
  left =new IFButton("LEFT", lineaX1, lineaY6,largo);
  down =new IFButton("DOWN", lineaX1, lineaY7,largo*2);
  
  b1 = new IFButton("Quitar Marca de agua", lineaX1, lineaY8,largo*2);
  b2 = new IFButton("Guardar", lineaX2, lineaY9,largo);
  b3 = new IFButton("Original", lineaX1, lineaY9,largo);
  
  
  c.add(t);
  c.add(l);
  c.add(l1);
  c.add(l2);
  c.add(l3);
  c.add(b0);
  c.add(b1);
  c.add(b2);
  c.add(b3);
  c.add(down);
  c.add(up);
  c.add(right);
  c.add(left);
  c.add(plus);
  c.add(minus);
  c.add(plusSize);
  c.add(minusSize);
  
  t.addActionListener(this);
  b0.addActionListener(this);
  b1.addActionListener(this);
  b2.addActionListener(this);
  b3.addActionListener(this);
  down.addActionListener(this);
  up.addActionListener(this);
  right.addActionListener(this);
  left.addActionListener(this);
  
  plus.addActionListener(this);
  minus.addActionListener(this);
  
  
  plusSize.addActionListener(this);
  minusSize.addActionListener(this);
  
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
    imagen.writeOnImage(t.getValue(),tamTxt,alpha,xMouse,yMouse);
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
    yMouse+=5;
    imagen.writeOnImage(t.getValue(),tamTxt,alpha,xMouse,yMouse);
    imageSelected = false;
    
  }
  else if (e.getSource() == up && currentButton == b0) {
    background(250);
    yMouse-=5;
    imagen.writeOnImage(t.getValue(),tamTxt,alpha,xMouse,yMouse);
    imageSelected = false;
    
  }
  
  else if (e.getSource() == right && currentButton == b0) {
    background(250);
    xMouse+=5;
    imagen.writeOnImage(t.getValue(),tamTxt,alpha,xMouse,yMouse);
    imageSelected = false;
    
  }
  
  else if (e.getSource() == left && currentButton == b0) {
    background(250);
    xMouse-=5;
    imagen.writeOnImage(t.getValue(),tamTxt,alpha,xMouse,yMouse);
    imageSelected = false;
    
  }
  

  else if (e.getSource() == minus && currentButton == b0) {
    background(250);
    alpha-=5;
    imagen.writeOnImage(t.getValue(),tamTxt,alpha,xMouse,yMouse);
    imageSelected = false;
    
  }
  
  else if (e.getSource() == plus && currentButton == b0) {
    background(250);
    alpha+=5;
    imagen.writeOnImage(t.getValue(),tamTxt,alpha,xMouse,yMouse);
    imageSelected = false;
    
  }
  
  else if (e.getSource() == plusSize && currentButton == b0) {
    background(250);
    tamTxt++;
    imagen.writeOnImage(t.getValue(),tamTxt,alpha,xMouse,yMouse);
    imageSelected = false;
    
  }
  
  else if (e.getSource() == minusSize && currentButton == b0) {
    background(250);
    tamTxt--;
    imagen.writeOnImage(t.getValue(),tamTxt,alpha,xMouse,yMouse);
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
