
*** Settings ***
Documentation       Pageobject for obstacles (Tasoristeys)

*** Variables ***
${LocatorForDDM}                                css=#feature-attributes .form-group.editable select:first-of-type
${LocatorForDDM_Selection}                      css=select > option:nth-child(2)

${Tasoristeyksen_poisto}                        Haluatko varmasti poistaa tasoristeyksen?

##### Rautatien tasoristeykset ####
${FA_Tasoristeys_Poista_chkbx}                          id=removebox




*** Keywords ***

Tasoristeys_1  [arguments]  ${testipaikka}
    wait until element is visible       ${valitse tietolaji}
    vaihda tietolaji                    ${TL_Rautatien_tasoristeys_RB}
    Paikanna osoite                             ${testipaikka}
    Log  Vaihdetaan mittakaava 1:20000
    #Odota sivun latautuminen
    wait until Screen Contain                       tasoristeys_t1.png     5
    Log  zoomataan kauemmas ja varmistetaan, ettei tasoristeys ole enää näkyvissä
    set selenium speed   0.3
    click element                               ${zoombar_minus}
    Set Min Similarity   0.9
    #Odota sivun latautuminen
    Screen Should Not Contain                   tasoristeys_t1.png
    Set Selenium Speed              ${DELAY}
    click element                               ${zoombar_minus}
    #Odota sivun latautuminen
    Screen Should Not Contain                   tasoristeys_t1.png
    Set Min Similarity   0.9

Tasoristeys_2  [arguments]  ${testipaikka}
    wait until element is visible       ${valitse tietolaji}
    vaihda tietolaji                    ${TL_Rautatien_tasoristeys_RB}
    Paikanna osoite                             ${testipaikka}
    Repeat Keyword  4 times                     click element  ${zoombar_plus}
    Odota sivun latautuminen
    Log  klikataan tasoristeyksen kohdalta
    wait until Screen Contain                   tasoristeys_t2.png     5
    set selenium speed          0.3
    click element at coordinates                ${kartta}   -10  30
    Set Selenium Speed          ${DELAY}
    Log  Varmistetaan, että formin link ID on oikein
    wait until element is visible               ${FA_otsikko}
    element should contain                      ${FA_otsikko}           10802452

Tasoristeys_3  [arguments]  ${testipaikka}
    wait until element is visible       ${valitse tietolaji}
    vaihda tietolaji                    ${TL_Rautatien_tasoristeys_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5  10 m
    Log  Siirrytään muokkaustilaan, valitaan tasoristeys ja muokataan sitä.
    #Odota sivun latautuminen
    Siirry muokkaustilaan
    click element at coordinates                ${kartta}   0   20
    wait until element is visible               ${FA_otsikko}
    DDM_tietolajit
    Siirrä tasoristeys                          -5   -105
    Click Element At Coordinates                ${Kartta}  100  100
    Click Button                                Sulje
    #Pause Execution  tasoristeys_t3.png
    wait until Screen Contain                   tasoristeys_t3.png     5
    click element                               ${FA_footer_Peruuta}

Tasoristeys_4  [arguments]  ${testipaikka}
    wait until element is visible       ${valitse tietolaji}
    vaihda tietolaji                    ${TL_Rautatien_tasoristeys_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5  20 m
    #Odota sivun latautuminen
    Log  Luodaan tasoristeys
    Luo tasoristeys                             tyyppi
    click element                               ${FA_footer_Peruuta}


#######################
## Sisäiset keywordit #
#######################

Siirrä tasoristeys  [Arguments]  ${xKoord}  ${yKoord}
    #Siirtää valittua tasoristeys annetun offsetin verran, arvot positiivisia keskipisteestä oikealle ja alas
    Seleniumlibrary.mouse down                      css=[class='crosshair crosshair-center']
    Seleniumlibrary.drag and drop by offset         css=[class='crosshair crosshair-center']  ${xKoord}  ${yKoord}
    Seleniumlibrary.mouse up                        css=[class='crosshair crosshair-center']

Tarkista tasoristeyksen olemassaolo
    #Käytetään uutta tasoristeystä luotaessa - Tarkistaa jos tasoristeys on jo olemassa ja poistaa sen.
    click element at coordinates                ${kartta}  20  -30
    ${passed}=  Run Keyword And Return Status   wait until element is visible    ${FA_otsikko}  timeout=3
    run keyword if  ${passed}  Poista tasoristeys

Poista tasoristeys
    click element                               ${FA_Tasoristeys_Poista_chkbx}
    click element                               ${FA_footer_Tallenna}
    wait until element is visible               ${MuokkausVaroitus}
    element text should be                      ${MuokkausVaroitus}     ${tasoristeyksen_poisto}
    click element                               ${muokkausvaroitus_kyllä_btn}


Luo tasoristeys  [arguments]  ${tyyppi}
    Log  Vaihtaa muokkaustilaan ja luo uuden tasoristeyksen kartan osoittamaan kohtaan.
    Siirry muokkaustilaan
    Odota sivun latautuminen
    Tarkista tasoristeyksen olemassaolo
    click element                               ${Muokkaustila_AddTool}
    click element at coordinates                ${kartta}  0  20
    wait until element is visible               ${FA_otsikko}
    Täytetään tasoristeyksen kentät

Täytetään tasoristeyksen kentät
    #Tarkistetaan validoinnit ja ilmoitustekstit, pakolliset kentät
    select from list by value                xpath=.//label[contains(text(), 'Turvavarustus')]/../select   1
    Seleniumlibrary.input text              xpath=.//label[contains(text(), 'Nimi')]/../input    Testi