PImage img;
boolean imageSelected = false; 
String path_imagen="#ffffff";
int clicks=-1;
Boton boton1 ;
 
void setup() {
  fullScreen();
  selectInput("Seleccione una imagen:", "fileSelected");
  boton1 = new Boton(1000,300,"Gris promedio");

  fill(222);
  rect(1000, 300, 60, 60);  
  fill(22);  
  text("Gris\npromedio", 1020, 320);
 
  fill(222);
  rect(120, 300, 60, 60); 
  fill(22);  
  text(">", 130, 320);  
 
  fill(222);
  rect(180, 300, 60, 60);  
  fill(22);  
  text("Dn", 190, 320);    
 
  fill(222);
  rect(240, 300, 60, 60);      
  fill(22);  
  text("<", 250, 320);  
   
  
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
  image(img, 0, 0,width-400,height);
}
}

void mousePressed() {
  if(boton1.isInBotonArea(mouseX,mouseY))
  {
    clicks = 0;
  }
  if ((mouseX>120) && (mouseY>300) && (mouseX<180) && (mouseY<360))
  {
    clicks = 1;
  }
  
  if ((mouseX>1000) && (mouseY>300) && (mouseX<1100) && (mouseY<360))
  {
    clicks = 4;
  }
  if ((mouseX>boton1.x) && (mouseY>boton1.y) && (mouseX<boton1.x+boton1.ancho) && (mouseY<boton1.alto))
  {
    clicks = 2;
  }
  
  if ((mouseX>180) && (mouseY>300) && (mouseX<240) && (mouseY<360))  
  {
    clicks = 2;
  }
  if ((mouseX>240) && (mouseY>300) && (mouseX<300) && (mouseY<360)) 
  {
    clicks=3;
  }
  
}
