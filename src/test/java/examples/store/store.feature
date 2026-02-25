@regresion
Feature: Automatizar backend - Store (PetStore)
  Background:
    * url apiPetStore
    * def jsonCrearPedido = read('classpath:examples/JsonData/Store/crearPedido.json')



  @Test-1 @happyPath
  Scenario:Retorna el inventario de mascotas por el estado
    Given path 'store','inventory'
    When method get
    Then status 200


  @Test-2 @happyPath
  Scenario:Hacer pedido de una mascota
    Given path 'store','order'
    And request jsonCrearPedido
    When method post
    Then status 200


  @Test-3 @happyPath
  Scenario: Encontrar orden de compra por ID
    * def orderId = jsonCrearPedido.id
    Given path 'store', 'order', orderId
    When method GET
    Then status 200


  @Test-4 @happyPath
  Scenario: Eliminar orden de compra por ID
    * def orderId = jsonCrearPedido.id
    Given path 'store', 'order', orderId
    When method DELETE
    Then status 200

  @Test-5 @unhappypath
  Scenario: Consultar orden con orderId inexistente debe fallar (404)
    Given path 'store', 'order', 99999999
    When method get
    Then status 404
    And match response.message contains 'Order not found'


  @Test-6 @unhappyPath
  Scenario: Consultar orden con orderId extremadamente grande no existe (404)
    Given path 'store', 'order', 999999999999
    When method get
    Then status 404


  @Test-7 @unhappyPath
  Scenario: Consultar orden con orderId decimal debe fallar (404)
    Given path 'store', 'order', 1.5
    When method get
    Then status 404

  @Test-8 @unhappyPath
  Scenario: Eliminar orden con orderId extremadamente grande no existe (404)
    Given path 'store', 'order', 888888888888
    When method delete
    Then status 404

  @Test-9 @unhappyPath
  Scenario: Eliminar orden con orderId decimal debe fallar (404)
    Given path 'store', 'order', 2.7
    When method delete
    Then status 404

  @Test-10 @unhappyPath
  Scenario: Consultar orden con orderId NO numérico debe fallar (404)
    Given path 'store', 'order', 'abc'
    When method get
    Then status 404
    And match response.code == 404
    And match response.message contains 'NumberFormatException'
    And match response.message contains 'abc'

  @Test-11 @unhappyPath
  Scenario: Consultar orden con orderId negativo no existe (404)
    Given path 'store', 'order', -1
    When method get
    Then status 404
    And match response.message contains 'Order not found'




