# Colliscion-3D

Se tomó como base un proyecto de **Godot** que ya incluía un enemigo con un comportamiento de **activación por cercanía**.  
Sobre esta base, se realizaron las siguientes mejoras y añadidos:

## Nuevas Funcionalidades

- **Enemigo cuerpo a cuerpo**  
  Se implementó un nuevo enemigo que realiza un **ataque directo ** cuando el jugador entra en su rango de acción.

- **Gema especial**  
  - Al recoger la gema, el jugador obtiene la **habilidad temporal** de atacar cuerpo a cuerpo durante **5 segundos**.  
  - Mientras dure el efecto, el enemigo que se activaba por cercanía **no realizará su ataque**.

- **Llave del nivel**  
  Se añadió un objeto llave que el jugador debe recoger para poder **finalizar el nivel**.

## Resumen de la Mecánica
1. El jugador debe moverse con cuidado para evitar al enemigo que ataca por cercanía.  
2. Puede recolectar la gema para obtener poder de ataque por tiempo limitado.  
3. Con la llave, podrá desbloquear la salida y **completar el nivel**.
