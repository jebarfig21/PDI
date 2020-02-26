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
  selectInput("Seleccione una imagen:", "fileSelected");
  c = new GUIController(this);
  t = new IFTextField("Text Field", 1000, 500, 200);
  l = new IFLabel("Resolución, Se recomienda un rango 3-15\nDefault=8", 1000, 470);
  t1 = new IFTextField("Text Field", 1000, 600, 200);
  l1 = new IFLabel("Texto(Filtro Texto)", 1000, 580);
  b0 = new IFButton("M con Color", 1000, 100);
  b1 = new IFButton("M en Gris", 1100, 100);
  b2 = new IFButton("Letras Gris", 1000, 160);
  b3 = new IFButton("Letras Color", 1100, 160);
  b4 = new IFButton("Letras ByN", 1000, 220);
  b5 = new IFButton("Texto", 1100, 220);
  b6 = new IFButton("Domino Negro", 1000, 280);
  b7 = new IFButton("Domino Blanco", 1100, 280);
  b8 = new IFButton("Naipes Negro", 1100, 340);
  b9 = new IFButton("Naipes Color", 1000, 340);
  b10 = new IFButton("Original", 1000, 400);
  
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
  image(img, 0, 0,width-400,height);
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
