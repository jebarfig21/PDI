PImage img;
boolean imageSelected = false; 
String path_imagen="#ffffff";
int clicks=7;
Boton boton0, boton1 ,boton2 ,boton3 ;
Boton boton4, boton5 ,boton6 ,boton7 ;


void setup() {
  
  background(245);
  fullScreen();
  selectInput("Seleccione una imagen:", "fileSelected");
  boton0 = new Boton(1000,100,"Blur");
  boton1 = new Boton(1100,100,"Motion Blur");
  boton2 = new Boton(1000,160,"Bordes");
  boton3 = new Boton(1100,160,"Sharpen");
  boton4 = new Boton(1000,220,"Emboss");
  boton5 = new Boton(1100,220,"Promedio");
  boton6 = new Boton(1000,280,"Mediana");
  boton7 = new Boton(1100,280,"Original");
     
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
    Imagen imagen = new Imagen(img, width ,height);
  
    if(clicks==0)imagen.blur();
    if(clicks==1)imagen.motionBlur();
    if(clicks==2)imagen.bordes();
    if(clicks==3)imagen.sharpen();
    if(clicks==4)imagen.emboss();
    if(clicks==5)imagen.promedio();
    /*
    if(clicks==6)imagen.filtroRGB("R");
    */
    if(clicks==7)loadImage(path_imagen); 
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
 }
