# Matti Telenius        Sitowise Oy     2019

*** Variables ***


*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            variables.robot

Suite Setup         LoginToLivi
Suite Teardown      Close Browser

Test Setup          Testin Aloitus



*** Test Cases ***
Suojatie 1
    [Tags]              Suojatie  Mandatory  Sikuli
    [Documentation]     Suojatie, selain: ${BROWSER}
    ...  - Kartalla näkyvät Suojatie kun mittakaava on 1:20000 tai tarkempi.
    PO_Suojatie.Suojatie_1  6818879,325515

Suojatie 2
    [Tags]              Suojatie  Mandatory  Sikuli
    [Documentation]     Suojatie, selain: ${BROWSER}
    ...  - Tarkistetaan olemassa olevaa Suojatietä - Formin id
    PO_Suojatie.Suojatie_2  6818935,325475

Suojatie 3
    [Tags]              Suojatie  Mandatory  Sikuli
    [Documentation]     Suojatie, selain: ${BROWSER}
    ...   - Suojatie muokkaus.
    PO_Suojatie.Suojatie_3  6818935,325475

Suojatie 4
    [Tags]              Suojatie  Mandatory  test  Sikuli
    [Documentation]     Suojatie, selain: ${BROWSER}
    ...   - Luodaan uusi kunnan ylläpitämä Suojatie ja tarkistetaan formin validoinnit, sekä tietojen tallentuminen.
    PO_Suojatie.Suojatie_4  6818971,325271
