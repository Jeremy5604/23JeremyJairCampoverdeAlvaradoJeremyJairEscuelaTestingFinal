@regresion
Feature: Automatizar backend - Users (PetStore)
  Background:
    * url apiPetStore
    * def jsonCrearUsuario = read('classpath:examples/JsonData/User/crearUsuario.json')


  @Test-1 @happypath
  Scenario: Crear una lista de usuario(1 o más)
    Given path 'user','createWithList'
    And request jsonCrearUsuario
    When method post
    Then status 200
    And match response == { code: '#number', type: '#string', message: '#string' }

