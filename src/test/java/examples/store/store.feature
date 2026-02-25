@regresion
Feature: Automatizar backend - Store (PetStore)
  Background:
    * url apiPetStore
    #* def jsonCrearOrder = read('classpath:examples/JsonData/store/crearOrder.json')
    #* def jsonCrearOrderInvalida = read('classpath:examples/JsonData/store/crearOrderInvalida.json')


  @Test-1 @happyPath
  Scenario:Retorna el inventario de mascotas por el estado
    Given path 'store','inventory'
    When method get
    Then status 200


""