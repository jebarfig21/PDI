import interfascia.*;
import controlP5.*;
import java.net.URISyntaxException;
import java.net.URI;
 
PGraphics lienso;
PImage img;
boolean imageSelected = false; 
boolean textSelected = false; 
String path_imagen="";
String path_texto="";
Imagen imagen; 
//ControlP5
ControlP5 controlP5;
ListBox listArchivo, listProcesar, listAyuda;
Textfield input; 
Textarea output;
String textValue ="";
StringList script;
      
//COLORES
final color azulMarino = color(32, 6, 127);
final color azulMarinoTransparente = color(32, 6, 127,240);
final color fondo = color(250);//Gris-Blanco
final color menuMarcado = color(0, 120, 250);//Color de los botones del menu cuando apsas el menu por encima
final color selecItemMenu = color(0,255,0,120);//Color de los item de cada scrollBar del menú cunado los seleccionas

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
  fill(azulMarino);
  rect(0, 0, width, alturaMenu);
  controlP5 = new ControlP5(this);

  //Añadir elementos de la interfaz gráfica
  listArchivo  = controlP5.addListBox("Archivo", 10, 0 , anchoListasMenu, altoListasMenu)
    .setItemHeight(15)
    .setBarHeight(int(height*.1))
    .addItem("Leer Imagen",0)
    .addItem("Guardar Imagen",1)
    .addItem("Cargar Texto",2)
    .addItem("Guardar Texto",3)
    .addItem("Terminar",4)
    .setColorBackground(azulMarino)
    .setColorActive(selecItemMenu)
    .setColorForeground(menuMarcado)
    .setOpen(false);
    
   listProcesar  = controlP5.addListBox("Procesar",  separacionListasMenu, 0 , anchoListasMenu,altoListasMenu)
    .setItemHeight(15)
    .setBarHeight(int(height*.1))
    .addItem("Encriptar Texto",0)
    .addItem("Desencriptar Texto",1)
    .setColorBackground(azulMarino)
    .setColorActive(selecItemMenu)
    .setColorForeground(menuMarcado)
    .setOpen(false);
    
    listAyuda  = controlP5.addListBox("Ayuda",  separacionListasMenu*2 , 0 , anchoListasMenu, altoListasMenu)
     .setItemHeight(15)
     .setBarHeight(int(height*.1))
     .addItem("Manual",0)
     .addItem("Acerca De",1)
     .setColorBackground(azulMarino)
     .setColorActive(color(0, 250, 0))
     .setColorForeground(color(0, 120, 250))
     .setOpen(false);
     
    input = controlP5.addTextfield("Entrada") 
     .setColor(color(0)) 
     .setColorBackground(color(255, 255, 255)) 
     .setColorCursor(color(0)) 
     .setPosition(width*.3, alturaMenu*.1) 
     .setSize(int(width*.6), 40) 
     .setFont(mono) 
     .setFocus(true);
 
    output = controlP5.addTextarea("output") 
     .setColor(color(255)) 
     .setColorBackground(azulMarinoTransparente) //.setColorCursor(color(0)) 
     .setPosition(width*.7,height*.15) 
     .setSize(int(width*.3),int(height*.85)) 
     .setFont(mono);
}

void draw() {
  background(250);  
  fill(32, 6, 127);
  rect(0, 0, width, height*.1);
  fill(0);
  text("SALIDA:",width*.7,height*.13);
  float altura = height*.2;
  if(imageSelected){
    img = loadImage(path_imagen);
    imagen = new Imagen(img);
  }
  if(img!=null){
    lienso= createGraphics(img.width,img.height,JAVA2D);
    lienso.beginDraw();
    lienso.image(img, 0, 0,img.width,img.height);
    lienso.endDraw();
    image(lienso,width*.1,altura,img.width,img.height); 
   }
}
  
void controlEvent(ControlEvent theEvent) {
  if(theEvent.getLabel()=="Archivo"){
    if(theEvent.getValue()==0.0)   //Leer Imagen
        selectInput("Seleccione una imagen:", "imageSelected");
        
      
    if(theEvent.getValue()==1.0) //Guardar Imagen
      selectOutput("Select a file to write to:", "guardarImagen");
      
    if(theEvent.getValue()==2.0){  //Cargar Texto de un archivo txt
      selectInput("Seleccione una texto:", "textSelected");
      while(!textSelected){print("");}
      if(textSelected){ 
        String[] textoSalida = loadStrings(path_texto);
        String cadenaSalida="";
        for (int i= 0 ; i<textoSalida.length;i++){
          cadenaSalida+=textoSalida[i]+" ";
        }
        input.setText(cadenaSalida);
      }
    }
    
    if(theEvent.getValue()==3.0) //Guardar salida en un archivo txt
      selectOutput("Select a file to write to:", "guardarTexto");
    
    if(theEvent.getValue()==4.0) //Terminar Ejecucion
      exit();                  
      
    listArchivo.close();
  }
  
  //MENU PROCESAR//
  if(theEvent.getLabel()=="Procesar"){
    if(theEvent.getValue()==0.0){      // Encriptar
      String mensaje = input.getText();
      imagen.encriptar(mensaje);
      imageSelected = false;
      input.clear();
      if(mensaje.trim().equals(imagen.desencriptar().trim()))
        output.setText("El texto \n"+mensaje + "fue cifrado con exito");
      else{output.setText("Hubo un error, por favor vuelva a");}
        
    }
      
    if(theEvent.getValue()==1.0){      //Desencriptar
      String textoSalida = imagen.desencriptar();
      output.setText(textoSalida);      
    }
    listProcesar.close();
  }
  
  //MENU AYUDA//    
  if(theEvent.getLabel()=="Ayuda"){
    if(theEvent.getValue()==0.0){//Mostrar PDF
  
    link("file://"+dataPath("manual.pdf"));
    launch(dataPath("manual.pdf"));
      }
        
    if(theEvent.getValue()==1.0){ //Creditos
      output.setText("Autor : Jose de Jesus Barajas Figueroa\n\n"+
      "Programa que realiza un procesos de esteganograafía a un"+
      " texto sobre una imagen\n\n"+
      " Este programa puede ser copiado, modificado y usarse con"+
      " fines academicos y personales, con la debida acreditación"
      );  
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
*Método para seleccionar un archivo de texto cono entrada del programa
*/
void textSelected(File selection) {
  if (selection == null) {
    println("Programa terminado");
  } else {
    println("Texto seleccionado" + selection.getAbsolutePath());
    path_texto  = selection.getAbsolutePath();
    println(path_texto);
    textSelected = true;
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
    lienso.save(selection.getAbsolutePath());  
  }
}

/*
*Método para escrbir la salida del programa en el archivo selection
*/
void guardarTexto(File selection) {
  PrintWriter outputTxt;
  if(selection == null) {
    println("Ventana Cerrada o usuario canceló");
  } else {
    println("El usuario seleccionó guardar texto en : " + selection.getAbsolutePath());
    outputTxt = createWriter(selection.getAbsolutePath());
    outputTxt.print(output.getText());
    outputTxt.close();
  }
}
