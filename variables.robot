# Niko Lahtinen  Sitowise  2020
# pybot -d output ..\DR_RobotTestcases
*** Settings ***
#Library                     SeleniumLibrary     timeout=10.0   run_on_failure=None
Library                     SeleniumLibrary     timeout=10.0   run_on_failure=Capture Page Screenshot
Library                     Dialogs
Library                     String
Library                     SikuliLibrary
Library                     selenium_extensions.py

Resource                    c:/tools/omat/DRownvariables.robot
#Library                    DateTime
Resource                    Pageobject/PO_MainPage.robot
Resource                    Pageobject/PO_Tielinkit.robot
Resource                    Pageobject/PO_Kartta.robot
Resource                    Pageobject/PO_UI.robot
Resource                    Pageobject/PO_JLP.robot
Resource                    Pageobject/PO_Este.robot
Resource                    Pageobject/PO_Tasoristeys.robot
Resource                    Pageobject/PO_Opastustaulu.robot
Resource                    Pageobject/PO_Suojatie.robot

*** Variables ***
${BROWSER}                  CHROME
${DELAY}                    0.2

#${LOGIN URL}               https://devtest.vayla.fi/digiroad/
${LOGIN URL}                https://testiextranet.vayla.fi/digiroad/
${LiviUserNameField}        id=username
${LiviPasswordField}        id=password
${LiviLoginButton}          css=.submit
${IMAGE_DIR}                ${CURDIR}\\img

*** Keywords ***
LoginToLivi

    log to console                  ${CURDIR}
    Add Image Path                  ${IMAGE_DIR}
    Log                             ${BROWSER}
    Log                             ${LOGIN URL}
    Open Browser                    ${LOGIN URL}            ${BROWSER}
    Maximize Browser Window
    #set window size    1920   1200
    Set Selenium Speed              ${DELAY}
    wait until element is visible   ${LiviUserNameField}
    ${temp}=                        set variable            ${LOG LEVEL}
    Set Log Level                   NONE
    input password                  ${LiviUserNameField}    ${LiviUSER}
    Input Password                  ${LiviPasswordField}    ${LiviPWD}
    Click Button                    ${LiviLoginButton}
    Set Log Level                   ${temp}
    wait until element is visible   ${kartta}
    #run keyword if  '${LOGIN URL}'=='https://testiextranet.vayla.fi/digiroad/'  Sulje QA popup
    Odota sivun latautuminen
    Set Min Similarity   0.9              # Oli 0.6 tarkista toimiiko vielä

Sulje QA popup
    wait until element is visible   css=.modal-overlay.confirm-modal .btn.btn-secondary.close
    click element                   css=.modal-overlay.confirm-modal .btn.btn-secondary.close

Testin Aloitus
    Set Selenium Speed  ${DELAY}
    Go to  ${LOGIN URL}
    wait until element is visible  ${kartta}
    Odota sivun latautuminen
    #run keyword if  '${LOGIN URL}'=='https://testiextra.vayla.fi/digiroad/'  Sulje QA popup


###################
# Common keywords #
###################

#Verifies element text is not equal to given string
VerifyTextNOT          [Arguments]  ${locator}    ${context}
    ${LocatorValue}=                SeleniumLibrary.Get Text   ${locator}
    should not be equal as strings  ${LocatorValue}             ${context}

#Verifies elements value attribute against given value
VerifyValue         [Arguments]     ${locator}    ${context}
    ${LocatorValue}=                Get value                   ${locator}
    Should Be Equal As Strings      ${LocatorValue}             ${context}

#Verifies value of elements attribute against given value
VerifyAttribute     [Arguments]     ${locator}    ${context}
    ${LocatorValue}=                Get Element Attribute       ${locator}
    Should Be Equal                 ${LocatorValue}             ${context}

Odota sivun latautuminen
    FOR  ${i}  IN RANGE  10
      ${status}  execute javascript   return jQuery.active
      Run Keyword If              '${status}' == '${0}'  Exit For Loop
      sleep  1 sec
    END
    #Wait Until Keyword Succeeds  10 min  30 sec  Element Should Not Be Visible  class=loadingBar

testklick
    [documentation]     Kutsutaan testklick, voidaan hakea testissä clikkaus paikka kohdille
    tklick    0   0
    FOR   ${i}   IN RANGE  2  35   3
       tklick    ${i}    ${i}
       tklick   -${i}   -${i}
       tklick    ${i}   -${i}
       tklick   -${i}    ${i}
       tklick    ${i}     0
       tklick   -${i}     0
       tklick     0      ${i}
       tklick     0     -${i}
    END
    
tklick   [arguments]      ${x}   ${y}
    click element at coordinates                ${kartta}  ${x}   ${y}
    ${t} =   run keyword and return status   wait until element is visible       ${FA_otsikko}   timeout=1
    #exit for loop if     ${t} == True
    run keyword if     ${t} == True      log to console   ${x}
    run keyword if     ${t} == True      log to console   ${y}