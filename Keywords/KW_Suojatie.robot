
*** Settings ***
Documentation       Pageobject for obstacles (Suojatie)

*** Variables ***
${LocatorForDDM}                                css=#feature-attributes .form-group.editable select:first-of-type
${LocatorForDDM_Selection}                      css=select > option:nth-child(2)

${Suojatien_poisto}                        Haluatko varmasti poistaa Suojatien?

##### Suojatiet ####
${FA_Suojatie_Poista_chkbx}                          id=removebox




*** Keywords ***

Suojatie_1  [arguments]  ${testipaikka}
    #HUOM: Odota sivun latautuminen kestää pitkään, SikuliKuva on ilman sivun latausta
    wait until element is visible       ${valitse tietolaji}
    vaihda tietolaji                    ${TL_Suojatie_RB}
    Paikanna osoite                             ${testipaikka}
    Log  Vaihdetaan mittakaava 1:20000
    #Odota sivun latautuminen
    wait until Screen Contain                   suojatie_s1.png     10
    Log  zoomataan kauemmas ja varmistetaan, ettei Suojatie ole enää näkyvissä
    set selenium speed   0.3
    click element                               ${zoombar_minus}
    Set Min Similarity   0.9
    #Odota sivun latautuminen
    Screen Should Not Contain                   suojatie_s1.png
    Set Selenium Speed              ${DELAY}
    click element                               ${zoombar_minus}
    #Odota sivun latautuminen
    Screen Should Not Contain                   suojatie_s1.png
    Set Min Similarity   0.9

Suojatie_2  [arguments]  ${testipaikka}
    wait until element is visible       ${valitse tietolaji}
    vaihda tietolaji                    ${TL_Suojatie_RB}
    Paikanna osoite                             ${testipaikka}
    Repeat Keyword  4 times                     click element  ${zoombar_plus}
    Odota sivun latautuminen
    Log  klikataan Suojatien kohdalta
    wait until Screen Contain                   suojatie_s2.png     5
    sleep  1
    Odota sivun latautuminen
    click element at coordinates                ${kartta}   0   20
    Log  Varmistetaan, että formin link ID on oikein
    wait until element is visible               ${FA_otsikko}
    element should contain                      ${FA_otsikko}           10634079

Suojatie_3  [arguments]  ${testipaikka}
    wait until element is visible       ${valitse tietolaji}
    vaihda tietolaji                    ${TL_Suojatie_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5  20 m
    Log  Siirrytään muokkaustilaan, valitaan Suojatie ja muokataan sitä.
    Odota sivun latautuminen
    Siirry muokkaustilaan
    click element at coordinates                ${kartta}   0   20
    wait until element is visible               ${FA_otsikko}
    Siirrä Suojatie                             40   5
    Click element at coordinates                ${Kartta}  100  100
    Click Button                                Sulje
    wait until Screen Contain                   suojatie_s3.png     5
    click element                               ${FA_footer_Peruuta}

Suojatie_4  [arguments]  ${testipaikka}
    wait until element is visible               ${valitse tietolaji}
    vaihda tietolaji                            ${TL_Suojatie_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5  20 m
    Odota sivun latautuminen
    Log  Luodaan Suojatie
    Luo Suojatie                                tyyppi
    #Pause Execution  uusi suojatie
    wait until Screen Contain                   suojatie_s4.png     5
    click element                               ${FA_footer_Peruuta}


#######################
## Sisäiset keywordit #
#######################

Siirrä Suojatie  [Arguments]  ${xKoord}  ${yKoord}
# Siirtää valittua Suojatie annetun offsetin verran, arvot positiivisia keskipisteestä oikealle ja alas
    Seleniumlibrary.mouse down                      css=[class='crosshair crosshair-center']
    Seleniumlibrary.drag and drop by offset         css=[class='crosshair crosshair-center']  ${xKoord}  ${yKoord}
    Seleniumlibrary.mouse up                        css=[class='crosshair crosshair-center']

Tarkista Suojatien olemassaolo
# Käytetään uutta Suojatietä luotaessa - Tarkistaa jos Suojatie on jo olemassa ja poistaa sen.
    click element at coordinates                ${kartta}  20  -30
    ${passed}=  Run Keyword And Return Status   wait until element is visible    ${FA_otsikko}  timeout=3
    run keyword if  ${passed}  Poista Suojatie

Poista Suojatie
    click element                               ${FA_Suojatie_Poista_chkbx}
    click element                               ${FA_footer_Tallenna}
    wait until element is visible               ${MuokkausVaroitus}
    element text should be                      ${MuokkausVaroitus}     ${Suojatien_poisto}
    click element                               ${muokkausvaroitus_kyllä_btn}


Luo Suojatie  [arguments]  ${tyyppi}
    Log  Vaihtaa muokkaustilaan ja luo uuden Suojatien kartan osoittamaan kohtaan.
    Siirry muokkaustilaan
    Odota sivun latautuminen
    Tarkista Suojatien olemassaolo
    click element                               ${Muokkaustila_AddTool}
    click element at coordinates                ${kartta}  0    20
    wait until element is visible               ${FA_otsikko}

