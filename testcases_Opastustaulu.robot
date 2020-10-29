# Matti Telenius        Sitowise Oy     2019

*** Variables ***


*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            variables.robot

Test Setup          Testin Aloitus



*** Test Cases ***
Opastustaulu 1
    [Tags]              Opastustaulu  Mandatory
    [Documentation]      Opastustaulu, selain: ${BROWSER}
    ...  - Kartalla näkyvät  Opastustaulu kun mittakaava on 1:20000 tai tarkempi.
    PO_Opastustaulu.Opastustaulu_1  6738086,251274

Opastustaulu 2
    [Tags]              Opastustaulu  Mandatory
    [Documentation]      Opastustaulu, selain: ${BROWSER}
    ...  - Tarkistetaan olemassa olevaa  Opastustaulut - Formin id
    PO_Opastustaulu.Opastustaulu_2  6738106,251254

Opastustaulu 3
    [Tags]              Opastustaulu  Mandatory
    [Documentation]      Opastustaulu, selain: ${BROWSER}
    ...   -  Opastustaulu muokkaus.
    PO_Opastustaulu.Opastustaulu_3  6738106,251254

Opastustaulu 4
    [Tags]              Opastustaulu  Mandatory
    [Documentation]      Opastustaulu, selain: ${BROWSER}
    ...   - Luodaan uusi kunnan ylläpitämä  Opastustaulu ja tarkistetaan formin validoinnit, sekä tietojen tallentuminen.
    PO_Opastustaulu.Opastustaulu_4  6737734, 251162
