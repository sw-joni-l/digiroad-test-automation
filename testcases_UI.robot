# Antti Salo        Dimenteq Oy     2016
# Kaikki:       pybot -L TRACE -T Digiroad
# Tagin mukaan: pybot -L TRACE -T -i muumi Digiroad

*** Variables ***


*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            variables.robot

Suite Setup         LoginToLivi
Suite Teardown      Close Browser

Test Setup          Testin Aloitus

*** Test Cases ***
Käyttöliittymä 1
    [Tags]              UI   Mandatory
    [Documentation]     Käyttöliittymä, selain: ${BROWSER}
    ...  - Skandinaaviset aakkoset näkyvät oikein
    
    PO_UI.UI_1

Käyttöliittymä 2
    [Tags]              UI   Mandatory
    [Documentation]     Käyttöliittymä, selain: ${BROWSER}
    ...  - Käyttöohje aukeaa klikkaamalla Käyttöohje-nappulaa.
    PO_UI.UI_2

Käyttöliittymä 3
    [Tags]              UI   Mandatory
    [Documentation]     Käyttöliittymä, selain: ${BROWSER}
    ...                 - XSSllä ei saa käyttöliittymää rikki.
    PO_UI.UI_3

Käyttöliittymä 4
    [Tags]              UI   Mandatory
    [Documentation]     Käyttöliittymä, selain: ${BROWSER}
    ...  - Muokkaustilassa "Olet muokkaustilassa..."-teksti sovelluksen yläreunassa
    PO_UI.UI_4

Käyttöliittymä 5_1
    [Tags]              UI   Mandatory
    [Documentation]     Käyttöliittymä, selain: ${BROWSER}
    ...  - "Sinulla on tallentamattomia..." -dialogi ilmestyy kaikissa tietolajeissa, kun klikkaa muokkauksen jälkeen jotain muuta kuin Tallenna tai Peruuta.
    ...  Testi alasvetolistalta muokattaville aineistoille
    PO_UI.UI_5_ddm

Käyttöliittymä 5_2_1
    [Tags]              UI   Mandatory
    [Documentation]     Käyttöliittymä, selain: ${BROWSER}
    ...  - "Sinulla on tallentamattomia..." -dialogi ilmestyy kaikissa tietolajeissa, kun klikkaa muokkauksen jälkeen jotain muuta kuin Tallenna tai Peruuta.
    ...  - Testi radiobuttonilla muokattaville aineistoille, FA_locator = form-group
    PO_UI.UI_5_radio_non-unit

Käyttöliittymä 5_2_2
    [Tags]              UI   Mandatory
    [Documentation]     Käyttöliittymä, selain: ${BROWSER}
    ...  - "Sinulla on tallentamattomia..." -dialogi ilmestyy kaikissa tietolajeissa, kun klikkaa muokkauksen jälkeen jotain muuta kuin Tallenna tai Peruuta.
    ...  - Testi radiobuttonilla muokattaville aineistoille, FA_locator = form-group-unit
    PO_UI.UI_5_radio_unit

Käyttöliittymä 5_3
    [Tags]              UI   Mandatory
    [Documentation]     Käyttöliittymä, selain: ${BROWSER}
    ...  - "Sinulla on tallentamattomia..." -dialogi ilmestyy kaikissa tietolajeissa, kun klikkaa muokkauksen jälkeen jotain muuta kuin Tallenna tai Peruuta.
    ...  Testi checkboxilla  muokattaville aineistoille
    ...  Tarkistaa tietolajien avautuvan, ei yritä muokata niitä
    Log  Testille annetaan parametrina tietolaji ja paikka jossa se testataan (osoite tai koordinaatti)
    PO_UI.UI_5_chkbx  ${TL_Suojatie_RB}  6818935,325475
    PO_UI.UI_5_chkbx  ${TL_Liikennevalo_RB}  6710880, 240330
    PO_UI.UI_5_chkbx  ${TL_Joukkoliikenteen_pysäkki_RB}  6711175, 239958
    PO_UI.UI_5_chkbx  ${TL_Palvelupiste_RB}  6711455,239920
    PO_UI.UI_5_chkbx  ${TL_Rautatien_asoristeys_RB}  6712202,240426
    PO_UI.UI_5_chkbx  ${TL_Esterakennelma_RB}  6711833,239490
    PO_UI.UI_5_chkbx  ${TL_Opastustaulu_RB}  6738106,251254

Käyttöliittymä 5_4
    [Tags]              UI   Mandatory
    [Documentation]     Käyttöliittymä, selain: ${BROWSER}
    ...  - "Sinulla on tallentamattomia..." -dialogi ilmestyy kaikissa tietolajeissa, kun klikkaa muokkauksen jälkeen jotain muuta kuin Tallenna tai Peruuta.
    ...  Testi napilla  muokattaville aineistoille
    PO_UI.UI_5_Button  ${TL_Kääntymisrajoitus_RB}  brahenkatu 10, turku

Käyttöliittymä 6
    [Tags]              UI   Mandatory
    [Documentation]     Käyttöliittymä, selain: ${BROWSER}
    ...  - Usean kohteen valinta kerralla muokattavaksi
    PO_UI.UI_6
