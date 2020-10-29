*** Settings ***
Documentation       A test suite setup for digiroad project
Resource            variables.robot
Resource            Pageobject/PO_MainPage.robot
Resource            Pageobject/PO_Tielinkit.robot
Suite Setup         LoginToLivi
Suite Teardown      run keywords  Close all Browsers  Stop Remote Server