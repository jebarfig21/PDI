/*
@author Jesus Barajas
* UNAM, Facultad de Ciencias
* PDI
*Clase principal para el programa Mosaico
*/ 

import controlP5.*;
PGraphics lienso,liensoOriginal;
PImage img, imgOriginal;
boolean imageSelected = false; 
boolean working =false;
String path_imagen="";
String path_directorioImg="";
String path_datos="";
Imagen imagen; 
FileMngr manejadorDeDatos;

//ControlP5
ControlP5 controlP5;
ListBox listArchivo, listProcesar, listAyuda;
Textarea output;
boolean booleanDistancia=false;
int slider = 10;
      
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
  listArchivo  = controlP5.addListBox("Archivo", 10, 0 , anchoListasMenu, int(alturaMenu+75))
    .setItemHeight(15)
    .setBarHeight(int(height*.1))
    .addItem("Leer Imagen",0)
    .addItem("Guardar Imagen",1)
    .addItem("Importar Imagenes",2)
    .addItem("Leer Archivo",3)
    .addItem("Terminar",4)
    .setColorBackground(naranjaFuerte)
    .setColorActive(selecItemMenu)
    .setColorForeground(menuMarcado)
    .setOpen(false);
    
   listProcesar  = controlP5.addListBox("Procesar",  separacionListasMenu, 0 , anchoListasMenu,int(alturaMenu+30))
    .setItemHeight(15)
    .setBarHeight(int(height*.1))
    .addItem("Mosaico",0)
    .addItem("Imagen Original",1)
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
     
      controlP5.addSlider("slider")
   .setPosition(width*.3, alturaMenu*.1)
   .setSize(int(width*.6), 40)
   .setRange(0,100)
   .setColorForeground(menuMarcado)
   .setColorBackground(selecItemMenu)
   .setColorActive(color(120,58,98));
   
     output = controlP5.addTextarea("output") 
     .setColor(color(0)) 
     .setPosition(width*.68,height*.65) 
     .setSize(int(width*.3),int(height*.10)) 
     .setFont(mono);
     
     controlP5.addToggle("booleanDistancia")
     .setPosition(width*.3, alturaMenu*.58)
     .setCaptionLabel("Verde : Distancia Riemersma \nRojo : Distnacia Euclidiana")
     .setColorBackground(color(255,0,0))
     .setColorForeground(color(0,0,255))
     .setColorActive(color(0,255,0));
     
 
     
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
    File f = new File(sketchPath()+"\\datos.txt");
    imagen = new Imagen(img,path_datos,slider);
   
    if(f.exists()){
       path_datos = sketchPath()+"\\datos.txt";
      imagen.setDirectorioImagenes( path_datos);
    }
       
    
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
   
   if(path_datos==""){
     fill(color(255,50,50));
     text("No se ha seleccion archivo de datos",width*.10,height*.95);
     
   }
   else{
     fill(color(255,50,255));
     text("Se ha cargado el archivo "+path_datos,width*.10,height*.95);
     
   }
   
}
  
void controlEvent(ControlEvent theEvent) {
  if(theEvent.getLabel()=="Archivo"){
     
    if(theEvent.getValue()==0.0)   //Leer Imagen
        selectInput("Seleccione una imagen:", "imageSelected");  
      
    if(theEvent.getValue()==1.0) //Guardar Imagen
      selectOutput("Select a file to write to:", "guardarImagen");
      
    if(theEvent.getValue()==2.0){  //Cargar arhivos de imagenes
      selectFolder("Seleccione una imagen:", "directorySelected");
    }
    if(theEvent.getValue()==3.0){  //Cargar Texto de un archivo txt
      selectInput("Seleccione una archivo de datos:", "fileHardcodedSelected");
    }
    
    if(theEvent.getValue()==4.0){  //Cargar Texto de un archivo txt
      exit();
    }
    
    listArchivo.close();
  }
  
  //MENU PROCESAR//
  if(theEvent.getLabel()=="Procesar"){
    //Genera el mosaico
    if(theEvent.getValue()==0.0){
      imageSelected = false;
      imagen.setDirectorioImagenes(path_datos);
      imagen.setResolucion(slider);
      imagen.mosaico(booleanDistancia);
      output.setText("Imagen Procesada con exito");
    }
    
    //Vuleve a la imagen original
    if(theEvent.getValue()==1.0){ 
      img = loadImage(path_imagen);      
    }
  }
    
  //MENU AYUDA//    
  if(theEvent.getLabel()=="Ayuda"){
    if(theEvent.getValue()==0.0){
      //Mostrar PDF
      launch(dataPath("README.pdf"));
      }
      
    if(theEvent.getValue()==1.0){ 
      //Creditos
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
    imageSelected=true;
    }
}

/*
*Método para Escoger un directorio
*/
void directorySelected(File selection) {
  if (selection == null) {
    println("Programa terminado");
  } else {
    println("Directorio de imagenes " + selection.getAbsolutePath());
    output.setText("Se esta creando el archivo de imagenes");
    path_directorioImg = selection.getAbsolutePath();
    manejadorDeDatos =new FileMngr("datos.txt",path_directorioImg);
    path_datos = manejadorDeDatos.crearArchivo();
    output.setText("Archivo de imagenes creado");
    }
}

/*
*Método para Escoger un archivo que ya tiene la informacion
*/
void fileHardcodedSelected(File selection) {
  if (selection == null) {
    println("Programa terminado");
  } else {
    println("Archivo " + selection.getAbsolutePath());
    path_datos = selection.getAbsolutePath();
    imagen.setDirectorioImagenes(path_datos);
    }
}
/*
*Método para guardar la imagen actual del programa en el archivo selection
*/
void guardarImagen(File selection) {
  if (selection == null) {
    println("El usuario no selecciono nigun archivo o cerró la ventana");
  } else {
    println("El usuario selecciono el siguiente archivo para guardar la imagen" + selection.getAbsolutePath());
    img.save(selection.getAbsolutePath()+".jpg");
    output.setText("Imagen guardada con exito");
  }
}
