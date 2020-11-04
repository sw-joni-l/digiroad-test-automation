# Matti Telenius        Sitowise Oy     2019

*** Variables ***


*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            variables.robot

Suite Setup         LoginToLivi
Suite Teardown      Close Browser

Test Setup          Testin Aloitus



*** Test Cases ***
Esterakennelma 1
    [Tags]              Este  Mandatory  Sikuli
    [Documentation]     Esterakennelma, selain: ${BROWSER}
    ...  - Kartalla näkyvät Esterakennelma kun mittakaava on 1:20000 tai tarkempi.
    PO_Este.Este_1  6711750,240690

Esterakennelma 2
    [Tags]              Este  Mandatory  Sikuli
    [Documentation]     Esterakennelma, selain: ${BROWSER}
    ...  - Tarkistetaan olemassa olevaa Esterakennelmaa - Formin id
    PO_Este.Este_2  6711833,239489

Esterakennelma 3
    [Tags]              Este  Mandatory  Sikuli
    [Documentation]     Esterakennelma, selain: ${BROWSER}
    ...   - Esterakennelman väri muuttuu tyypin mukaan.
    PO_Este.Este_3  6818415,341991

Esterakennelma 4
    [Tags]              Este  Mandatory
    [Documentation]     Esterakennelma, selain: ${BROWSER}
    ...   - Luodaan uusi kunnan ylläpitämä esterakennelma ja tarkistetaan formin validoinnit, sekä tietojen tallentuminen.
    PO_Este.Este_4  6707097, 251494
