@regresion
Feature: Automatizar backend - Store (PetStore)
  Background:
    * url apiPetStore
    * def jsonCrearPedido = read('classpath:examples/JsonData/Store/crearPedido.json')
    #* def jsonCrearOrder = read('classpath:examples/JsonData/store/crearOrder.json')
    #* def jsonCrearOrderInvalida = read('classpath:examples/JsonData/store/crearOrderInvalida.json')


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





