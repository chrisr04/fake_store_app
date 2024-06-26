# Fake Store App

Una aplicación de eCommerce desarrollada en Flutter, diseñada para ofrecer una experiencia de compra en línea fluida y eficiente. Esta aplicación incluye funcionalidades de registro e inicio de sesión, un catálogo de productos, búsquedas, y un carrito de compras. La arquitectura utilizada es MVVM (Model-View-ViewModel) con un enfoque de Clean Architecture y el manejo de estados se realiza con Provider.

El diseño de la app se realizo usando el paquete [Fake Store Design System](https://github.com/chrisr04/fake_store_ds.git) que contiene todos los widgets personalizados requeridos para la implementación de la interfaz de usuario. Las consultas al servidor se realizaron utilizando el paquete [Fake Api](https://github.com/chrisr04/fake_api.git) que contiene todos los métodos necesarios para hacer mas fácil el consumo de los datos. Ambos paquetes fueron desarrollados desde 0 con el proposito de ser utilizados en el desarrollo de esta aplicación.

## Características

- **Registro/Inicio de Sesión**: Permite a los usuarios crear una cuenta nueva o iniciar sesión con una cuenta existente.
- **Home**: Pantalla principal con acceso rápido a categorías de productos y promociones.
- **Catálogo**: Navegación y visualización de productos disponibles.
- **Búsquedas**: Funcionalidad de búsqueda para encontrar productos específicos.
- **Soporte**: Funcionalidad para pedir asesoría o resolver problemas comunes.
- **Carrito de Compras**: Permite a los usuarios agregar productos a su carrito y proceder al pago.

## Estructura del Proyecto

El proyecto está estructurado siguiendo los principios de Clean Architecture con la separación en capas para facilitar el mantenimiento y la escalabilidad.

![Screenshot 2024-06-15 010734](https://github.com/chrisr04/fake_store_app/assets/47868395/90fff570-5cb3-48a2-a69a-fbc9f04f25a6)

- **data**: Contiene los modelos de datos, repositorios y fuentes de datos (API, local, etc.).
- **domain**: Contiene las entidades del dominio, repositorios y casos de uso.
- **presentation**: Contiene las páginas, viewmodels y widgets para la interfaz de usuario.

## Instalación

Para ejecutar esta aplicación en tu entorno local, sigue los siguientes pasos:

**Clona el repositorio**:
```bash
git clone https://github.com/chrisr04/fake_store_app
```

**Navega al directorio del proyecto**:
```bash
cd fake_store_app
```

**Instala las dependencias**:
```bash
flutter pub get
```

**Ejecuta la aplicación**:
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

## Pruebas

### Pruebas unitarias

Las pruebas unitarias se utilizan para verificar que las funciones y métodos individuales de la aplicación funcionen correctamente de manera aislada. Esto nos ayuda a asegurar que cada parte del código haga exactamente lo que se espera. En la aplicacion se centraron en las capas de dominio y datos, asi como en los viewmodels que hacen parte de la capa de presentación debido a que estos archivos poseen la mayor parte de la logica de la app.

### Pruebas de widgets

Las pruebas de widget verifican que los componentes de la interfaz de usuario se construyan y funcionen correctamente. En la aplicacion estas pruebas se centraron en la capa de presentación y en los widgets compartidos entre módulos.

### Configuración del Entorno

Para realizar las pruebas unitarias y de widgets, se requiere configurar el entorno de desarrollo con la siguiente dependencia:

```bash
flutter pub add flutter_test
```

### Ejecución de las Pruebas 

Para ejecutar las pruebas unitarias y de widgets, utilice el siguiente comando:

```bash
flutter test
```

### Pruebas de Integración

Las pruebas de integración verifican la interacción entre diferentes partes de la aplicación para asegurar que trabajen juntas correctamente.

#### Casos probados

- Inicio de Sesión.
- Registro de usuarios.
- Buscar un producto por nombre.
- Navegar a la página de soporte.
- Navegar al detalle de un producto.
- Navegar a los productos de una categoría en especifico.
- Agregar productos al carrito.
- Quitar productos del carrito.
- Modificar productos del carrito.

### Configuración del Entorno

Para realizar las pruebas de integración, se requiere configurar el entorno de desarrollo con la siguiente dependencia:

```bash
flutter pub add integration_test
```

### Ejecución de las Pruebas 

Para ejecutar las pruebas de integración, utilice el siguiente comando:

```bash
flutter test integration_test/fake_store_test.dart
```

## Cobertura

La aplicación cuenta con una cobertura del 91.6%. Si deseas ver un reporte mas detallado sigue los siguientes pasos:

**Paso 1:**

Genera el archivo lcov.info que contendrá la información de la cobertura de la app

```bash
flutter test --coverage
```

**Paso 2:**

Genera el html necesario para mostrar el reporte

```bash
genhtml coverage/lcov.info -o coverage/html
```

**Nota:** Antes de ejecutar este comando debes tener instalado en tu sistema `lcov`, de lo contrario no funcionará. En macOS puedes instalarlo con el comando `brew install lcov`, pero ten en cuenta que este proceso puede variar en otros sistemas operativos.

**Paso 3:**

Abre el reporte en el navegador

```bash
open coverage/html/index.html
```

## Parametrización

Para el manejo de strings y assets se hizo uso de archivos de configuración en formato Json, estos archivos se encuentan en la carpeta de `assets` y contienen los valores utilizados en la app para mostrar imagenes y textos necesarios para la interfaz de usuario. Para administrar estos recursos se utiliza la clase `AppConfig` que se encaga de cargar y proveer los datos guardados en los archivos.

A continuación hay algunos ejemplos de como se utilizan:

**Cargar los archivos**

```dart
AppConfig.initAssets();
```

**Obtener textos**

```dart
AppConfig.getString('welcome');
```

**Obtener imágenes**
```dart
AppConfig.getImage('welcomeIllustrationPng');
```

## Accesibilidad

La accesibilidad es crucial para asegurar que nuestra aplicación sea utilizable por todas las personas, incluidas aquellas con discapacidades.

### Títulos

El texto debe ser legible y escalable. Envolvemos los widgets con `Semantics` para describir su propósito cuando sea necesario.

```dart
Semantics(
  label: semantics.cartTitle.label, // Gestiona los productos de tu carrito
  sortKey: OrdinalSortKey(semantics.cartTitle.order),
  excludeSemantics: true,
  focused: true,
  child: Row(
    children: [
      const FakeIcon(
        Icons.shopping_cart_outlined,
        size: 32.0,
      ),
      const FakeSpacerS(axis: FakeSpacerAxis.x),
      Flexible(
        child: FakeTextHeading3(
          StringValue.myCart, // Mi carrito
          weight: FontWeight.w600,
        ),
      ),
    ],
  ),
)
```

### Cards

Las acciones deben estar bien descritas para que el usuario pueda ejecutarlas de forma efectiva. En este caso algunas cards fueron provistas con atributos que permiten añadir accesibilidad a sus elementos accionables.

```dart
FakeShoppingCartCard(
  imageUrl: product.image,
  title: product.title, // Camiseta roja
  price: product.price,
  deleteButtonText: StringValue.delete, // Eliminar
  deleteSemanticsLabel: '${semantics.deleteButton.label} ${product.title}', // Eliminar producto Camiseta roja
  removeSemanticsLabel: semantics.removeButton.label, // Disminuir cantidad en 1
  addSemanticsLabel: semantics.addButton.label, // Aumentar cantidad en 1
  inputSemanticsLabel: semantics.quantityInput.label, // Modificar la cantidad
  quantityValue: product.quantity.toString(),
  onDeleteButtonPressed: () {
    viewModel.onRemoveProduct(product.productId);
  },
  onQuantityChanged: (value) {},
  onAddButtonPressed: () {},
  onRemoveButtonPressed: () {},
)
```

### Inputs y AppBars

Los campos de entrada (FakeFormField) deben ser claramente identificables y tener etiquetas descriptivas. Además, al combinarse con widgets como el AppBar las posibles acciones deben ser claras para brindar una experiencia fluida.

```dart
FakeSearchAppBar(
  key: KeyValue.searchQueryInput,
  hintText: StringValue.searchByNameOrDescription, // Busca por nombre o descripción...
  showBackButton: true,
  semanticLabel: semantics.searchBarHint.label, // Toca dos veces el ícono de lupa para realizar la busqueda
  semanticsSortKey: OrdinalSortKey(semantics.searchBarHint.order),
  semanticFocused: true,
  onSubmit: viewModel.onSearchProducts,
)
```
### Pruebas de Accesibilidad

Es fundamental realizar pruebas de accesibilidad para verificar que todos los elementos sean accesibles. Usamos **TalkBack** en un emulador de Android para verificar la usabilidad de todas las vistas y garantizar su correcto funcionamiento de cara al usuario final.

## Diagrama de Flujo

![Diagrama de flujo Fake Store](https://github.com/chrisr04/fake_store_app/assets/47868395/8750dfc4-9da6-4623-895f-cbeb26e6803f)


## Demo

[Video de demostración](https://drive.google.com/file/d/1fPq1icDQr4kBA2Fsanu8oFlL4eb_d0li/view?usp=sharing)