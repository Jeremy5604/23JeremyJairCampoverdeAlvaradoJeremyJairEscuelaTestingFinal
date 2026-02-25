@regresion
Feature: Automatizar backend - Users (PetStore)
  Background:
    * url apiPetStore
    * def jsonCrearUsuario = read('classpath:examples/JsonData/User/crearUsuario.json')
    * def jsonActualizarUsuario = read('classpath:examples/JsonData/User/actualizarUsuario.json')
    * def jsonCrearListaUsuarios = read('classpath:examples/JsonData/User/crearListaUsuarios.json')


  @Test-1 @happypath
  Scenario: Crear un usuario
    Given path 'user'
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


  @Test-4 @happypath
  Scenario: Eliminar usuario por username
    #Requiere crear primero el usuario
    * call read('classpath:examples/user/users.feature@Test-1')
    * def username = jsonCrearUsuario[0].username
    Given path 'user', username
    When method delete
    Then status 200


    # Validación: ya no existe
    Given path 'user', username
    When method get
    Then status 404



  @Test-5 @happypath
  Scenario: Inicia sesión como usuario en el sistema
    #Requiere crear primero el usuario
    * call read('classpath:examples/user/users.feature@Test-1')
    * def username = jsonCrearUsuario[0].username
    * def password = jsonCrearUsuario[0].password
    Given path 'user', 'login'
    And param username = username
    And param password = password
    When method get
    Then status 200


  @Test-6 @happypath
  Scenario: Cierra sesión de usuario logueado
    Given path 'user', 'logout'
    When method get
    Then status 200




  #Este caso de prueba es igual a test-1 pero en este se va a registrar varios usuarios a la vez
  @Test-7 @happypath
  Scenario: Crear usuarios con List|Array (createWithList y createWithArray)
    #Con createWithList
    Given path 'user', 'createWithList'
    And request jsonCrearListaUsuarios
    When method post
    Then status 200

    #Con createWithArray
    Given path 'user','createWithArray'
    And request jsonCrearUsuario
    When method post
    Then status 200

  @Test-8 @unhappyPath
  Scenario: Consultar usuario inexistente
    Given path 'user', 'usuario_que_no_existe_999999'
    When method get
    Then status 404
    And match response.message contains 'User not found'


  @Test-9 @unhappyPath
  Scenario: Consultar usuario con username con espacios no existe (404)
    Given path 'user', 'usuario con espacios'
    When method get
    Then status 404
