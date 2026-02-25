@regresion
Feature: Automatizar backend - Users (PetStore)
  Background:
    * url apiPetStore
    * def jsonCrearUsuario = read('classpath:examples/JsonData/User/crearUsuario.json')
    * def jsonActualizarUsuario = read('classpath:examples/JsonData/User/actualizarUsuario.json')


  @Test-1 @happypath
  Scenario: Crear una lista de usuario(1 o más)
    Given path 'user','createWithList'
    And request jsonCrearUsuario
    When method post
    Then status 200
    And match response == { code: '#number', type: '#string', message: '#string' }

  @Test-2 @happypath
  Scenario: Consultar usuario por username
   # Requiere crear primero, por eso llamo a ejecutar el test-1
    * call read('classpath:examples/user/users.feature@Test-1')

    * def username = jsonCrearUsuario[0].username
    Given path 'user', username
    When method get
    Then status 200
    And match response.username == username
    And match response.id == '#number'
    And match response.email == '#string'
    And match response.userStatus == '#number'

  @Test-3 @happypath
  Scenario: Actualizar usuario por username
    #Requiere crear primero el usuario, me sirve para que el caso de prueba sea independiente
    #si se quiere ejecutar solo @Test-3 y no regresion
    * call read('classpath:examples/user/users.feature@Test-1')
    * def username = jsonCrearUsuario[0].username
    Given path 'user', username
    And request jsonActualizarUsuario
    When method put
    Then status 200


