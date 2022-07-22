#       Joni Laari      Sitowise Oy     2022

*** Settings ***
Documentation       Keywords for vehicle-specific constraints (ajoneuvokohtainen rajoitus)

*** Variables ***
${LocatorForDDM}                            css=#feature-attributes .form-group.editable. select:first-of-type
${LocatorForDDM_Selection}                  css=select >option:nth-child(2)
#varmistusviesti ajoneuvorajoituksen poistolle
${Rajoituksen_poisto}                       Haluatko varmasti poistaa rajoituksen?

*** Keywords ***

Ajoneuvorajoite_1   [arguments]     ${testipaikka}
    #testataan valinnan toimivuus
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen

    Click Element At Coordinates                ${Kartta}   0  2
    Wait Until Element Is Visible               ${FA_otsikko}
    
    #double click
    
    Click Element At Coordinates                ${Kartta}  -100  -100
    Tupla Klikkaa Kartan Keskelle
    Wait Until Element Is Visible               ${FA_otsikko}



Ajoneuvorajoite_2   [arguments]     ${testipaikka}
    Log     Ajoneuvorajoituksen muokkaus koko ketjulle
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m

    Click Element At Coordinates                ${Kartta}   0  0

    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Click Element At Coordinates                ${Kartta}  1  0
    Wait Until Element Is Visible               css=#feature-attributes


Ajoneuvorajoite_3   [arguments]     ${testipaikka}
    Log     Ketjun osan muokkaus
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m

    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Tupla Klikkaa Kartan Keskelle
    Wait Until Element Is Visible               css=#feature-attributes-form > div > div > div.form-elements-container > div > label

    #väliaikainen, odotetaan fronttikoodin attribuuttien nimeämistä.
    Click Element                               css=.form-control
    Click Element                               css=.form-control option[value="10"]

    Click Element                               css=.cancel.btn.btn-secondary




Ajoneuvorajoite_4   [arguments]     ${testipaikka}
    Log     Luodaan uusi ajoneuvokohtainen rajoitus
    #testataan rajoituksen lisääminen
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   5 m

    Odota sivun latautuminen
    Siirry Muokkaustilaan
    #Wait Until Element Is Visible               css=#map-tools > div > div.asset-type-container > div.panel-group.simple-limit.prohibitions > div > div.panel-section.panel-toggle-edit-mode > button
    Click Element At Coordinates                ${Kartta}  0  0

    Wait Until Element Is Visible               css=#feature-attributes-footer

    #Luodaan ajoneuvorajoite, voimassaoloaika ja poikkeus
    #Click Element At Coordinates                ${Kartta}  0  0
    Wait Until Element Is Visible                   css=#feature-attributes-form
    Click Element                               css=.form-control
    Click Element                               css=.form-control option[value="10"]
    Sleep           5
    #Click Element                               ${Popup_AjoneuvoRajoitus}
    #Click Element                               ${Popup_AjoneuvoRajoitus_Moottori}

    #voimassaoloaika
    #Select From List By Index                   

    #poikkeus
    #Select From List By Index                   

    #Peruutus
    Element Should Be Visible                   ${AKR_Peruuta_Muutos}
    Click Element                               ${AKR_Peruuta_Muutos}


Ajoneuvorajoite_5   [arguments]     ${testipaikka}
    Log     Rajoituksen poisto
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   5 m

    Click Element At Coordinates                ${Kartta}   0  0

    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Click Element At Coordinates                ${Kartta}  0  0
    Wait Until Element Is Visible               css=#feature-attributes




Ajoneuvorajoite_6   [arguments]     ${testipaikka}
    Log     Valitaan laatikolla useampi kohde
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m

    Click Element At Coordinates                ${Kartta}   0  0

    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Click Element At Coordinates                ${Kartta}  0  0
    Wait Until Element Is Visible               css=#feature-attributes




Ajoneuvorajoite_7   [arguments]     ${testipaikka}
    Log     Katkaisutyökalun testaaminen
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m

    Click Element At Coordinates                ${Kartta}   0  0
    #${status}=  Run Keyword And Return Status   Element Should Contain   ${FA_Ajoneuvorajoitus}    
    #Run Keyword If  ${status}==False            Nollaa Ajoneuvorajoitus


