*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus

*** Test Cases ***
Liikennemerkit 1
    [Tags]              Merkki  
    [Documentation]     Liikennemerkit, selain: ${BROWSER}
    ...  
    KW_Liikennemerkit.Liikennemerkit 1  7320569, 599457

Esterakennelma 2
    [Tags]              Merkki  Mandatory
    [Documentation]     Esterakennelma, selain: ${BROWSER}
    ...  - Tarkistetaan kaikki eri tyyppiset liikennemerkit
    KW_Liikennemerkit.Liikennemerkit 2  6715385, 243668  ${LM_Varoitusmerkit}   Varoitusmerkit
    KW_Liikennemerkit.Liikennemerkit 2  7320750, 599530  ${LM_Etuajo-oikeus}    Etuajo-oikeus ja väistämismerkit
    KW_Liikennemerkit.Liikennemerkit 2  7320796, 599590  ${LM_Kielto}           Kielto- ja rajoitusmerkit
    KW_Liikennemerkit.Liikennemerkit 2  7320761, 599545  ${LM_Määräysmerkit}    Määräysmerkit
    KW_Liikennemerkit.Liikennemerkit 2  7320120, 599020  ${LM_Sääntömerkit}     Sääntömerkit
    KW_Liikennemerkit.Liikennemerkit 2  7252914, 514594  ${LM_Opastusmerkit}    Opastusmerkit
    KW_Liikennemerkit.Liikennemerkit 2  6671427, 384107  ${LM_Palvelukohteet}   Palvelukohteet
    KW_Liikennemerkit.Liikennemerkit 2  6670501, 385948  ${LM_Muut_merkit}      Muut merkit