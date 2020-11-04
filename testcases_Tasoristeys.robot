# Matti Telenius        Sitowise Oy     2019

*** Variables ***


*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            variables.robot

Suite Setup         LoginToLivi
Suite Teardown      Close Browser

Test Setup          Testin Aloitus



*** Test Cases ***
Tasoristeys 1
    [Tags]              Tasoristeys  Mandatory  Sikuli
    [Documentation]     Rautatien tasoristeys, selain: ${BROWSER}
    ...  - Kartalla näkyvät Rautatien tasoristeys kun mittakaava on 1:20000 tai tarkempi.
    PO_Tasoristeys.Tasoristeys_1  6712170,240460

Tasoristeys 2
    [Tags]              Tasoristeys  Mandatory  Sikuli
    [Documentation]     Rautatien tasoristeys, selain: ${BROWSER}
    ...  - Tarkistetaan olemassa olevaa Rautatien tasoristeystä - Formin id
    PO_Tasoristeys.Tasoristeys_2  6712203,240427

Tasoristeys 3
    [Tags]              Tasoristeys  Mandatory  Sikuli
    [Documentation]     Rautatien tasoristeys, selain: ${BROWSER}
    ...   - Rautatien tasoristeys muokkaus.
    PO_Tasoristeys.Tasoristeys_3  6714850,229269

Tasoristeys 4
    [Tags]              Tasoristeys  Mandatory
    [Documentation]     Rautatien tasoristeys, selain: ${BROWSER}
    ...   - Luodaan uusi kunnan ylläpitämä Rautatien tasoristeys ja tarkistetaan formin validoinnit, sekä tietojen tallentuminen.
    PO_Tasoristeys.Tasoristeys_4  6714598, 228242
