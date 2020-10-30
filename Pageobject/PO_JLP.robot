
*** Settings ***
Documentation       Pageobject for Buststops (JoukkoLiikenteenPysäkki)

*** Variables ***

${Pysakin_siirto_yli50m_popup}                  Pysäkkiä siirretty yli 50 metriä. Haluatko siirtää pysäkin uuteen sijaintiin?
${ELY_Pysakin_siirto_yli50m_popup}              Pysäkkiä siirretty yli 50 metriä. Siirron yhteydessä vanha pysäkki lakkautetaan ja luodaan uusi pysäkki.
${Pysäkin_poisto}                               Haluatko varmasti poistaa pysäkin?

####### Joukkoliikenteen pysäkki ###




##### Joukkoliikenteen pysäkit ####
${FA_JLP_Poista_chkbx}                          id=removebox
${FA_JLP_Nimi_fi}
${FA_JLP_Nimi_se}
${FA_JLP_Osoite_fi}
${FA_JLP_Osoite_se}
${FA_JLP_tietojen_ylläpitäjä}
${FA_JLP_tietojen_ylläpitäjän_tunnus}
${FA_JLP_Livi-Tunnus}
${FA_JLP_Matkustajatunnus}
${FA_JLP_MaastokoordinaattiX}
${FA_JLP_MaastokoordinaattiY}
${FA_JLP_MaastokoordinaattiZ}
${FA_JLP_Liikennöintisuunta}
${FA_JLP_Vaikutussuunta}

${FA_viimeinen_voimassaolopvm}                  id=viimeinen_voimassaolopaiva
${FA_kalenterin_EI_tietoa_nappi}                xpath=.//*[@class="pika-single is-bound"] //*[@class="deselect-button"]

# Pysäkit - Geometrian ulkopuolelle jääneet pysäkit
${FA_Link_floating-stops}                        id=asset-work-list-link
${FA_Link_floating-stops_cont}                   Geometrian ulkopuolelle jääneet pysäkit

#Kuvat
${kaukoliikennepysakki}                         kaukoliikennepysakki.png
${kaukoliikennepysakki_valittu}                 kaukoliikennepysakki_valittu.png
${pysakkipallura1}                               pysakki_pallura1.png
${pysakkipallura2}                               pysakki_pallura2.png

${kalenterin_nappi_eitietoa}                    kalenteri_eitietoa.png

*** Keywords ***

JLP_1  [arguments]  ${testipaikka}
    Paikanna osoite                             ${testipaikka}
    Log  Vaihdetaan mittakaava 1:20000
    Odota sivun latautuminen
    Screen Should Contain                       kaukoliikennepysakki_jlp1.png
    Log  zoomataan kauemmas ja varmistetaan, ettei pysäkkiaineisto ole enää näkyvissä
    set selenium speed   0.3
    click element                               ${zoombar_minus}
    Set Min Similarity   0.9
    Odota sivun latautuminen
    Screen Should Not Contain                   kaukoliikennepysakki_jlp1.png
    Set Selenium Speed              ${DELAY}
    click element                               ${zoombar_minus}
    Odota sivun latautuminen
    Screen Should Not Contain                   kaukoliikennepysakki_jlp1.png
    Set Min Similarity   0.9     # oli 0.6

JLP_2  [arguments]  ${testipaikka}
    Paikanna osoite                             ${testipaikka}
    click element                               ${zoombar_plus}
    Odota sivun latautuminen
    Log  klikataan pysäkin infopallura näkyvvin
    click element at coordinates                ${kartta}  0   20
    #  OL3 WA vaihda kuvaan koko infoboksi
    Screen Should Contain                              ${kaukoliikennepysakki_valittu}
    Log  Varmistetaan, että bussipallurassa näkyvä link ID on sama kuin formilla
    #   OL3 WA
    #    ${tmp_padder_id}=  get text                 ${Pysäkin_pallura_LinkID}
    wait until element is visible               ${FA_otsikko}
    element should contain                      ${FA_otsikko}           78643
    Log  Siirrytään muokkaustilaan ja asetetaan pysäkki vanhentuneeksi (kesken)
    click element                               ${Siirry muokkaustilaan}
    wait until element is visible               css=.form-group:nth-of-type(3) .form-control:nth-of-type(1)
    execute javascript  var element = document.getElementById("viimeinen_voimassaolopaiva");
    ...  element.scrollIntoView({block: "end"});
    wait until element is visible               ${FA_viimeinen_voimassaolopvm}
    click element                               ${FA_viimeinen_voimassaolopvm}
    SikuliLibrary.Wait Until Screen Contain     ${kalenterin_nappi_eitietoa}   5
    SikuliLibrary.Click                         ${kalenterin_nappi_eitietoa}
    click element                               ${FA_footer_Peruuta}


