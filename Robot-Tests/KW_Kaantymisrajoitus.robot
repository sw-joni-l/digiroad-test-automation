*** Settings ***





*** Keywords ***
KR_1  [arguments]  ${testipaikka}
    Siirry Testipaikkaan                                ${TL_Kääntymisrajoitus_RB}  ${Testipaikka}
    Zoomaa kartta                                       1  20 m
    Odota sivun latautuminen
    Click Element At Coordinates                        ${Kartta}  0  20
    Wait Until Element Is Visible                       ${FA_otsikko}

    Log  Tarkistetaan kentät
    Element should Contain                              css=.form-group.manoeuvre > p  442268
    Element should Contain                              css=.form-group.manoeuvre ul li:nth-child(1)  Linja-auto
    Element should Contain                              css=.form-group.manoeuvre ul li:nth-child(2)  Taksi

KR_2  [arguments]  ${testipaikka}
    Siirry Testipaikkaan                                ${TL_Kääntymisrajoitus_RB}  ${Testipaikka}
    Zoomaa kartta                                       1  20 m
    Odota sivun latautuminen
    Click Element At Coordinates                        ${Kartta}  0  20
    Wait Until Element Is Visible                       ${FA_otsikko}

    Log  Tarkistetaan kentät
    #Pause Execution
    Element should Contain                              css=#feature-attributes-form > div > div > div:nth-child(4) > p  LINK ID: 5790711
    Element should Contain                              css=#feature-attributes-form > div > div > div:nth-child(5) > p  LINK ID: 5790692

KR_3  [arguments]  ${testipaikka}
    Siirry Testipaikkaan                                ${TL_Kääntymisrajoitus_RB}  ${Testipaikka}
    Zoomaa kartta                                       1  20 m
    Odota sivun latautuminen

    Tarkista Kääntymisrajoitus

    Siirry Muokkaustilaan
    Click Element At Coordinates                        ${Kartta}  0  20
    Wait Until Element Is Visible                       ${FA_otsikko}

    Log  Valitaan Tielinkki jolle luodaan Kääntymisrajoitus
    Wait Until Element Is Visible                       ${FA_Uusi_Kääntymisrajoitus}
    Click Element                                       ${FA_Uusi_Kääntymisrajoitus}
    #Click Element                                       css=.new-validity-period .form-control.select
    #Click Element                                       css=.new-validity-period .form-control.select option:nth-child(3)

    Log  Asetetaan rajoituksen lisäsäännöt
    Click Element                                       ${FA_Uusi_Ajoneuvopoikkeus}
    Click Element                                       ${FA_Uusi_Ajoneuvopoikkeus_DDM1}
    Click Element                                       ${FA_Uusi_Ajoneuvopoikkeus}
    Click Element                                       ${FA_Uusi_Ajoneuvopoikkeus_DDM2}
    Click Element                                       ${FA_Rajoituksen_Voimassaoloaika}
    Click Element                                       ${FA_Rajoituksen_Voimassaoloaika_DDM}
    Click Element                                       ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible                   ${Spinner_Overlay}

    Siirry Katselutilaan
    Click Element At Coordinates                        ${Kartta}  0  20
    Wait Until Element Is Visible                       ${FA_otsikko}
    Page Should Contain                                 LINK ID: 2034711
    Element Should Contain                              css=.manoeuvre .exception-group ul li:nth-child(1)   Huoltoajo
    Element Should Contain                              css=.manoeuvre .exception-group ul li:nth-child(2)   Tontille ajo
    Element Should Contain                              css=.form-group.existing-validity-period  La 0:00 – 24:00


    Poista Kääntymisrajoitus
    Click Element At Coordinates                        ${Kartta}  0  20
    Wait Until Element Is Visible                       ${FA_otsikko}
    Element Should Contain                              ${FA_Lisätty_Järjestelmään}  Muokattu viimeksi: / -

##########################
### Sisäiset Keywordit ###
##########################

Tarkista Kääntymisrajoitus
    Click Element At Coordinates                        ${Kartta}  0  20
    Wait Until Element Is Visible                       ${FA_otsikko}
    ${status}=  Run Keyword And Return Status   Element Should Contain  ${FA_Lisätty_Järjestelmään}  Muokattu viimeksi: / -
    Run Keyword If  ${status}==False  Poista Kääntymisrajoitus

Poista Kääntymisrajoitus
    Siirry Muokkaustilaan
    Wait Until Element Is Visible                       css=#feature-attributes-form > div > div > div:nth-child(8) > div.form-group > div > div:nth-child(2) > button
    Click Element                                       css=#feature-attributes-form > div > div > div:nth-child(8) > div.form-group > div > div:nth-child(2) > button
    Click Element                                       css=.checkbox-remove
    Click Element                                       ${FA_footer_Tallenna}
    Wait until element is not Visible                   ${Spinner_Overlay}
    Siirry Katselutilaan

*** Variables ***

${FA_Uusi_Kääntymisrajoitus}            css=#feature-attributes-form > div > div > div:nth-child(7) > div.form-group > div > div:nth-child(1) > button

${FA_Uusi_Ajoneuvopoikkeus}         css=.form-control.select.new-exception
${FA_Uusi_Ajoneuvopoikkeus_DDM1}     css=.form-control.select.new-exception option:nth-child(2)
${FA_Uusi_Ajoneuvopoikkeus_DDM2}     css=.form-control.select.new-exception option:nth-child(3)