import controlP5.*;
import ddf.minim.*;
import ddf.minim.effects.*;

import org.elasticsearch.action.admin.indices.exists.indices.IndicesExistsResponse;
import org.elasticsearch.client.Client;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.node.Node;
import org.elasticsearch.node.NodeBuilder;

ControlP5 boton, vol, knob;
//SoundFile file;


Slider abc;
Minim cadena;
AudioPlayer song;
float valor=0;

//Metadata
String name, title, autor;
float duracion;


Client client;
Node node;

void setup() {


  //Interfaz
  size(450, 350);
  background(0);
  boton = new ControlP5(this);
  vol = new ControlP5(this);
  knob = new ControlP5(this);

  boton.addButton("play")
    .setValue(0)
    .setPosition(155, 300)
    .setSize(40, 40)
    .setImages(loadImage("play1.png"), loadImage("play2.png"), loadImage("play3.png"));
  boton.addButton("pause")
    .setValue(0)
    .setPosition(195, 300)
    .setSize(40, 40)
    .setImages(loadImage("pause1.png"), loadImage("pause2.png"), loadImage("pause3.png"));
  boton.addButton("stop")
    .setValue(0)
    .setPosition(115, 300)
    .setSize(40, 40)
    .setImages(loadImage("stop1.png"), loadImage("stop2.png"), loadImage("stop3.png"));
  boton.addButton("choose")
    .setValue(0)
    .setPosition(75, 300)
    .setSize(40, 40)
    .setImages(loadImage("choose1.png"), loadImage("choose2.png"), loadImage("choose3.png"));
  vol.addSlider("Volumen")
    .setValue(100)
    .setPosition(295, 300)
    .setSize(105, 40)
    .setRange(0, 100)
    .setColorValue(color(0))
    .setColorActive(color(200))
    .setColorForeground(color(255))
    .setColorBackground(color(255, 0, 0));



  knob.addKnob("High")
    .setValue(100)
    .setPosition(80, 200)
    .setSize(50, 50)
    .setRange(0, 100)
    .setColorValue(color(0))
    .setColorActive(color(255, 0, 0))
    .setColorForeground(color(200))
    .setColorBackground(color(255));

  knob.addKnob("Low")
    .setValue(100)
    .setPosition(180, 200)
    .setSize(50, 50)
    .setRange(0, 100)
    .setColorValue(color(0))
    .setColorActive(color(255, 0, 0))
    .setColorForeground(color(200))
    .setColorBackground(color(255));

  knob.addKnob("Mid")
    .setValue(100)
    .setPosition(290, 200)
    .setSize(50, 50)
    .setRange(0, 100)
    .setColorValue(color(0))
    .setColorActive(color(255, 0, 0))
    .setColorForeground(color(200))
    .setColorBackground(color(255));

  //Manejo de sonido
  //file = new SoundFile(this, "Ring03.wav");
  //println(file.sampleRate()+ " Hz");

  cadena = new Minim(this);
  //song = cadena.loadFile("04-mute-city.mp3",1024);
  
  
}

void draw() {
    
}


public void play() {
  textAlign(CENTER);
  textSize(20);
  text(title, width/2, 50);
  text(autor, width/2, 70);
  song.play();

 
  //println("Nombre: "+name);
  //println("Titulo: "+title);
  //println("autor: "+autor);
  //println("Duración: "+duracion);
}

public void pause() {
  song.pause();
}

public void stop() {

  song.pause();
  song.rewind();
}

public void choose() {
    background(0);
    selectInput("Selecciona canción: ", "fileSelected");
    song.pause();

}

void fileSelected(File selection) {

  if (selection == null) {
    println("No se escogió canción");
  } else {
    String filename = selection.getAbsolutePath();
    song = cadena.loadFile(filename);

    name = song.getMetaData().fileName();
    title = song.getMetaData().title();
    autor = song.getMetaData().author();
    duracion = song.getMetaData().length()/1000;
  }
}






void controlEvent (ControlEvent evento) // se activa el evento
{
  if (evento.getController().getName()=="Volumen") {
    valor = int(evento.getController().getValue()); 
    valor = valor-60;
    song.setGain(valor);
  }
}