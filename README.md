# Movie-iOS-App

Muestra un listado de películas clasificadas en tres categorías, Popular, Top Rated y Upcoming.

La carga de información se hace a través de un API para luego ser almacenada en base de datos local para su posterior uso offline. 
Las imágenes que se van cargando también son almacenadas con el fin de ser mostradas en caso de perder conexión a internet

En la vista principal se puede hacer una búsqueda por nombre de película que funciona de manera online y offline.

Al pulsar cada película se puede ir a la vista de detalle donde se mostrará una imagen adicional, añó de lanzamiento, puntaje y resumen.


## Estructura

La aplicación está construida sobre el patrón de arquitectura VIPER, agregando una capa adicional de servicio para la persistencia y el consumo de API.

La persistencia está administrada con RealmSwift.

Se elabora un cliente HTTP que permite realizar peticiones de manera muy cómoda mediante Alamofire, facilitando la serialización y deserialización de entidades de negocio.

Pruebas unitarias que permiten comprobar la estabilidad de la aplicación.

Cada pantalla está conformada por un módulo de VIPER que contine sus respectivos protocol, view, presenter, interactor, router y data manager