JLP_3  [arguments]  ${testipaikka}  ${ELY}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               2  20 m
    Log  Siirrytään muokkaustilaan, valitaan pysäkki ja siirretään sitä.
    Odota sivun latautuminen
    Siirry muokkaustilaan
    click element at coordinates                ${kartta}  20  -5
    wait until element is visible               ${FA_otsikko}
    Odota sivun latautuminen
    wanha Siirrä Pysäkkiä                             -300  -100
    wait until element is visible               ${MuokkausVaroitus}
    run keyword if  '${ELY}' == 'kyllä'         element text should be   ${MuokkausVaroitus}    ${ELY_Pysakin_siirto_yli50m_popup}
    ...  ELSE                                   element text should be   ${MuokkausVaroitus}    ${Pysakin_siirto_yli50m_popup}
    click element                               ${muokkausvaroitus_ei_btn}
    click element                               ${FA_footer_Peruuta}


JLP_4  [arguments]  ${testipaikka}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               2  20 m
    Odota sivun latautuminen
    Log  Luodaan pysäkki
    Luo pysäkki                                 Kunta
    click element                               ${FA_footer_Peruuta}


#######################
## Sisäiset keywordit #
#######################

Siirrä Pysäkkiä  [Arguments]  ${xKoord}  ${yKoord}

    SikuliLibrary.Drag And Drop By Offset        ${pysakkipallura}  ${xKoord}  ${yKoord}


Wanha_Siirrä Pysäkkiä  [Arguments]  ${xKoord}  ${yKoord}
    #Siirtää valittua bussipysäkkiä annetun offsetin verran, arvot positiivisia keskipisteestä oikealle ja alas
    Seleniumlibrary.mouse down                      css=[class='crosshair crosshair-center']
    Seleniumlibrary.drag and drop by offset         css=[class='crosshair crosshair-center']  ${xKoord}  ${yKoord}
    Seleniumlibrary.mouse up                        css=[class='crosshair crosshair-center']

Tarkista pysäkin olemassaolo
# Käytetään uutta pysäkkiä luotaessa - Tarkistaa jos pysäkki on jo olemassa ja poistaa sen.
    click element at coordinates                ${kartta}  20  -30
    ${passed}=  Run Keyword And Return Status   wait until element is visible    ${FA_otsikko}  timeout=3
    run keyword if  ${passed}  Poista Pysäkki

Poista Pysäkki
    click element                               ${FA_JLP_Poista_chkbx}
    click element                               ${FA_footer_Tallenna}
    wait until element is visible               ${MuokkausVaroitus}
    element text should be                      ${MuokkausVaroitus}     ${Pysäkin_poisto}
    click element                               ${muokkausvaroitus_kyllä_btn}


Luo pysäkki  [arguments]  ${ylläpitäjä}
    Log  Vaihtaa muokkaustilaan ja luo uuden bussipysäkin kartan osoittamaan kohtaan.
    Siirry muokkaustilaan
    Odota sivun latautuminen
    Tarkista pysäkin olemassaolo
    click element                               ${Muokkaustila_AddTool}
    click element at coordinates                ${kartta}  0   20
    wait until element is visible               ${FA_otsikko}
    Täytetään pysäkin kentät



Täytetään pysäkin kentät
    # Tarkistetaan validoinnit ja ilmoitustekstit, pakolliset kentät: virtuaalipysäkki, pikavuoro yksinään
    Seleniumlibrary.Input text              css=#nimi_suomeksi    Testi
    click element                            xpath=.//label[contains(text(), 'Virtuaalipysäkki')]
    select from list by value                xpath=.//label[contains(text(), 'Tietojen ylläpitäjä')]/../select   1