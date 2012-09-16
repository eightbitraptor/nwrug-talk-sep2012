Feature: Installing a Web Sever
  Background:
    Given I have a running Ubuntu VM
    And I have puppet installed

  Scenario: Installing nginx
    Then I should have nginx installed
    And nginx should be running
  
  Scenario: Installing Mysql
    Then I should have mysql installed
    And mysql should be running

