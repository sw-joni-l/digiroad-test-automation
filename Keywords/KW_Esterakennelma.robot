
*** Settings ***
Documentation       Keywords for obstacles (Esterakennelma)

*** Variables ***
${LocatorForDDM}                                css=#feature-attributes .form-group.editable select:first-of-type
${LocatorForDDM_Selection}                      css=select > option:nth-child(2)
${Esteen_poisto}                                Haluatko varmasti poistaa esteen?
${FA_Este_Poista_chkbx}                         id=removebox


*** Keywords ***

Este_1  [arguments]  ${testipaikka}
    wait until element is visible       ${valitse tietolaji}
    vaihda tietolaji                    ${TL_Esterakennelma_RB}
    Paikanna osoite                             ${testipaikka}
    Log  Vaihdetaan mittakaava 1:20000
    #Odota sivun latautuminen
    wait until Screen Contain                       esterakennelma_e1.png     5
    Log  zoomataan kauemmas ja varmistetaan, ettei esterakennelma ole enää näkyvissä
    set selenium speed   0.3
    click element                               ${zoombar_minus}
    Set Min Similarity   0.9
    Odota sivun latautuminen
    Screen Should Not Contain                   esterakennelma_e1.png
    Set Selenium Speed              ${DELAY}
    click element                               ${zoombar_minus}
    Odota sivun latautuminen
    Screen Should Not Contain                   esterakennelma_e1.png
    Set Min Similarity   0.9

Este_2  [arguments]  ${testipaikka}
    wait until element is visible       ${valitse tietolaji}
    vaihda tietolaji                    ${TL_Esterakennelma_RB}
    Paikanna osoite                             ${testipaikka}
    click element                               ${zoombar_plus}
    #Odota sivun latautuminen
    Log  klikataan Esterakennelman kohdalta
    click element                               ${zoombar_plus}
    click element                               ${zoombar_plus}
    wait until Screen Contain                   esterakennelma_e2.png     5
    set selenium speed          0.3
    click element at coordinates                ${kartta}   0  20
    #testklick
    Set Selenium Speed          ${DELAY}
    Log  Varmistetaan, että formin link ID on oikein
    wait until element is visible               ${FA_otsikko}
    element should contain                      ${FA_otsikko}           10790838

Este_3  [arguments]  ${testipaikka}
    wait until element is visible       ${valitse tietolaji}
    vaihda tietolaji                    ${TL_Esterakennelma_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               4  20 m
    Log  Siirrytään muokkaustilaan, valitaan esterakennelma ja muokataan sitä.
    #Odota sivun latautuminen
    Siirry muokkaustilaan
    wait until Screen Contain                   esterakennelma_e3.png     5
    click element at coordinates                ${kartta}   0   20
    wait until element is visible               ${FA_otsikko}
    DDM_tietolajit
    Siirrä este                                 40   5
    Click element at coordinates                ${Kartta}  100  100
    Click Button                                Sulje
    Pause Execution  esterakennelma_e3.png
    wait until Screen Contain                   esterakennelma_e4.png  5 
    click element                               ${FA_footer_Peruuta}

Este_4  [arguments]  ${testipaikka}
    wait until element is visible       ${valitse tietolaji}
    vaihda tietolaji                    ${TL_Esterakennelma_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               2  20 m
    #Odota sivun latautuminen
    Log  Luodaan este
    Luo este                                    tyyppi
    click element                               ${FA_footer_Peruuta}


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

Poista este
    click element                               ${FA_Este_Poista_chkbx}
    click element                               ${FA_footer_Tallenna}
    wait until element is visible               ${MuokkausVaroitus}
    element text should be                      ${MuokkausVaroitus}     ${esteen_poisto}
    click element                               ${muokkausvaroitus_kyllä_btn}


Luo este  [arguments]  ${tyyppi}
    Log  Vaihtaa muokkaustilaan ja luo uuden esterakennelman kartan osoittamaan kohtaan.
    Siirry muokkaustilaan
    Odota sivun latautuminen
    Tarkista esteen olemassaolo
    click element                               ${Muokkaustila_AddTool}
    click element at coordinates                ${kartta}  0   20
    wait until element is visible               ${FA_otsikko}
    Täytetään esteen kentät

Täytetään esteen kentät
    # Tarkistetaan validoinnit ja ilmoitustekstit, pakolliset kentät
    select from list by value                xpath=.//label[contains(text(), 'Esterakennelma')]/../select   1

