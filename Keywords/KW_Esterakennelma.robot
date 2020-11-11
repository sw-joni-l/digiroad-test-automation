
*** Settings ***
Documentation       Keywords for obstacles (Esterakennelma)

*** Variables ***
${LocatorForDDM}                                css=#feature-attributes .form-group.editable select:first-of-type
${LocatorForDDM_Selection}                      css=select > option:nth-child(2)
${Esteen_poisto}                                Haluatko varmasti poistaa esteen?
${FA_Este_Poista_chkbx}                         id=delete-checkbox
${FA_Esterakennelma_tyyppi}                     css=#feature-attributes-form > div > div > div.form-group.editable.form-obstacle > p


*** Keywords ***

Este_1  [arguments]  ${testipaikka}
    Log  Zoomataan testipaikkaan, tarkistetaan että kohteessa on jotain tietoa
    Siirry Testipaikkaan                ${TL_Esterakennelma_RB}  ${testipaikka}

    #Click Element At Coordinates        ${Kartta}  0  20
    #Wait Until Element contains         ${FA_Lisätty_Järjestelmään}  Lisätty järjestelmään:
    Valitse Esterakennelma
    Click Element At Coordinates        ${Kartta}  0  -100
    # Alla oleva ratkaisu tarkistaa onko elementti valittuna kartalta
    ${status}=  Run Keyword And Return Status  Wait Until Element contains  ${FA_Muokattu_viimeksi}  Lisätty järjestelmään:  2 s
    Should Be Equal                     '${status}'  'False'
    #Element should be visible             ${FA_Muokattu_viimeksi}


    Log  zoomataan kauemmas ja varmistetaan, ettei esterakennelma ole enää näkyvissä
    set selenium speed                  0.3
    Repeat Keyword                      4 times  click element  ${zoombar_minus}
    Set Selenium Speed                  ${DELAY}
    Click Element At Coordinates        ${Kartta}  0  20
    ${status}=  Run Keyword And Return Status  Wait Until Element contains  ${FA_Muokattu_viimeksi}  Lisätty järjestelmään:  2 s
    Should Be Equal                     '${status}'  'False'


Este_2  [arguments]  ${testipaikka}  ${Este_tyyppi}
    Log  klikataan Esterakennelman kohdalta
    Siirry Testipaikkaan                ${TL_Esterakennelma_RB}  ${testipaikka}
    Valitse Esterakennelma

    Log  Käydään läpi eri esterakennelmien tyypit

    Run Keyword if  '${Este_tyyppi}'=='Geometrian ulkopuolella'  
    ...  Element Should Contain  ${FA_Geometria_Notifikaatio}  tarkista ja korjaa

    Run Keyword if  '${Este_tyyppi}'=='Suljettu yhteys'  
    ...  Element Should Contain  ${FA_Esterakennelma_tyyppi}  Suljettu yhteys

    Run Keyword if  '${Este_tyyppi}'=='Avattava puomi'  
    ...  Element Should Contain  ${FA_Esterakennelma_tyyppi}  Avattava puomi

    click element at coordinates                ${kartta}   0  -100


Este_3  [arguments]  ${testipaikka}  ${Este_tyyppi}
    Log  Siirrytään muokkaustilaan, valitaan esterakennelma ja muokataan sitä.
    wait until element is visible               ${valitse tietolaji}
    Siirry Testipaikkaan                        ${TL_Esterakennelma_RB}  ${testipaikka}
    Valitse Esterakennelma
    Element Should Contain                      ${FA_Esterakennelma_tyyppi}  ${Este_tyyppi}

    Log  Siirretään setettä ja tarkistetaan, että siirron jälkeen tulee muokkausvaroitus.
    Siirry muokkaustilaan
    Siirrä este                                 -100  25
    Click element at coordinates                ${Kartta}  100  100
    Wait Until Element Is Visible               ${Muokkausvaroitus}
    Click Button                                ${Muokkausvaroitus_Sulje_btn}
    click element                               ${FA_footer_Peruuta}
    Sleep  5 s

    Log  Tarkistetaan, että ominaisuustietojen muokkauksesta tulee muokkausvaroitus.
    #click element at coordinates                ${kartta}   0   20
    #wait until element is visible               ${FA_otsikko}
    DDM_tietolajit
    Click element at coordinates                ${Kartta}  100  100
    Wait Until Element Is Visible               ${Muokkausvaroitus}
    Click Button                                ${Muokkausvaroitus_Sulje_btn}
    click element                               ${FA_footer_Peruuta}

Este_4  [arguments]  ${testipaikka}
    ${date}=  Get Current Date                  result_format=%d.%m.%Y
    Siirry Testipaikkaan                        ${TL_Esterakennelma_RB}  ${testipaikka}
    Odota sivun latautuminen

    Alusta Testipaikka
    Log  Luodaan este uusi este, tarkistetaan Datetimen avulla luontipäivä.


    Luo este                                    tyyppi
    Siirry Katselutilaan
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Contain                      ${FA_Lisätty_Järjestelmään}  ${date}
    Poista Este


#######################
## Sisäiset keywordit #
#######################

Siirrä este  [Arguments]  ${xKoord}  ${yKoord}
# Siirtää valittua estettä annetun offsetin verran, arvot positiivisia keskipisteestä oikealle ja alas
    Seleniumlibrary.mouse down                      css=[class='crosshair crosshair-center']
    Seleniumlibrary.drag and drop by offset         css=[class='crosshair crosshair-center']  ${xKoord}  ${yKoord}
    Seleniumlibrary.mouse up                        css=[class='crosshair crosshair-center']

Tarkista esteen olemassaolo
# Käytetään uutta estettä luotaessa - Tarkistaa jos este on jo olemassa ja poistaa sen.
    click element at coordinates                ${kartta}  20  -30
    ${passed}=  Run Keyword And Return Status   wait until element is visible    ${FA_otsikko}  timeout=3
    run keyword if  ${passed}  Poista este

Luo este  [arguments]  ${tyyppi}
    Log  Vaihtaa muokkaustilaan ja luo uuden esterakennelman kartan osoittamaan kohtaan.
    Siirry muokkaustilaan
    Odota sivun latautuminen
    Tarkista esteen olemassaolo
    click element                               ${Muokkaustila_AddTool}
    click element at coordinates                ${kartta}  0   20
    wait until element is visible               ${FA_otsikko}
    #Täytetään esteen kentät
    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           css=.spinner-overlay.modal-overlay


Täytetään esteen kentät
    # Tarkistetaan validoinnit ja ilmoitustekstit, pakolliset kentät
    select from list by value                xpath=.//label[contains(text(), 'Esterakennelma')]/../select   1

Valitse Esterakennelma
    FOR  ${n}  IN RANGE  10
        click element at coordinates                ${kartta}   0   20
        ${status}=  Run Keyword And Return Status  Wait Until Element Is Visible  ${FA_otsikko}
        Exit For Loop If  '${status}'=='True'
    END

Alusta Testipaikka
    Log  Jos testipaikalla on valmiiksi Este, vanha poistetaan.
    Click Element At Coordinates                    ${Kartta}  0  20
    ${status}=  Run Keyword And Return Status  Wait Until Element Is Visible  ${FA_otsikko}  10
    Run Keyword If  '${status}'=='True'  Poista Este

Poista Este
    Siirry Muokkaustilaan
    Click Element                               ${FA_Este_Poista_chkbx}
    Click Element                               ${FA_footer_Tallenna}
    #Odota sivun latautuminen
    Wait Until Element Is Not Visible           css=.spinner-overlay.modal-overlay
    Siirry Katselutilaan
