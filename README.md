# Movie-iOS-App

Muestra un listado de películas clasificadas en tres categorías, Popular, Top Rated y Upcoming.

La carga de información se hace a través de un API para luego ser almacenada en base de datos local para su posterior uso offline. 

Las imágenes que se van cargando también son almacenadas con el fin de ser mostradas en caso de perder conexión a internet

En la vista principal se puede hacer una búsqueda por nombre de película que funciona de manera online y offline.

Al pulsar cada película se puede ir a la vista de detalle donde se mostrará una imagen adicional, año de lanzamiento, puntaje y resumen.


## Estructura

La aplicación está construida sobre el patrón de arquitectura VIPER, agregando una capa adicional de servicio para la persistencia y el consumo de API.

La persistencia está administrada con RealmSwift.

Se elabora un cliente HTTP que permite realizar peticiones de manera muy cómoda mediante Alamofire, facilitando la serialización y deserialización de entidades de negocio.

Pruebas unitarias que permiten comprobar la estabilidad de la aplicación.

Cada pantalla está conformada por un módulo de VIPER que contine sus respectivos protocols, view, presenter, interactor, router y data manager


En la capa de vista tenemos los archivos HomeView.swift, DetailView.swift, MovieViewCell.swift, MovieViewCell.xib y Main.storyboard. Estas tienen como responsabilidad mostrar los datos al usuario y enviar información hacia el presenter.

En la capa de presentación tenemos los archivos HomePresenter.swift y DetailPresenter.swift. Estas tienen como responsabilidad definir la lógica de presentación de las vistas. Define si debe usar el interactor o el router en cada interacción del usuario.

En la capa de negocio están los interactors, quienes se encargan de definir la lógica de negocio y recuperar información por medio de los data managers, ya sea de manera local o remota. Pasan la información recuperada en forma de Entidades al presenter.

Los routers se encargan de la navegación entre vistas, reciben información desde el presenter.

La Capa de Servicio contiene la lógica de recuperación de datos a través de una subcapa de red (Cliente HTTP) y una subcapa de persistencia (Base de datos)


## Principio de responsabilidad única:

Indica que debemos separar las responsabilidades de funcionamiento de un software. Tiene como propósito evitar que una clase o módulo tenga dos o más responsabilidades. Cada responsabilidad conlleva a un motivo para cambiar y este principio establece que debe haber uno solo.

## Código limpio

Un buen código debe ser fácil de leer, entender y modificar, se consigue mediante un proceso contínuo de refactorización que se asegura con un buen set de pruebas unitarias.

- Deben seguirse las convenciones del lenguaje.
- Los nombres de variables deben ser concisos y dicientes.
- Las funciones deben ser pequeñas y especializadas.
- Los comentarios deben dejarse solamente cuando sea necesario. El código debe ser tan fácil de leer que los comentarios no sean necesarios.
- Se debe respetar el formato de indentación.
- Tests unitarios.
- Debe haber un solo nivel de abstracción para cada clase permietiendo una alta cohesión.
- Debe evitarse dejar hardcoded strings.
