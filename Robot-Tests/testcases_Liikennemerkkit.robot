*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus

*** Test Cases ***
#Liikennemerkit 1
#    [Tags]              Merkki  
#    [Documentation]     Liikennemerkit, selain: ${BROWSER}
#    ...  
#    KW_Liikennemerkit.Liikennemerkit 1  7320569, 599457