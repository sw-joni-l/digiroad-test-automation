
*** Settings ***
Documentation       Pageobject for obstacles (Opastustaulu)

*** Variables ***
${LocatorForDDM}                                css=#feature-attributes .form-group.editable select:first-of-type
${LocatorForDDM_Selection}                      css=select > option:nth-child(2)

${Opastustaulun_poisto}                        Haluatko varmasti poistaa Opastustaulun?

##### Opastustaulu ####
${FA_Opastustaulu_Poista_chkbx}                          id=removebox




*** Keywords ***

Opastustaulu_1  [arguments]  ${testipaikka}
    wait until element is visible       ${valitse tietolaji}
    vaihda tietolaji                    ${TL_Opastustaulu_RB}
    Paikanna osoite                             ${testipaikka}
    Log  Vaihdetaan mittakaava 1:20000
#    Odota sivun latautuminen
    wait until Screen Contain                       Opastustaulu_o1.png     5
    Log  zoomataan kauemmas ja varmistetaan, ettei Opastustaulu ole enää näkyvissä
    set selenium speed   0.3
    click element                               ${zoombar_minus}
    Set Min Similarity   0.9
    Odota sivun latautuminen
    Screen Should Not Contain                   Opastustaulu_o1.png
    Set Selenium Speed              ${DELAY}
    click element                               ${zoombar_minus}
    Odota sivun latautuminen
    Screen Should Not Contain                   Opastustaulu_o1.png
    Set Min Similarity   0.9

Opastustaulu_2  [arguments]  ${testipaikka}
    wait until element is visible       ${valitse tietolaji}
    vaihda tietolaji                    ${TL_Opastustaulu_RB}
    Paikanna osoite                             ${testipaikka}
    click element                               ${zoombar_plus}
#    Odota sivun latautuminen
    Log  klikataan Opastustaulun kohdalta
    click element                               ${zoombar_plus}
    click element                               ${zoombar_plus}
    click element                               ${zoombar_plus}
    wait until Screen Contain                   Opastustaulu_o2.png     5
    set selenium speed          0.3
    click element at coordinates                ${kartta}   0   20
    Set Selenium Speed          ${DELAY}
    Log  Varmistetaan, että formin link ID on oikein
    wait until element is visible               ${FA_otsikko}
    element should contain                      ${FA_otsikko}           10844995

Opastustaulu_3  [arguments]  ${testipaikka}
    wait until element is visible       ${valitse tietolaji}
    vaihda tietolaji                    ${TL_Opastustaulu_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               2  20 m
    Log  Siirrytään muokkaustilaan, valitaan Opastustaulu ja muokataan sitä.
    #Odota sivun latautuminen
    Siirry muokkaustilaan
    click element at coordinates                ${kartta}   0   20
    wait until element is visible               ${FA_otsikko}
    click element                               css=#change-validity-direction
    Siirrä Opastustaulu                          40   5
    wait until Screen Contain                   Opastustaulu_o3.png     5
    click element                               ${FA_footer_Peruuta}

Opastustaulu_4  [arguments]  ${testipaikka}
    wait until element is visible       ${valitse tietolaji}
    vaihda tietolaji                    ${TL_Opastustaulu_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               2  20 m
#    Odota sivun latautuminen
    Log  Luodaan Opastustaulu
    Luo Opastustaulu                             tyyppi
    click element                               ${FA_footer_Peruuta}


#######################
## Sisäiset keywordit #
#######################

Siirrä Opastustaulu  [Arguments]  ${xKoord}  ${yKoord}
# Siirtää valittua Opastustaulu annetun offsetin verran, arvot positiivisia keskipisteestä oikealle ja alas
    Seleniumlibrary.mouse down                      css=[class='crosshair crosshair-center']
    Seleniumlibrary.drag and drop by offset         css=[class='crosshair crosshair-center']  ${xKoord}  ${yKoord}
    Seleniumlibrary.mouse up                        css=[class='crosshair crosshair-center']

Tarkista Opastustaulun olemassaolo
# Käytetään uutta Opastustaulutä luotaessa - Tarkistaa jos Opastustaulu on jo olemassa ja poistaa sen.
    click element at coordinates                ${kartta}  20  -30
    ${passed}=  Run Keyword And Return Status   wait until element is visible    ${FA_otsikko}  timeout=3
    run keyword if  ${passed}  Poista Opastustaulu

Poista Opastustaulu
    click element                               ${FA_Opastustaulu_Poista_chkbx}
    click element                               ${FA_footer_Tallenna}
    wait until element is visible               ${MuokkausVaroitus}
    element text should be                      ${MuokkausVaroitus}     ${Opastustaulun_poisto}
    click element                               ${muokkausvaroitus_kyllä_btn}


Luo Opastustaulu  [arguments]  ${tyyppi}
    Log  Vaihtaa muokkaustilaan ja luo uuden Opastustaulun kartan osoittamaan kohtaan.
    Siirry muokkaustilaan
    Odota sivun latautuminen
    Tarkista Opastustaulun olemassaolo
    click element                               ${Muokkaustila_AddTool}
    click element at coordinates                ${kartta}  0  20
    wait until element is visible               ${FA_otsikko}
    Täytetään Opastustaulun kentät

Täytetään Opastustaulun kentät
    # Tarkistetaan validoinnit ja ilmoitustekstit, pakolliset kentät
    click element                            css=#change-validity-direction
    Seleniumlibrary.input text              xpath=.//label[contains(text(), 'Teksti')]/../textarea    Testi