# Fake Store App

Una aplicación de eCommerce desarrollada en Flutter, diseñada para ofrecer una experiencia de compra en línea fluida y eficiente. Esta aplicación incluye funcionalidades de registro e inicio de sesión, un catálogo de productos, búsquedas, y un carrito de compras. La arquitectura utilizada es MVVM (Model-View-ViewModel) con un enfoque de Clean Architecture y el manejo de estados se realiza con Provider.

## Características

- **Registro/Inicio de Sesión**: Permite a los usuarios crear una cuenta nueva o iniciar sesión con una cuenta existente.
- **Home**: Pantalla principal con acceso rápido a categorías de productos y promociones.
- **Catálogo**: Navegación y visualización de productos disponibles.
- **Búsquedas**: Funcionalidad de búsqueda para encontrar productos específicos.
- **Soporte**: Funcionalidad para pedir asesoría o resolver problemas comunes.
- **Carrito de Compras**: Permite a los usuarios agregar productos a su carrito y proceder al pago.

## Tecnologías Utilizadas

- **Flutter**: Framework de desarrollo de aplicaciones móviles.
- **Dart**: Lenguaje de programación utilizado por Flutter.
- **Provider**: Paquete de Flutter para el manejo de estados.

## Estructura del Proyecto

El proyecto está estructurado siguiendo los principios de Clean Architecture con la separación en capas para facilitar el mantenimiento y la escalabilidad.

![Screenshot 2024-06-15 010734](https://github.com/chrisr04/fake_store_app/assets/47868395/90fff570-5cb3-48a2-a69a-fbc9f04f25a6)

- **data**: Contiene los modelos de datos, repositorios y fuentes de datos (API, local, etc.).
- **domain**: Contiene las entidades del dominio, repositorios y casos de uso.
- **presentation**: Contiene las páginas, viewmodels y widgets para la interfaz de usuario.

## Instalación

Para ejecutar esta aplicación en tu entorno local, sigue los siguientes pasos:

1. **Clona el repositorio**:
    ```bash
    git clone https://github.com/chrisr04/fake_store_app
    ```

2. **Navega al directorio del proyecto**:
    ```bash
    cd fake_store_app
    ```

3. **Instala las dependencias**:
    ```bash
    flutter pub get
    ```

4. **Ejecuta la aplicación**:
    ```bash
    flutter run
    ```

## Uso


### Registro/Inicio de Sesión

- Los usuarios pueden registrarse con un correo electrónico y una contraseña.
- Los usuarios registrados pueden iniciar sesión con sus credenciales.

### Home

- La pantalla de inicio muestra categorías de productos y promociones destacadas.

### Catálogo

- Los usuarios pueden navegar por las categorías y ver la lista de productos disponibles.

### Búsquedas

- Los usuarios pueden buscar productos específicos usando la barra de búsqueda.

### Soporte

- Los usuarios pueden buscar asesoría en linea con el equipo de soporte.

### Carrito de Compras

- Los usuarios pueden agregar productos a su carrito.
- Los usuarios pueden ver los productos en su carrito, modificar la cantidad o eliminar productos.


## Diagrama de Flujo

![Diagrama de flujo Fake Store](https://github.com/chrisr04/fake_store_app/assets/47868395/8750dfc4-9da6-4623-895f-cbeb26e6803f)


## Demo

[Video de demostración](https://drive.google.com/file/d/1fPq1icDQr4kBA2Fsanu8oFlL4eb_d0li/view?usp=sharing)