<h1 align = center>App Peluquería Canina</h1>

<!-- ABOUT THE PROJECT -->
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

#### Token - ALL

|Método|URL|Descripción|
|-|-|-|
|`GET`|`api/v0/client/token`|Obtiene el token necesario para los demás endpoints|

|Parámetros|Valor de ejemplo|Descripción|Comentarios|
|-|-|-|-|
|`email`|`test@test.com`|Correo para comprobar|Parámetro obligatorio|
|`password`|`test`|Contraseña para comprobar|Parámetro obligatorio|

##### Ejemplo de un token recibido
```
Bearer eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJzb2Z0dGVrSldUIiwic3ViIjoiYUBhLmVzIiwiYXV0aG9yaXRpZXMiOlsiUk9MRV9VU0VSIl0sImlhdCI6MTY1NDEwNTkyMywiZXhwIjoxNjU0MTA3NzIzfQ.wqlOGs9vUifXwfsVlWgW13Mwie2J6_QpmoFvSR8jXP-VZeoJBOqY9oEwZdIL5qM_ocNflL9C-Xg_3yn1DK_t9w
```

---

#### Buscar cliente por ID - WORK

`Authorization: Bearer Token`

|Método|URL|Descripción|
|-|-|-|
|`GET`|`api/v0/client/{id}`|Buscar un cliente según su ID|

|Parámetros|Valor de ejemplo|Descripción|Comentarios|
|-|-|-|-|
|`id`|`458`|Busca el cliente según su ID|Parámetro obligatorio|

---

#### Buscar cliente por email - WORK

`Authorization: Bearer Token`

|Método|URL|Descripción|
|-|-|-|
|`GET`|`api/v0/client/email`|Buscar un cliente según su email|

##### Ejemplo de un body enviado
```
{
    "email": "test@test.com"
}
```

---

#### Buscar cliente por nombre de usuario - WORK

`Authorization: Bearer Token`

|Método|URL|Descripción|
|-|-|-|
|`GET`|`api/v0/client/userName`|Buscar un cliente según su nombre de usuario|

|Parámetros|Valor de ejemplo|Descripción|Comentarios|
|-|-|-|-|
|`userName`|`David`|Nombre de usuario a buscar|Parámetro obligatorio|
|`page`|`0`|Página que queremos ver|Parámetro opcional, por defecto es 0|
|`size`|`10`|Número de clientes que queremos que aparezcan por página|Parámetro opcional, por defecto es 10|

---

#### Listar todos los clientes - WORK

`Authorization: Bearer Token`

|Método|URL|Descripción|
|-|-|-|
|`GET`|`api/v0/client/all`|Listar todos los clientes de la aplicación|

|Parámetros|Valor de ejemplo|Descripción|Comentarios|
|-|-|-|-|
|`page`|`0`|Página que queremos ver|Parámetro opcional, por defecto es 0|
|`size`|`10`|Número de clientes que queremos que aparezcan por página|Parámetro opcional, por defecto es 10|

---

#### Actualizar un cliente / perfil - ALL

`Authorization: Bearer Token`

|Método|URL|Descripción|
|-|-|-|
|`PUT`|`api/v0/client/{id}`|Actualizar un cliente según su ID|

##### Ejemplo de un body enviado
```
{
    "userName": "David",
    "email": "david@test.com",
    "password": "test",
    // Estos atributos los podrá enviar un trabajador
    "role": "ROLE_WORKER",
    "active": false
}
```

---

#### Borrar un cliente - ALL

(Realmente nunca llega a borrarse de la BD, se coloca el usuario como inactivo)

`Authorization: Bearer Token`

|Método|URL|Descripción|
|-|-|-|
|`DELETE`|`api/v0/client/{id}`|Borrar un cliente según su ID|

---

### Mascota

#### Registrar una mascota - ALL

`Authorization: Bearer Token`

|Método|URL|Descripción|
|-|-|-|
|`POST`|`api/v0/pet`|Registra una mascota|

##### Ejemplo de un body enviado
```
{
    "name": "Zeus",
    "breed": "Labrador",
    "type": "Perro",
    // Parámetros opcionales
    "weight": 45,
    "img": "url_imagen...",
    "client_id": 1 // Este parámetro es opcional porque podré crear una mascota estando logeado y sin logear
}
```

---

#### Listar mis mascotas - ALL

`Authorization: Bearer Token`

|Método|URL|Descripción|
|-|-|-|
|`GET`|`api/v0/pet/{id}/all`|Listar todas mis mascotas|

|Parámetros|Valor de ejemplo|Descripción|Comentarios|
|-|-|-|-|
|`page`|`0`|Página que queremos ver|Parámetro opcional, por defecto es 0|
|`size`|`10`|Número de clientes que queremos que aparezcan por página|Parámetro opcional, por defecto es 10|

