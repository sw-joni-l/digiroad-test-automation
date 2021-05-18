*** Settings ***
Documentation       Pageobject for Ajoneuvokohtaiset rajoitukset

*** Keywords ***

Ajoneuvokohtaiset_rajoitukset_1  [arguments]  ${testipaikka}
    Siirry Testipaikkaan                                ${TL_Ajoneuvokohtaiset_rajoitukset_RB}  ${Testipaikka}
    Zoomaa kartta                                       1  20 m
    Odota sivun latautuminen
    Click Element At Coordinates                        ${Kartta}  0  20
    Wait Until Element Is Visible                       ${FA_otsikko}

    Log  Tarkistetaan kentät
    Element Should Contain                              ${FA_linkkien_lukumaara}    4
    Element Should Contain                              ${FA_Rajoitus}              Rajoitus: Moottoriajoneuvo
     
    Element Should Contain  css=.form-control-static.existing-prohibition > .validity-period-group > ul > li:nth-child(1)  Ma–Pe 22:00 – 6:00
    Element Should Contain  css=.form-control-static.existing-prohibition > .validity-period-group > ul > li:nth-child(2)  La 22:00 – 6:00
    Element Should Contain  css=.form-control-static.existing-prohibition > .validity-period-group > ul > li:nth-child(3)  Su 22:00 – 6:00

    Click Element At Coordinates                        ${Kartta}  0  -10
    Double Click Element At Coordinates                 ${Kartta}  0  20
    Element Should Contain                              ${FA_linkkien_lukumaara}    1

Ajoneuvokohtaiset_rajoitukset_2  [arguments]  ${testipaikka}
    Siirry Testipaikkaan                                ${TL_Ajoneuvokohtaiset_rajoitukset_RB}  ${Testipaikka}
    Zoomaa kartta                                       1  20 m

    Tarkista Rajoitukset

    Log  Luodaan koko valitulle tielinkille rajoitus.
    Siirry Muokkaustilaan
    Click Element                                       css=.form-control.select
    Click Element                                       css=select > option:nth-child(2)
    Wait Until Element Is Visible                       css=.form-group.new-validity-period .form-control
    Click Element                                       css=.form-group.new-validity-period .form-control
    Click Element                                       css=.form-group.new-validity-period .form-control option:nth-child(3)
    #Pause Execution
    Click Element                                       css=.form-group.new-exception
    Click Element                                       css=.form-group.new-exception .form-control option:nth-child(2)
    Input Text                                          css=.form-control.additional-info  Testi
    
    Click Element                                       ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible                   ${Spinner_Overlay}
    Odota sivun latautuminen

    Log  Tarkistetaan asetetut rajoitukset
    Siirry Katselutilaan
    Click Element At Coordinates                        ${Kartta}  0  20
    Wait Until Element Is Visible                       ${FA_otsikko}
    #Pause execution
    Element Should Contain                              css=.validity-period-group ul li  La 0:00 – 24:00
    Element Should Contain                              css=.exception-group ul li  Huoltoajo
    Element Should Contain                              css=.additionalInfo-group ul  Testi
    Click Element At Coordinates                        ${Kartta}  50  20

    Tarkista Rajoitukset





##########################
### Sisäiset Keywordit ###
##########################

Tarkista Rajoitukset
    Log  Tarkistetaan onko linkinllä valmiiksi rajoituksia. Jos on, niin rajoitukset poistetaan.
    Click Element At Coordinates  ${Kartta}  0  20
    Wait Until Element Is Visible  ${FA_otsikko}
    ${status}=  Run Keyword And Return Status  Element Should Not Be Visible  ${FA_Rajoitus}

    Run Keyword If  ${status}==False  Poista Rajoitukset

Poista Rajoitukset
    Click Element  ${Siirry muokkaustilaan}
    Click Element  ${FA_Poista_rajoitus}
    Click Element  ${FA_footer_Tallenna}
    Wait Until Element Is not Visible  ${Spinner_Overlay}
    Odota sivun latautuminen
    Click Element  ${Siirry katselutilaan}



*** Variables ***
${FA_linkkien_lukumaara}                css=div:nth-child(3) > p
${FA_Rajoitus}                          css=.form-control-static.existing-prohibition > h4
${FA_Rajoitukse_Voimassaoloaika}        css=.form-control-static.existing-prohibition > .validity-period-group > ul > li:nth-child(1)
${FA_Poista_rajoitus}                   css=ul.edit-control-group > li:nth-child(1) > div > button
