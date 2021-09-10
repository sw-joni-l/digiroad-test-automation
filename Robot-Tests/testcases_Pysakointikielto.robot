*** Settings ***
Documentation       Testit Pysäköintikiellolle
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus



*** Test Cases ***
Pysäköintikielto 1
    KW_Pysakointikielto.Pysakointi_1  ${TL_Pysäköintikielto_RB}  6939647, 349559