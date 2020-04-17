import processing.serial.*;
Serial port;
float posX[];
float posY[];

int estado[];

float vel;
float distancia=0;

int puntaje = 0;

PImage bg;
PImage img;
PImage img2;
PFont font;

//arduino

float posX2;
int leer;


int ancho = 110;
int alto = 140;

int dir = 1;
int dir2 = 1;

float mapeado;

float x = 150;
float y = 30;

void setup()
{
  size(1024, 600);
  posX = new float[100];
  posY = new float[100];
  estado = new int[100];

  for (int i=0; i<100; i++)
  {
    posX[i]=random(0, 1000);
    posY[i]=random(0, 300);
    estado[i]=1;
  }
  bg = loadImage("fondo.png");
  img = loadImage("meteoro.png");
  img2= loadImage("astro.png");
  font = loadFont("Noteworthy-Light-48.vlw");
  
  //arduino
  port = new Serial(this, "/dev/cu.usbmodem14201", 9600);
}
void draw()
{
 
  background(bg);

  for (int i=0; i<100; i++)
  {
    vel=random(0.1, 2);
    
    posY[i] = posY[i]+vel;
  }

  fill(#A03A3A);
  for (int i=0; i<100; i++)
  {
    if (estado[i]==1)
    {
      image(img, posX[i], posY[i], 35, 70);
    }
  }
   

  for (int i=0; i<100; i++)

  {
    if (mousePressed == true)
    {
      distancia = dist(mouseX, mouseY, posX[i], posY[i]);
      if(distancia<=20)
      {
      estado[i] = 0;
      }
    }
  }
  textFont(font);
  fill(#D1CEE0);
  text("score:"+puntaje,30,60);
  
  puntaje=0;
  for(int i=0; i<100; i++)
  {
    if(estado[i] ==0)
    {
      puntaje++;
    }
  }
  
  //arduino
  
  if(0 < port.available())
   {
     leer = port.read();
     println(leer);
      mapeado = map(leer,0,255,0,768);
   }
   
   posX2=mapeado;
  //rect(0, posX2, ancho, alto);
  //image(img2, mouseX, mouseY, 110, 140);
  image(img2, 0, posX2, ancho, alto);

  if (y > 0 && y < ancho + 10)
  {
    if (x >= posX2 && x <= posX2 + alto)
    {
      dir=dir*-1;
    }
  }
}
