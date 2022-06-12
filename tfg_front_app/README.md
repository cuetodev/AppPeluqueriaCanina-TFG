<h1 align = center>App Peluquería Canina</h1>

## Definición de algunos conceptos

* Back - La parte de atrás de la aplicación (back del inglés: parte trasera), donde está toda la lógica desarrollada de la aplicación.
* Front - La parte de alante de la aplicación (front del inglés: parte delantera), donde está la parte visible que toca el usuario.
* Microservicio - Parte de código desarrollada con una finalidad concreta, por ejemplo, un microservicio que me permita añadir mascotas.
* Endpoint - Dirección http por la cual se conecta el front con el back para acceder a algún microservicio.
* JJWT - Sistema de seguridad basado en acceder a los endpoints a través de un token, sin ese token no se podrá acceder.
* Springboot - Tecnología que me permite crear aplicaciones autocontroladas basada en Java
* Java - Lenguaje de programación tipado.
* Lombok - Librería utilizada para la creación de constructores, getter, setter, to string, entre otras cosas para las clases con simplemente agregar etiquetas.

## Sobre el proyecto

Este proyecto fue realizado como la parte back de mi TFG, en el instituto IES Fernando III -  Martos (2020-2022)

El proyecto se basa en hacer el back de una peluquería canina donde se podrán registrar y logear clientes, se podrán crear, borrar, actualizar y ver mascotas, citas, como varios métodos de búsquedad, además, está implementado el jjwt de tal forma que para acceder a algunos endpoints se necesita de un token, he empleado excepciones propias y también he creado etiquetas para validar datos de entrada, entre otras cosas.

### Tecnologías

* Springboot - https://spring.io/projects/spring-boot
* Java       - https://www.w3schools.com/java/java_intro.asp

Librerías usadas de interés

* Lombok                       - https://projectlombok.org/
* JJWT (Json Web Token)        - https://jwt.io/
* Spring Boot Starter Security - https://mvnrepository.com/artifact/org.springframework.boot/spring-boot-starter-security

<!-- GETTING STARTED -->
## Empezando

### Prerrequisitos

Importante tener instalado / actualizado lo siguiente:
* Docker
* JDK 17
* Postman (Opcional) - Por si se quieren hacer pruebas independientes del back

### Instalación

1. Primero hacemos un clone del repositorio

```
git clone https://github.com/cuetodev/AppPeluqueriaCanina-TFG.git
```

2. Después inicializamos el docker compose yéndonos a la ruta del proyecto (DEL BACK) desde un CMD:

`Antes entrar a la carpeta del back y después realizar el siguiente comando:`
 ```
 docker compose up -d
 ```
 
 `A veces puede pasar que el contenedor "backappdoggroomer" no llegue a iniciarse porque la base de datos tarda un poco en iniciarse y no le da tiempo a conectarse, si esto llegase a ocurrir, simplemente hay que volver a iniciar el contenedor "backappdoggroomer"`

3. Importar en Postman el archivo `TFG BACK.postman_collection` (Recomendado)

<!-- USAGE EXAMPLES -->
## Uso

En el título de cada endpoint aparecerán unos símbolos según los roles que tienen acceso, aquí la leyenda:

|Símbolo|Significado|
|-|-|
|ALL|Todos pueden acceder al endpoint|
|WORK|Todos los trabajadores pueden acceder al endpoint|
|ADMIN|Solo los administradores pueden acceder al endpoint|

Varios endpoints necesitarán de un token de seguridad (Explicado más abajo).
Estos endpoints vendrán marcados con: `Authorization: Bearer Token`

---

### Cliente

#### Register - ALL

|Método|URL|Descripción|
|-|-|-|
|`POST`|`api/v0/client`|Registra un cliente|

##### Ejemplo de un body enviado
```
{
    "userName":"test",
    "email": "testa@test.com",
    "password":"test"
}
```

---

#### Login - ALL

|Método|URL|Descripción|
|-|-|-|
|`POST`|`api/v0/client/login`|Inicia sesión|

|Parámetros|Valor de ejemplo|Descripción|Comentarios|
|-|-|-|-|
|`email`|`test@test.com`|Correo para iniciar sesión|Parámetro obligatorio|
|`password`|`test`|Contraseña para iniciar sesión|Parámetro obligatorio|

---

<!-- CONTACT -->
## Contacto

<p align="center">
  <a href="https://www.linkedin.com/in/david-cueto-garrido-2158a2227"><img src="https://img.shields.io/badge/LinkedIn-blue?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn Badge"></a>
  <a href="https://www.twitter.com/davidcueto_dev"><img src="https://img.shields.io/badge/Twitter-blue?style=for-the-badge&logo=twitter&logoColor=white" alt="Twitter Badge"></a>
</p>

* Link del proyecto: https://github.com/cuetodev/AppPeluqueriaCanina-TFG
