*** Settings ***
Documentation       Pageobject for Traffic signs (Liikennemerkit)

*** Keywords ***

Liikennemerkit_1  [arguments]  ${testipaikka}
    log  Luodaan uusi Liikennemerkki, Täytetään kaikki kentät
    Siirry Testipaikkaan  ${TL_Liikennemerkit_RB}  ${Testipaikka}
    Valitse kaikki Liikennemerkit
    Odota sivun latautuminen

    Alusta Testipaikka
    Luo Liikennemerkki

    Log  Alustetaan testipaikka uusiksi. Tarkistetaan, että liikennemerkki näkyy oikeassa kategoriassa.
    Siirry Katselutilaan
    Testin Aloitus
    Siirry Testipaikkaan                        ${TL_Liikennemerkit_RB}  ${Testipaikka}
    Click Element                               ${LM_Kielto}
    Odota sivun latautuminen
    ${date}=  Get Current Date                  result_format=%d.%m.%Y
    Click Element At Coordinates         ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Tarkista Merkin Kentät                      ${date}
    Siirry Muokkaustilaan
    Click Element                               ${FA_Poista_chkbx}
    Click Element                               ${FA_footer_Tallenna}



#######################
## Sisäiset keywordit #
#######################

Valitse kaikki Liikennemerkit
    FOR  ${selector}  IN  @{LM_lista}
        Click Element  ${selector}
    END

Luo Liikennemerkki
    Siirry Muokkaustilaan
    Odota sivun latautuminen
    click element                           ${Muokkaustila_AddTool}
    Click Element At Coordinates            ${Kartta}  0  20
    Wait Until Element Is Visible           ${FA_otsikko}
    Täytä Liikennemerkin kentät
    Click Element                           ${FA_footer_Tallenna}
    sleep  1
    Wait Until Element Is Not Visible           ${Spinner_Overlay}  timeout=30 s
    Odota sivun latautuminen


Täytä Liikennemerkin kentät
    Click Element   ${Tyyppi}
    Click Element   ${Tyyppi_DDM}
    Click Element   ${Alityyppi}
    Click Element   ${Alityyppi_DDM}
    Input Text      ${Arvo}                 100
    Input Text      ${Päämerkin_Teksti}     Testi         
    Input Text      ${Kunnan_ID}            Kunta12                
    Input Text      ${Lisätieto}            HienoMerkki             
    Click Element   ${Rakenne}                      
    Click Element   ${Rakenne_DDM}                    
    Click Element   ${Kunto}                          
    Click Element   ${Kunto_DDM}                     
    Click Element   ${Koko}                          
    Click Element   ${Koko_DDM}                    
    Input Text      ${Korkeus}  100                     
    Click Element   ${Kalvon_Tyypi}                  
    Click Element   ${Kalvon_Tyypi_DDM}            
    Click Element   ${Merkin_Materiaali}             
    Click Element   ${Merkin_Materiaali_DDM}        
    Click Element   ${Sijaintitarkenne}               
    Click Element   ${Sijaintitarkenne_DDM}           
    Input Text      ${Maastokoordinaatti_X}  82          
    Input Text      ${Maastokoordinaatti_Y}  86         
    #Input Text      ${Kaista}   2            
    Click Element   ${Kaistan_Tyyppi}                 
    Click Element   ${Kaistan_Tyyppi_DDM}             
    Click Element   ${Tila}                             
    Click Element   ${Tila_DDM}                       
    Input Text      ${Alkupäivämäärä}        1.12.2025            
    Input Text      ${Loppupäivämäärä}       1.12.2026          
    Click Element   ${Vauriotyyppi}                    
    Click Element   ${Vauriotyyppi_DDM}                 
    Click Element   ${Korjauksen_Kiireellisyys}        
    Click Element   ${Korjauksen_Kiireellisyys_DDM}     
    Input Text      ${Arvioitu_Käyttöikä}       1     

Tarkista Merkin Kentät  [Arguments]  ${date}
    Element Should Contain                      ${FA_Lisätty_Järjestelmään}  ${date}
    Element Should Contain                      ${FA_Tyyppi}  Kielto- ja rajoitusmerkit
    Element Should Contain                      ${FA_Alityyppi}  C32 Nopeusrajoitus
    Element Should Contain                      ${FA_Arvo}  100
    Element Should Contain                      ${FA_Päämerkin_Teksti}  Testi
    Element Should Contain                      ${FA_Kunnan_ID}  Kunta12
    Element Should Contain                      ${FA_Lisätieto}  HienoMerkki
    Element Should Contain                      ${FA_Rakenne}  Silta
    Element Should Contain                      ${FA_Kunto}  Tyydyttävä
    Element Should Contain                      ${FA_Koko}  Normaalikokoinen merkki
    Element Should Contain                      ${FA_Korkeus}  100
    Element Should Contain                      ${FA_Kalvon_Tyyppi}  R2-luokan kalvo
    Element Should Contain                      ${FA_Merkin_Materiaali}  Alumiini
    Element Should Contain                      ${FA_Sijaintitarkenne}  Väylän vasen puoli
    Element Should Contain                      ${FA_Maastokoordinaatti_X}  82
    Element Should Contain                      ${FA_Maastokoordinaatti_Y}  86
    Element Should Contain                      ${FA_Kaista}  –
    Element Should Contain                      ${FA_Kaistan_Tyyppi}  Ohituskaista
    Element Should Contain                      ${FA_Tila}  Rakenteilla
    Element Should Contain                      ${FA_Alkupäivämäärä}  01.12.2025
    Element Should Contain                      ${FA_Loppupäivämäärä}  01.12.2026
    Element Should Contain                      ${FA_Vauriotyyppi}  Kolhiintunut
    Element Should Contain                      ${FA_Korjauksen_Kiireellisyys}  Kiireellinen
    Element Should Contain                      ${FA_Arvioitu_Käyttöikä}  1

