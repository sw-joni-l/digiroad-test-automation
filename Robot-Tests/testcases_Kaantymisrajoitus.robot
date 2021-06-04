*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus


*** Test Cases ***
Kääntymisrajoitus 1
    KW_Kaantymisrajoitus.KR_1  6671992, 385433

Kääntymisrajoitus 2
    KW_Kaantymisrajoitus.KR_2  6711114, 238672

Kääntymisrajoitus 3
    KW_Kaantymisrajoitus.KR_3  6750859, 480701