#   Copied from nopeusrajoitus
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Log  Leikataan rajoitus kahteen osaan 206.86
    Log  Katkaisun jälkeen peruuta-nappi toimii 206.91
    Element should be visible                   css=.prohibition .cut
    Click Element                               css=.prohibition .cut
    Click Element At Coordinates                ${Kartta}  0  0
    Wait Until Element Is Visible               css=#feature-attributes     #${FA_otsikko}  
    Sleep                                       5 seconds
    Click Element                               xpath=//*[@id="feature-attributes-footer"]/div/button[2]    #${FA_footer_Peruuta}
    Log  Katkaisun jälkeen peruuta-napin painalluksen jälkeen katkaisutyökalu jää käyttöön  # 206.92
    Element Should Be Visible                   xpath=//*[@id="map-tools"]/div/div[3]/div[5]/div/div[4]/div[2]
    Log  Katkaisun jälkeen peruuta-napin painalluksen jälkeen yksittäisen ajoneuvorajoituksen valinta poistuu     #206.93
    Element Should Not Be Visible               xpath=//*[@id="feature-attributes-header"]/span[2]


    Click Element At Coordinates                ${Kartta}  0  0
    #Wait Until Element Is Visible               ${MuokkausVaroitus}
    #Click Element                               ${Muokkausvaroitus_Sulje_btn}

    #Log  Asetetaan leikkauskohdan rajoitukset
    #Wait Until Element Is Visible               ${FA_Rajoitus_A}
    #Click Element                               ${FA_Rajoitus_A}
    #Click Element                               ${FA_Rajoitus_A_DDM}
    #Click Element                               ${FA_Rajoitus_B}
    #Click Element                               ${FA_Rajoitus_B_DDM}

    Log  "Olet muokannut.." -dialogi jos katkaisun jälkeen klikkaa karttaa ennen tallennusta    #206.104
    Click Element At Coordinates                ${Kartta}  -100  -100
    Wait Until Element Is Visible               ${MuokkausVaroitus}
    Element Should Contain                      ${MuokkausVaroitus}  ${MuokkausVaroitus_teksti}
    Click Element                               ${Muokkausvaroitus_Sulje_btn}
    Click Element                               xpath=//*[@id="feature-attributes-footer"]/div/button[2]
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen
    Log  Yhden linkin mittaisen ajoneuvorajoituksen katkaisun ja tallennuksen jälkeen valintatyökalu jää aktiiviseksi, 206.101
    Element should be visible                   css=.panel-group:not([style="display: none;"]) .action.select.action
    Siirry Katselutilaan

    Log  Yhden linkin mittaisen ajoneuvorajoituksen katkaisun jälkeen uudet ajoneuvorajoituspätkien arvot ovat muokattavissa 206.102
    Click Element At Coordinates                ${Kartta}  0  0
    
    Sleep       5 seconds
    #Wait Until Element Is Visible               //*[@id="feature-attributes-header"]/span        #css=#feature-attributes-header > span

    Element Should Contain                      ${FA_Ajoneuvorajoitus} 2
    Siirry Muokkaustilaan
    Click Element                               ${Popup_AjoneuvoRajoitus}
    Click Element                               ${Popup_AjoneuvoRajoitus_DDM}
    Click Element                               ${FA_header_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen
    Siirry Katselutilaan


    Click Element At Coordinates                ${Kartta}  0  0
    Wait Until Element Is Visible               css=feature-attributes-header   #${FA_otsikko}
    Element Should Contain                      ${FA_Ajoneuvorajoitus}  2
    Siirry Muokkaustilaan
    Click Element                               ${Popup_AjoneuvoRajoitus}
    Click Element                               ${Popup_AjoneuvoRajoitus_DDM}
    Click Element                               ${FA_header_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen

    Log  Valittaessa ajoneuvorajoituksen ominaisuustietonäkymässä näkyy ajoneuvorajoituksen ID, lisäys ja muokkaus tiedot. 206.30
    Siirry Katselutilaan
    Click Element At Coordinates                ${Kartta}  0  0
    Wait Until Element Is Visible               css=feature-attributes-header    #${FA_otsikko}
    ${date}=  Get Current Date                  result_format=%d.%m.%Y
    Element Should Contain                      ${FA_Muokattu_viimeksi}  ${date}
    #Element Should Contain                      ${FA_otsikko}  87408330
END


##########################
### Sisäiset Keywordit ###
##########################

Nollaa Ajoneuvorajoitus
    Siirry Muokkaustilaan
    Element should be visible                   css=.${TL_Ajoneuvorajoitus_RB} .polygon
    Click Element                               css=.${TL_Ajoneuvorajoitus_RB} .polygon
    Suorita monivalinta
    Click Element                               ${Popup_AjoneuvoRajoitus}
    Click Element                               ${Popup_AjoneuvoRajoitus_60}
    Click Element                               ${FA_header_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen
    Siirry Katselutilaan


*** Variables ***
${FA_Rajoitus_A}            css=.prohibition-a
${FA_Rajoitus_A_DDM}        css=.prohibition-a option:nth-child(2)
${FA_Rajoitus_B}            css=.prohibition-b
${FA_Rajoitus_B_DDM}        css=.prohibition-b option:nth-child(8)
${FA_Ajoneuvorajoitus}      css=#feature-attributes-form > div > div > div:nth-child(4) > p
${Popup_AjoneuvoRajoitus}     css=.form-control.select
${Popup_AjoneuvoRajoitus_Moottori}  css=.form-control option[data="Moottoriajoneuvo"]
${Popup_AjoneuvoRajoitus_Mopo}  css=.form-control option[data="Mopo"]
${FA_Jaa_Ajoneuvorajoitus}    id=separate-limit
${AKR_Peruuta_Muutos}        css=.cancel.btn.btn-secondary