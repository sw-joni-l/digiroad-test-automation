# Niko Lahtinen  Sitowise  2020

*** Variables ***


*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            variables.robot

Suite Setup         LoginToLivi
Suite Teardown      Close Browser

Test Setup          Testin Aloitus



*** Test Cases ***
Pysäkit 1
    [Tags]              JLP  Mandatory  Sikuli
    [Documentation]     Pysäkit, selain: ${BROWSER}
    ...  - Kartalla näkyvät pysäkit kun mittakaava on 1:20000 tai tarkempi.
    PO_JLP.JLP_1  6710683,255509

Pysäkit 2
    [Tags]              JLP  Mandatory
    [Documentation]     Pysäkit, selain: ${BROWSER}
    ...  - Muokataan olemassa olevaa pysäkkiä - Tarkistetaan, että pysäkin vanhaksi merkitseminen aktivoi "käytöstä poistuneet" tason.
    ...  Pysäkkiä klikkaamalla näkyy sen infokupla.
    PO_JLP.JLP_2  6706886, 253114

Pysäkit 3
    [Tags]              JLP  Mandatory  JLPuudet
    [Documentation]     Pysäkit, selain: ${BROWSER}
    ...   - Pysäkkien siirrosta yli 50m tulee popup, varmistetaan ELYn ja kuntalaisten viestit.
#   Testi              Koordinaatit     Onko ely-pysäkki
    PO_JLP.JLP_3  6710786, 241841  ei
    Testin Aloitus
    PO_JLP.JLP_3  6706716, 243306  kyllä

Pysäkit 4
    [Tags]              JLP  Mandatory  JLPuudet
    [Documentation]     Pysäkit, selain: ${BROWSER}
    ...   - Luodaan uusi kunnan ylläpitämä pysäkki ja tarkistetaan formin validoinnit, sekä tietojen tallentuminen.
    PO_JLP.JLP_4  6707097, 251494


#Pysäkit
#    [Tags]              JLP  Mandatory
#    [Documentation]     Pysäkit, selain: ${BROWSER}
#    ...   - Luodaan uusi pysäkki ja tarkistetaan formin validoinnit, sekä tietojen tallentuminen.
#    PO_JLP.JLP_

#    Normi:
#    ELY: 6707965,243161