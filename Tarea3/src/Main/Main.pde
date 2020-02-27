import interfascia.*;

PImage img;
boolean imageSelected = false; 
String path_imagen="";
IFButton b0, b1 ,b2 ,b3,b9,b10 ;
IFButton b4, b5 ,b6 ,b7,b8 ;

GUIController c;
IFLabel l,l1; 
IFTextField t,t1;
Imagen imagen; 
void setup() {
  PFont mono = createFont("Courier", 20);
  textFont(mono);
  background(250);
  fullScreen();
  int lineaX1=int(width*.83); 
  int lineaX2=lineaX1+100;
  int largo = 100;
  int lineaY1=int(height*.15);
  int lineaY2=int(height*.18);
  int lineaY3=int(height*.21);
  int lineaY4=int(height*.24);
  int lineaY5=int(height*.27);
  int lineaY6=int(height*.30);
  int lineaY7=int(height*.50);
  int lineaY8=int(height*.60);
  
  selectInput("Seleccione una imagen:", "fileSelected");
  c = new GUIController(this);
  t = new IFTextField("Text Field", lineaX1, lineaY7, 200);
  l = new IFLabel("Resolución, Se recomienda un rango 3-15\nDefault=8", lineaX1, lineaY7-30);
  t1 = new IFTextField("Text Field", lineaX1, lineaY8, 200);
  l1 = new IFLabel("Texto(Filtro Texto)", lineaX1, lineaY8-20);
  b0 = new IFButton("M con Color", lineaX1, lineaY1,largo);
  b1 = new IFButton("M en Gris", lineaX2, lineaY1,largo);
  b2 = new IFButton("Letras Gris", lineaX1, lineaY2,largo);
  b3 = new IFButton("Letras Color", lineaX2, lineaY2,largo);
  b4 = new IFButton("Letras ByN", lineaX1, lineaY3,largo);
  b5 = new IFButton("Texto", lineaX2, lineaY3,largo);
  b6 = new IFButton("Domino Negro", lineaX1, lineaY4,largo);
  b7 = new IFButton("Domino Blanco", lineaX2, lineaY4,largo);
  b8 = new IFButton("Naipes Negro", lineaX2, lineaY5,largo);
  b9 = new IFButton("Naipes Color", lineaX1, lineaY5,largo);
  b10 = new IFButton("Original", lineaX1, lineaY6,largo);
  
  c.add(t);
  c.add(l);
  c.add(t1);
  c.add(l1);
  c.add(b0);
  c.add(b1);
  c.add(b2);
  c.add(b3);
  c.add(b4);
  c.add(b5);
  c.add(b6);
  c.add(b7);
  c.add(b8);
  c.add(b9);
  c.add(b10);
  
  t.addActionListener(this);
  b0.addActionListener(this);
  b1.addActionListener(this);
  b2.addActionListener(this);
  b3.addActionListener(this);
  b4.addActionListener(this);
  b5.addActionListener(this);
  b6.addActionListener(this);
  b7.addActionListener(this);
  b8.addActionListener(this);
  b9.addActionListener(this); 
  b9.addActionListener(this);
  b10.addActionListener(this);
 
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

void draw() {
  if(imageSelected){ 
  img = loadImage(path_imagen);
  imagen = new Imagen(img, width ,height);
  image(img, 0, 0,img.width,height);
  } 
}

void actionPerformed(GUIEvent e) {
  
  if (e.getSource() == b0) {
    background(250);
    
    if (e.getMessage().equals("Clicked")) {
        imagen.M_Color(t.getValue()); 
    }
      imageSelected = false;
      //t.setValue("");
    }
  
  else if (e.getSource() == b1) {
    background(250);
        imagen.M_Gris(t.getValue()); 
      imageSelected = false;
}
  
  else if (e.getSource() == b2) {
    background(250);
    imagen.MNSQ_Gris(t.getValue());
    imageSelected = false;
  }
  else if (e.getSource() == b3) {
    background(250);
    imagen.MNSQ_Color(t.getValue());
    imageSelected = false;
  }
  else if (e.getSource() == b4) {
    background(250);
    imagen.MNSQ_ByN(t.getValue());
    imageSelected = false;
  }
  else if (e.getSource() == b5) {
    background(250);
    imagen.texto(t.getValue(),t1.getValue());
    imageSelected = false;
    t1.setValue("");
  }
  else if (e.getSource() == b6) {
    background(250);
    imagen.DominoNegro(t.getValue());
    imageSelected = false;
  }
  else if (e.getSource() == b7) {
    background(250);
    imagen.DominoBlanco(t.getValue());
    imageSelected = false;
  }
  
  else if (e.getSource() == b8) {
    background(250);
    imagen.Naipes(t.getValue());
    imageSelected = false;
  }
  
  else if (e.getSource() == b9) {
    background(250);
    imagen.NaipesColor(t.getValue());
    imageSelected = false;
  }
  else if (e.getSource() == b10) {
    background(250);
    imageSelected = true;
  }
  
}
