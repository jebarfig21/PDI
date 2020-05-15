import controlP5.*;
 
PGraphics lienso,liensoOriginal;
PImage img, imgOriginal;
boolean imageSelected = false; 
String path_imagen="";
String path_directorioImg="";
Imagen imagen; 
FileMngr manejadorDeDatos;

//ControlP5
ControlP5 controlP5;
ListBox listArchivo, listProcesar, listAyuda;
Textarea output;
      
//COLORES
final color naranjaFuerte = color(247, 147, 25);
final color cafeArenaTransparente = color(235, 199, 23,240);
final color fondo = color(250);//Gris-Blanco
final color menuMarcado = color(255, 247, 18);//Color de los botones del menu cuando apsas el menu por encima
final color selecItemMenu = color(110, 73, 0,120);//Color de los item de cada scrollBar del menú cunado los seleccionas

//Medidas
float alturaMenu; 
int separacionListasMenu;
int anchoListasMenu;
int altoListasMenu;

void settings(){
  size(int(displayWidth),int( displayHeight*.92));
}

void setup() {
  PFont mono = createFont("Courier", 20);
  textFont(mono);
  background(fondo);
  alturaMenu = height*.1;
  separacionListasMenu = round(width*.1);
  anchoListasMenu = round(width * .08);
  altoListasMenu = round(height * .3);
  //Menu Cabecera
  
  controlP5 = new ControlP5(this);

  //Añadir elementos de la interfaz gráfica
  listArchivo  = controlP5.addListBox("Archivo", 10, 0 , anchoListasMenu, int(alturaMenu+60))
    .setItemHeight(15)
    .setBarHeight(int(height*.1))
    .addItem("Leer Imagen",0)
    .addItem("Guardar Imagen",1)
    .addItem("Importar Imagenes",2)
    .addItem("Terminar",3)
    .setColorBackground(naranjaFuerte)
    .setColorActive(selecItemMenu)
    .setColorForeground(menuMarcado)
    .setOpen(false);
    
   listProcesar  = controlP5.addListBox("Procesar",  separacionListasMenu, 0 , anchoListasMenu,int(alturaMenu+15))
    .setItemHeight(15)
    .setBarHeight(int(height*.1))
    .addItem("Sepia",0)
    .setColorBackground(naranjaFuerte)
    .setColorActive(selecItemMenu)
    .setColorForeground(menuMarcado)
    .setOpen(false);
    
    listAyuda  = controlP5.addListBox("Ayuda",  separacionListasMenu*2 , 0 , anchoListasMenu, int(alturaMenu+30))
     .setItemHeight(15)
     .setBarHeight(int(height*.1))
     .addItem("Manual",0)
     .addItem("Acerca De",1)
     .setColorBackground(naranjaFuerte)
     .setColorActive(selecItemMenu)
     .setColorForeground(menuMarcado)
     .setOpen(false);
     
     output = controlP5.addTextarea("output") 
     .setColor(color(0)) 
     .setPosition(width*.68,height*.65) 
     .setSize(int(width*.3),int(height*.10)) 
     .setFont(mono);
     
}

void draw() {
  background(250);  
  fill(naranjaFuerte);
  rect(0, 0, width, height*.1);
  float altura = height*.2;
  rect(width*.68,altura, int(width*.27),int(height*.40));
  fill(0);
  text("Imagen Original",width*.68,height*.63);
  noFill();
  
  if(imageSelected){
    img = loadImage(path_imagen);
    imgOriginal = loadImage(path_imagen);
    imagen = new Imagen(img,imgOriginal);
  }
  
  if(imagen!=null){
    lienso= createGraphics(int(width*.52),int(height*.7),JAVA2D);
    lienso.beginDraw();
    lienso.background(255);
    lienso.image(img, 0, 0,lienso.width,lienso.height);
    lienso.endDraw();
    image(lienso,width*.08,altura,lienso.width,lienso.height); 
   
    liensoOriginal = createGraphics(int(width*.23),int(height*.31),JAVA2D);
    liensoOriginal.beginDraw();
    liensoOriginal.background(255);
    liensoOriginal.image(imgOriginal, 0, 0,liensoOriginal.width,liensoOriginal.height);
    liensoOriginal.endDraw();
    image(liensoOriginal,width*.7,height*.25,liensoOriginal.width,liensoOriginal.height); 
   }
   
}
  
void controlEvent(ControlEvent theEvent) {
  if(theEvent.getLabel()=="Archivo"){
     
    if(theEvent.getValue()==0.0)   //Leer Imagen
        selectInput("Seleccione una imagen:", "imageSelected");  
      
    if(theEvent.getValue()==1.0) //Guardar Imagen
      selectOutput("Select a file to write to:", "guardarImagen");
      
    if(theEvent.getValue()==2.0){  //Cargar Texto de un archivo txt
      selectFolder("Seleccione una imagen:", "directorySelected");
      //imagen.listFileNames(path_directorioImg);
    }
    
    if(theEvent.getValue()==3.0){  //Cargar Texto de un archivo txt
      exit();
    }
    
    listArchivo.close();
  }
  
  //MENU PROCESAR//
  if(theEvent.getLabel()=="Procesar"){
    if(theEvent.getValue()==0.0){      
      imageSelected = false;
      imagen.crearMosaico(10);
      output.setText("Imagen Procesada con exito");
    }
  }
    
  //MENU AYUDA//    
  if(theEvent.getLabel()=="Ayuda"){
    if(theEvent.getValue()==0.0){//Mostrar PDF
      launch(dataPath("README.pdf"));
      }
      
    if(theEvent.getValue()==1.0){ //Creditos
      launch("https://www.instagram.com/barajas.tu/");
    }
    
    listAyuda.close();
  }
  
}

/*
*Método para seleccionar una imagen de entrada
*/
void imageSelected(File selection) {
  if (selection == null) {
    println("Programa terminado");
  } else {
    println("Imagen seleccionada " + selection.getAbsolutePath());
    path_imagen  = selection.getAbsolutePath();
    imageSelected = true;
    }
}

/*
*Método para Escoger un directorio
*/
void directorySelected(File selection) {
  if (selection == null) {
    println("Programa terminado");
  } else {
    path_directorioImg = selection.getAbsolutePath();
    manejadorDeDatos =new FileMngr("datos",path_directorioImg);
    manejadorDeDatos.crearArchivo();
    }
}

/*
*Método para guardar la imagen actual del programa en el archivo selection
*/
void guardarImagen(File selection) {
  if (selection == null) {
    println("El usuario no selecciono nigun archivo o cerró la ventana");
  } else {
    println("El usuario sleecciono el siguiente archivo para guardar la imagen" + selection.getAbsolutePath());
    img.save(selection.getAbsolutePath()+".bmp");
    output.setText("Imagen guardada con exito");
  }
}
