PImage img;
boolean imageSelected = false; 
String path_imagen="#ffffff";
int clicks=11;
Boton boton0 ;
Boton boton1 ;
Boton boton2 ;
Boton boton3 ;
Boton boton4 ;
Boton boton5 ;
Boton boton6 ;
Boton boton7 ;
Boton boton8 ;
Boton boton9 ;
Boton boton10;
Boton boton11;


void setup() {
  background(240);
  fullScreen();
  selectInput("Seleccione una imagen:", "fileSelected");
  boton0 = new Boton(1000,100,"Azar");
  boton1 = new Boton(1100,100,"Gris Promedio");
  boton2 = new Boton(1000,160,"Gris LUMA");
  boton3 = new Boton(1100,160,"Gris \nDesaturacion");
  boton4 = new Boton(1000,220,"Gris MAX");
  boton5 = new Boton(1100,220,"Gris MIN");
  boton6 = new Boton(1000,280,"Rojo");
  boton7 = new Boton(1100,280,"Azul");
  boton8 = new Boton(1000,340,"Verde");
  boton9 = new Boton(1100,340,"Alto Contraste");
  boton10 = new Boton(1000,400,"Inverso");
  boton11 = new Boton(1100,400,"Original");
   
}
 
void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    path_imagen  = selection.getAbsolutePath();
    imageSelected = true;
    }
}


void draw() {
  if(!imageSelected){
    int a=1;
  }
  else{
    
  img = loadImage(path_imagen);
  Imagen imagen = new Imagen(img, width ,height);
  
  if(clicks==0)imagen.filtroAleatorio();
  if(clicks==1)imagen.filtroGrisPromedio();
  if(clicks==2)imagen.filtroGrisLuma();
  if(clicks==3)imagen.filtroGrisDesaturacion();
  if(clicks==4)imagen.filtroGrisMax();
  if(clicks==5)imagen.filtroGrisMin();
  if(clicks==6)imagen.filtroRGB("R");
  if(clicks==7)imagen.filtroRGB("G");
  if(clicks==8)imagen.filtroRGB("B");
  if(clicks==9)imagen.filtroAltoContraste();  
  if(clicks==10)imagen.filtroInverso();
  if(clicks==11)loadImage(path_imagen); 
  image(img, 0, 0,width-400,height);
  
  }
}

void mousePressed() {
  if(boton0.isInBotonArea(mouseX,mouseY))clicks = 0;
  if(boton1.isInBotonArea(mouseX,mouseY))clicks = 1;
  if(boton2.isInBotonArea(mouseX,mouseY))clicks = 2;
  if(boton3.isInBotonArea(mouseX,mouseY))clicks = 3;
  if(boton4.isInBotonArea(mouseX,mouseY))clicks = 4;
  if(boton5.isInBotonArea(mouseX,mouseY))clicks = 5;
  if(boton6.isInBotonArea(mouseX,mouseY))clicks = 6;
  if(boton7.isInBotonArea(mouseX,mouseY))clicks = 7;
  if(boton8.isInBotonArea(mouseX,mouseY))clicks = 8;
  if(boton9.isInBotonArea(mouseX,mouseY))clicks = 9;
  if(boton10.isInBotonArea(mouseX,mouseY))clicks = 10;
  if(boton11.isInBotonArea(mouseX,mouseY))clicks = 11;
}
