# Joni Laari        Sitowise Oy     2022

*** Variables ***

*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus


*** Test Cases ***
Ajoneuvorajoitus 1
    [Tags]  AWS  Rajoite
    [Documentation]  Ajoneuvorajoituksen tarkastelu katselumoodissa.

    KW_Ajoneuvokohtainenrajoitus.Ajoneuvorajoite_1      6901965, 433783


Ajoneuvorajoitus 2
    [Tags]  AWS  Rajoite
    [Documentation]  Ajoneuvorajoituksen muokkaus koko ketjulle

    KW_Ajoneuvokohtainenrajoitus.Ajoneuvorajoite_2      6901965, 433783


Ajoneuvorajoitus 3
    [Tags]  AWS  Rajoite
    [Documentation]  Ajoneuvorajoituksen muokkaus ketjun osalle (tuplaklikkaus)

    KW_Ajoneuvokohtainenrajoitus.Ajoneuvorajoite_3      6674192, 386227


Ajoneuvorajoitus 4
    [Tags]  AWS  Rajoite
    [Documentation]  Lisätään uusi ajoneuvorajoite

    KW_Ajoneuvokohtainenrajoitus.Ajoneuvorajoite_4      6902133, 432084


Ajoneuvorajoitus 5
    [Tags]  AWS  Rajoite
    [Documentation]  Poistetaan edellisessä luotu rajoite

    KW_Ajoneuvokohtainenrajoitus.Ajoneuvorajoite_4      6902484, 431976


Ajoneuvorajoitus 6
    [Tags]  AWS  Rajoite
    [Documentation]  Usean kohteen valinta ja muokkaus monikulmiovalinnalla.

    KW_Ajoneuvokohtainenrajoitus.Ajoneuvorajoite_4      6902484, 431976


Ajoneuvorajoitus 7
    [Tags]  AWS  Rajoite
    [Documentation]  Ajoneuvorajoituksen katkaisu kahdeksi osaksi leikkaustyökalulla.

    KW_Ajoneuvokohtainenrajoitus.Ajoneuvorajoite_4      6902484, 431976