*** Variables ***
${LM_Varoitusmerkit}    generalWarningSigns
${LM_Etuajo-oikeus}     priorityAndGiveWaySigns
${LM_Kielto}            prohibitionsAndRestrictions
${LM_Määräysmerkit}     mandatorySigns
${LM_Sääntömerkit}      regulatorySigns
${LM_Opastusmerkit}     informationSigns
${LM_Palvelukohteet}    serviceSigns
${LM_Muut_merkit}       otherSigns

@{LM_lista}  
...     ${LM_Varoitusmerkit}  ${LM_Etuajo-oikeus}  ${LM_Kielto}
...     ${LM_Määräysmerkit}  ${LM_Sääntömerkit}  ${LM_Opastusmerkit}
...     ${LM_Palvelukohteet}  ${LM_Muut_merkit}

#####################
### Merkin kentät ###
#####################

${Tyyppi}                           css=#main-trafficSigns_type
${Tyyppi_DDM}                       css=#main-trafficSigns_type > option:nth-child(3)
${Alityyppi}                        css=#trafficSigns_type
${Alityyppi_DDM}                    css=#trafficSigns_type > option:nth-child(32)
${Arvo}                             css=#trafficSigns_value
${Päämerkin_Teksti}                 css=#main_sign_text
${Kunnan_ID}                        css=#municipality_id
${Lisätieto}                        css=#trafficSigns_info
${Rakenne}                          css=#structure
${Rakenne_DDM}                      css=#structure > option:nth-child(3)
${Kunto}                            css=#condition
${Kunto_DDM}                        css=#condition > option:nth-child(3)
${Koko}                             css=#size
${Koko_DDM}                         css=#size > option:nth-child(2)
${Korkeus}                          css=#height
${Kalvon_Tyypi}                     css=#coating_type
${Kalvon_Tyypi_DDM}                 css=#coating_type > option:nth-child(2)
${Merkin_Materiaali}                css=#sign_material
${Merkin_Materiaali_DDM}            css=#sign_material > option:nth-child(2)
${Sijaintitarkenne}                 css=#location_specifier
${Sijaintitarkenne_DDM}             css=#location_specifier > option:nth-child(2)
${Maastokoordinaatti_X}             css=#terrain_coordinates_x
${Maastokoordinaatti_Y}             css=#terrain_coordinates_y
${Kaista}                           css=#lane
${Kaistan_Tyyppi}                   css=#lane_type
${Kaistan_Tyyppi_DDM}               css=#lane_type > option:nth-child(2)
${Tila}                             css=#life_cycle
${Tila_DDM}                         css=#life_cycle > option:nth-child(2)
${Alkupäivämäärä}                   css=#trafficSign_start_date
${Loppupäivämäärä}                  css=#trafficSign_end_date
${Vauriotyyppi}                     css=#type_of_damage
${Vauriotyyppi_DDM}                 css=#type_of_damage > option:nth-child(2)
${Korjauksen_Kiireellisyys}         css=#urgency_of_repair
${Korjauksen_Kiireellisyys_DDM}     css=#urgency_of_repair > option:nth-child(2)
${Arvioitu_Käyttöikä}               css=#lifespan_left

${FA_Tyyppi}                        css=#feature-attributes-form > div > div > div:nth-child(3) > p
${FA_Alityyppi}                     css=#feature-attributes-form > div > div > div:nth-child(4) > p
${FA_Arvo}                          css=#feature-attributes-form > div > div > div:nth-child(5) > p
${FA_Päämerkin_Teksti}              css=#feature-attributes-form > div > div > div:nth-child(6) > p
${FA_Kunnan_ID}                     css=#feature-attributes-form > div > div > div:nth-child(7) > p
${FA_Lisätieto}                     css=#feature-attributes-form > div > div > div:nth-child(8) > p
${FA_Rakenne}                       css=#feature-attributes-form > div > div > div:nth-child(9) > p
${FA_Kunto}                         css=#feature-attributes-form > div > div > div:nth-child(10) > p
${FA_Koko}                          css=#feature-attributes-form > div > div > div:nth-child(11) > p
${FA_Korkeus}                       css=#feature-attributes-form > div > div > div:nth-child(12) > p
${FA_Kalvon_Tyyppi}                 css=#feature-attributes-form > div > div > div:nth-child(13) > p
${FA_Merkin_Materiaali}                css=#feature-attributes-form > div > div > div:nth-child(14) > p
${FA_Sijaintitarkenne}                 css=#feature-attributes-form > div > div > div:nth-child(15) > p
${FA_Maastokoordinaatti_X}             css=#feature-attributes-form > div > div > div:nth-child(16) > p
${FA_Maastokoordinaatti_Y}             css=#feature-attributes-form > div > div > div:nth-child(17) > p
${FA_Kaista}                           css=#feature-attributes-form > div > div > div:nth-child(18) > p
${FA_Kaistan_Tyyppi}                   css=#feature-attributes-form > div > div > div:nth-child(19) > p
${FA_Tila}                             css=#feature-attributes-form > div > div > div:nth-child(20) > p
${FA_Alkupäivämäärä}                   css=#feature-attributes-form > div > div > div:nth-child(21) > p
${FA_Loppupäivämäärä}                  css=#feature-attributes-form > div > div > div:nth-child(22) > p
${FA_Vauriotyyppi}                     css=#feature-attributes-form > div > div > div:nth-child(23) > p
${FA_Korjauksen_Kiireellisyys}         css=#feature-attributes-form > div > div > div:nth-child(24) > p
${FA_Arvioitu_Käyttöikä}               css=#feature-attributes-form > div > div > div:nth-child(25) > p