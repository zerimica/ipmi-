PImage origen, expansion, transformacion;
PFont fuente;

int pantalla = -1; // -1: inicio | 0-2: pantallas | 3: final
int tiempoInicio;
int duracionPantalla = 6000; // 6 segundos para más "respiro artístico"

float alphaTexto = 0; // transparencia
boolean aumentando = true;

void setup() {
  size(640, 480);
  origen = loadImage("origen.jpg");
  expansion = loadImage("expansion.jpg");
  transformacion = loadImage("transformacion.jpg");

  fuente = createFont("Georgia", 32);
  textFont(fuente);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(0);

  if (pantalla == -1) {
    fill(255);
    textSize(26);
    text("Obra electrónica: Ecos Digitales\nHaz clic para comenzar", width/2, height/2);
  } else if (pantalla == 0) {
    image(origen, 0, 0, width, height);
    mostrarTextoAnimado("Origen: el primer pulso digital");
    cambiarPantallaAutomaticamente();
  } else if (pantalla == 1) {
    image(expansion, 0, 0, width, height);
    mostrarTextoAnimado("Expansión: los datos fluyen");
    cambiarPantallaAutomaticamente();
  } else if (pantalla == 2) {
    image(transformacion, 0, 0, width, height);
    mostrarTextoAnimado("Transformación: nace la forma final");
    cambiarPantallaAutomaticamente();
  } else if (pantalla == 3) {
    background(10);
    fill(255);
    textSize(24);
    text("Gracias por observar la obra.\nFin del recorrido", width/2, height/2 - 40);

    fill(180, 100, 200);
    rect(width/2 - 60, height/2 + 10, 120, 40);
    fill(0);
    textSize(20);
    text("Reiniciar", width/2, height/2 + 30);
  }
}

void mostrarTextoAnimado(String mensaje) {
  // Animación tipo fade in-out
  if (aumentando) {
    alphaTexto += 2;
    if (alphaTexto >= 255) aumentando = false;
  } else {
    alphaTexto -= 2;
    if (alphaTexto <= 100) aumentando = true;
  }

  fill(255, alphaTexto);
  textSize(28);
  text(mensaje, width/2, height - 50);
}

void cambiarPantallaAutomaticamente() {
  if (millis() - tiempoInicio > duracionPantalla) {
    pantalla++;
    tiempoInicio = millis();
    alphaTexto = 0;
    aumentando = true;
  }
}

void mousePressed() {
  if (pantalla == -1) {
    pantalla = 0;
    tiempoInicio = millis();
  } else if (pantalla == 3) {
    if (mouseX > width/2 - 60 && mouseX < width/2 + 60 &&
        mouseY > height/2 + 10 && mouseY < height/2 + 50) {
      pantalla = 0;
      tiempoInicio = millis();
      alphaTexto = 0;
    }
  }
}
