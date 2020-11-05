# Antti Salo        Dimenteq Oy     2016
# Kaikki:       pybot -L TRACE -T Digiroad
# pybot -L TRACE -T -v BROWSER:CHROME Digiroad
# testi pybot -L TRACE -T -t "Käyttöliittymä 4" Digiroad

# Tagin mukaan: pybot -L TRACE -T -i muumi Digiroad

# pybot -L TRACE -T -R output-XX.xml Digiroad

*** Variables ***


*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus


*** Test Cases ***
KartanKäyttö 1
    [Tags]              Map   Mandatory
    [Documentation]     Kartan käyttö, selain: ${BROWSER}
    ...  - Kartan käyttö zoom-napeilla, tuplaklikkaamalla ja SHIFT+piirto
    KW_Kartta.Kartta_1

KartanKäyttö 2
    [Tags]              Map   Mandatory
    [Documentation]     Kartan käyttö, selain: ${BROWSER}
    ...  - Kartan liikuttaminen raahaamalla ja haulla
    KW_Kartta.Kartta_2

KartanKäyttö 3
    [Tags]              Map   Mandatory
    [Documentation]     Kartan käyttö, selain: ${BROWSER}
    ...  - Taustakartaksi voi valita ortokuvat, taustakarttasarjan tai maastokartan.
    KW_Kartta.Kartta_3

KartanKäyttö 4
    [Tags]              Map   Mandatory
    [Documentation]     Kartan käyttö, selain: ${BROWSER}
    ...  - Sovellus näyttää viestin "Zoomaa lähemmäksi, jos haluat nähdä kohteita", kun mittakaavataso on liian pieni.
    KW_Kartta.Kartta_4
