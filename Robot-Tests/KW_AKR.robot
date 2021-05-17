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




*** Variables ***
${FA_linkkien_lukumaara}                css=div:nth-child(3) > p
${FA_Rajoitus}                          css=.form-control-static.existing-prohibition > h4
${FA_Rajoitukse_Voimassaoloaika}        css=.form-control-static.existing-prohibition > .validity-period-group > ul > li:nth-child(1)
