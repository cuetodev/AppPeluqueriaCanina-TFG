<h1 align = center>App Peluquería Canina</h1>

<!-- ABOUT THE PROJECT -->
## Sobre el proyecto

Este proyecto fue realizado como la parte back de mi TFG, en el instituto IES Fernando III -  Martos (2020-2022)

El proyecto se basa en hacer el back de una agencia de autobuses donde se podrán hacer reservas, consultar reservas, autobuses, emails enviados, se podrán reenviar emails, todo esto bajo la seguridad de un token con JWT, además, la aplicación dispone de varios servicios como Kafka para la comunicación entre el Backempresa y los Backwebs, además del uso de eureka y de un gateway como balanceador de carga.

### Tecnologías

* Springboot - https://spring.io/projects/spring-boot
* Java       - https://www.w3schools.com/java/java_intro.asp

Librerías usadas de interés

* Lombok     - https://projectlombok.org/
* JJWT       - https://jwt.io/

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
git clone https://github.com/cuetodev/VirtualTravel.git
```

2. Después inicializamos el docker compose yéndonos a la ruta del proyecto desde un CMD:

 ```
 docker compose up -d
 ```

3. Importar en Postman el archivo `EFinal_Cloud.postman_collection.json` (Recomendado)

<!-- USAGE EXAMPLES -->
## Uso

En el título de cada endpoint aparecerán unos símbolos según los roles que tienen acceso, aquí la leyenda:

|Símbolo|Significado|
|-|-|
|ALL|Todos pueden acceder al endpoint|
|WORK|Todos los trabajadores pueden acceder al endpoint|
|ADMIN|Solo los administradores pueden acceder al endpoint|

Varios endpoints necesitarán de un token de seguridad, este token lo conseguiremos al loguearnos.
Estos endpoints vendrán marcados con: `Authorization: Bearer Token`

---

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

|Parámetros|Valor|Descripción|Comentarios|
|-|-|-|-|
|`email`|`test@test.com`|Correo para iniciar sesión|Parámetro obligatorio|
|`password`|`test`|Contraseña para iniciar sesión|Parámetro obligatorio|

---

#### Buscar cliente por ID - WORK

`Authorization: Bearer Token`

|Método|URL|Descripción|
|-|-|-|
|`GET`|`api/v0/client/{id}`|Buscar un cliente según su ID|

|Parámetros|Valor|Descripción|Comentarios|
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

|Parámetros|Valor|Descripción|Comentarios|
|-|-|-|-|
|`userName`|`David`|Nombre de usuario a buscar|Parámetro obligatorio|
|`page`|`0`|Página que queremos ver|Parámetro opcional, por defecto es 0|
|`size`|`5`|Número de clientes que queremos que aparezcan por página|Parámetro opcional, por defecto es 10|

---

#### Listar todos los clientes - WORK

`Authorization: Bearer Token`

|Método|URL|Descripción|
|-|-|-|
|`GET`|`api/v0/client/all`|Listar todos los clientes de la aplicación|

|Parámetros|Valor|Descripción|Comentarios|
|-|-|-|-|
|`page`|`0`|Página que queremos ver|Parámetro opcional, por defecto es 0|
|`size`|`5`|Número de clientes que queremos que aparezcan por página|Parámetro opcional, por defecto es 10|

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

<!-- CONTACT -->
## Contacto

<p align="center">
  <a href="https://www.linkedin.com/in/david-cueto-garrido-2158a2227"><img src="https://img.shields.io/badge/LinkedIn-blue?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn Badge"></a>
  <a href="https://www.twitter.com/davidcueto_dev"><img src="https://img.shields.io/badge/Twitter-blue?style=for-the-badge&logo=twitter&logoColor=white" alt="Twitter Badge"></a>
</p>

* Link del proyecto: https://github.com/cuetodev/AppPeluqueriaCanina-TFG
