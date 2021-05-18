*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus



*** Test Cases ***
Ajoneuvokohtaiset rajoitukset 1
    [Tags]              Ajoneuvokohtaiset Rajoitukset
    [Documentation]     
    KW_AKR.Ajoneuvokohtaiset_rajoitukset_1  6672408, 384223

Ajoneuvokohtaiset rajoitukset 2
    [Tags]              Ajoneuvokohtaiset Rajoitukset
    KW_AKR.Ajoneuvokohtaiset_rajoitukset_2  6852309, 387166