---

#### Buscar mascota por ID - WORK

`Authorization: Bearer Token`

|Método|URL|Descripción|
|-|-|-|
|`GET`|`api/v0/pet/{id}`|Buscar una mascota según su ID|

|Parámetros|Valor de ejemplo|Descripción|Comentarios|
|-|-|-|-|
|`id`|`458`|Busca una mascota según su ID|Parámetro obligatorio|

---

#### Actualizar una mascota - ALL

`Authorization: Bearer Token`

|Método|URL|Descripción|
|-|-|-|
|`PUT`|`api/v0/pet/{id}`|Actualizar una mascota según su ID|

##### Ejemplo de un body enviado
```
{
    // Parámetros opcionales
    "name": "Berta",
    "breed": "Caniche",
    "type": "Perro",
    "weight": 15,
    "img": "img_url"
}
```

---

#### Borrar una mascota - ALL

`Authorization: Bearer Token`

|Método|URL|Descripción|
|-|-|-|
|`DELETE`|`api/v0/pet/{id}`|Borrar una mascota según su ID|

---

### Citas

#### Registrar una cita - ALL

`No necesita token, ya que podemos crear una cita sin estar logeados`

|Método|URL|Descripción|
|-|-|-|
|`POST`|`api/v0/appointment`|Registra una cita|

##### Ejemplo de un body enviado
```
{
    "date": "2022-06-01", // Tiene que seguir el formato yyyy-MM-dd
    "hourCheck": "19:00",
    "services": "Lavado y peinado",
    "phone": "123456789",
    "petId": 1,
    // Parámetro opcional, por defecto: "active"
    "status": "finished"
}
```

---

#### Listar citas según condiciones - WORK

`Authorization: Bearer Token`

|Método|URL|Descripción|
|-|-|-|
|`GET`|`api/v0/appointment/all`|Listar citas según condiciones|

|Parámetros|Valor de ejemplo|Descripción|Comentarios|
|-|-|-|-|
|`page`|`0`|Página que queremos ver|Parámetro opcional, por defecto es 0|
|`size`|`10`|Número de clientes que queremos que aparezcan por página|Parámetro opcional, por defecto es 10|
|`status`|`finished`|Status de la cita|Parámetro opcional, por defecto es active|
|`lowerDate`|`2022-05-10`|Filtrará por citas posteriores a la fecha dada|Parámetro opcional|
|`upperDate`|`2022-10-27`|Filtrará por citas anteriores a la fecha dada|Parámetro opcional|
|`equalDate`|`2022-07-15`|Filtrará por citas con la misma fecha dada|Parámetro opcional|

---

#### Listar citas según la ID de un cliente - ALL

`Authorization: Bearer Token`

|Método|URL|Descripción|
|-|-|-|
|`GET`|`api/v0/appointment/{id}`|Listar mis citas|

|Parámetros|Valor de ejemplo|Descripción|Comentarios|
|-|-|-|-|
|`id`|`458`|Busca todas las citas según la ID de un cliente|Parámetro obligatorio|

---

#### Buscar cita por ID - WORK

`Authorization: Bearer Token`

|Método|URL|Descripción|
|-|-|-|
|`GET`|`api/v0/appointment/{id}`|Buscar una cita según su ID|

|Parámetros|Valor de ejemplo|Descripción|Comentarios|
|-|-|-|-|
|`id`|`458`|Busca una cita según su ID|Parámetro obligatorio|

---

#### Actualizar una cita - ALL

`Authorization: Bearer Token`

|Método|URL|Descripción|
|-|-|-|
|`PUT`|`api/v0/appointment/{id}`|Actualizar una cita según su ID|

##### Ejemplo de un body enviado
```
{
    // Parámetros opcionales
    "date": "2022-06-15",
    "hourCheck": "20:00",
    "services": "Lavado y corte",
    "phone": "123456789",
    "petId": 1,
    "status": "finished"
}
```

---

#### Borrar una cita - ALL

`Authorization: Bearer Token`

|Método|URL|Descripción|
|-|-|-|
|`DELETE`|`api/v0/appointment/{id}`|Borrar una cita según su ID|

---

<!-- CONTACT -->
## Contacto

<p align="center">
  <a href="https://www.linkedin.com/in/david-cueto-garrido-2158a2227"><img src="https://img.shields.io/badge/LinkedIn-blue?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn Badge"></a>
  <a href="https://www.twitter.com/davidcueto_dev"><img src="https://img.shields.io/badge/Twitter-blue?style=for-the-badge&logo=twitter&logoColor=white" alt="Twitter Badge"></a>
</p>

* Link del proyecto: https://github.com/cuetodev/AppPeluqueriaCanina-TFG
