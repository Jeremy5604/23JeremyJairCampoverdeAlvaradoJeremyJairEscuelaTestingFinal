# 🧪 Automatización de Casos de Prueba de API - Swagger Petstore (Karate)

## 1. Descripción

Este proyecto contiene la automatización de pruebas para los contratos del módulo **Store** y **User** del API pública **Swagger Petstore**:

🔗 https://petstore.swagger.io/

---

## 2.  Cobertura de Automatización

###  STORE
Se automatizaron:

- GET /store/inventory
- POST /store/order
- GET /store/order/{orderId}
- DELETE /store/order/{orderId}

Incluye:
-  Happy Path
-  Unhappy Path 
---

###  USER
Se automatizaron:

- POST /user
- GET /user/{username}
- PUT /user/{username}
- DELETE /user/{username}
- GET /user/login
- GET /user/logout
- POST /user/createWithArray
- POST /user/createWithList

Incluye:
-  Happy Path
-  Unhappy Path


---

##  2. Configuración de Entornos

Las URLs base se configuran en:


karate-config.js


Ejemplo:

```javascript
function fn() {
  var env = karate.env;
  if (!env) env = 'dev';

  var apiPetStore;

  if (env == 'dev') {
    apiPetStore = 'https://petstore.swagger.io/v2';
  }

  return {
    apiPetStore: apiPetStore
  };
}
```
La URL no está siendo mostrada en los feature files.

- Ejecución del Proyecto

--- Ejecutar solo Store

mvn clean test -Dtest=StoreRunner  -Dkarate.options="--tags @regresion" -Dkarate.env=cert

--- Ejecutar solo User

mvn clean test -Dtest=UsersRunner  -Dkarate.options="--tags @regresion" -Dkarate.env=cert


-  Manejo de Tags

Cada escenario incluye:

@regresion

@happypath

@unhappyPath

@Test-X

Esto permite ejecutar pruebas específicas por tag.

3. Reportes

Karate genera reportes automáticos en:

target/karate-reports/karate-summary.html

Abrir el archivo HTML en el navegador después de la ejecución.

Consideraciones Importantes

La API Swagger Petstore es una API de prueba.

Algunos endpoints no validan correctamente reglas de negocio.

Los Unhappy Path fueron diseñados en base al comportamiento real observado.

Los datos dinámicos evitan colisiones entre ejecuciones.

