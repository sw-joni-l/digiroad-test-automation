# Niko Lahtinen  Sitowise  2020

*** Variables ***


*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            variables.robot

Suite Setup         LoginToLivi
Suite Teardown      Close Browser

Test Setup          Testin Aloitus


*** Test Cases ***
Tielinkit 1
    [Tags]              Roadlinks  Mandatory  Functionality
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Kun tielinkit avataan ensimmäisen kerran, toiminnallinen luokka on näkyvissä.
    ...  Myöhemmin on valittuna se ominaisuus, joka on viimeisimmäksi valittu ennen kuin on vaihdettu tietolajia.
    PO_Tielinkit.Tielinkit_1


Tielinkit 2
    [Tags]              Roadlinks  Mandatory  Functionality
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Tielinkit näkyvät ja ne saa valittua kun mittakaava on vähintään 1:20000.
    ...  Valinnan saa poistettua klikkaamalla muualle. Tielinkin valinta säilyy kun karttaa liikutellaan ja zoomaillaan.
    ...  Valinta säilyy kun vaihdetaan radionapeista, mitä ominaisuutta näytetään.
    Set Min Similarity   0.9          #oli 0.4
    PO_Tielinkit.Tielinkit_2
    #Set Min Similarity   0.6

Tielinkit 3
    [Tags]              Roadlinks  Mandatory  Functionality  Sikuli
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Tielinkkien toiminnalliset luokat vastaa kartan aineiston visualisointia ja formilla näytettävää luokkaa.
    Log  Testille annetaan parametrina toiminnallinen luokka ja paikka jossa se testataan (osoite tai koordinaatti)
    # hämeentie 33, turku
    PO_Tielinkit.Tielinkit_3  1  6711584, 241929
    PO_Tielinkit.Tielinkit_3  2  6711877, 240587
    PO_Tielinkit.Tielinkit_3  3  6711565, 239904
    PO_Tielinkit.Tielinkit_3  4  6711456, 239789
    PO_Tielinkit.Tielinkit_3  5  6711466, 239867
    PO_Tielinkit.Tielinkit_3  6  6711929, 240598
    PO_Tielinkit.Tielinkit_3  7  6712058, 240425
    PO_Tielinkit.Tielinkit_3  8  6711878, 240628

Tielinkit 4
    [Tags]              Roadlinks  Mandatory  Functionality  Sikuli
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Tielinkkien tyyppi täsmää kartan aineiston visualisointiin ja formilla näytettävään tielinkin tyyppiin.
    ...  Samalla tarkistetaan, että Kevyen liikenteen väylät ja lautta/lossiväylät ja ajopolut on visualisoitu ohuemmalla viivalla (määritelty css selectorissa, jolla aineisto tarkistetaan.)
    PO_Tielinkit.Tielinkit_4    Moottoritie                    6709118, 256445
    # Ei löydy aineistosta
    #    PO_Tielinkit.Tielinkit_4    Moottoriliikennetie
    PO_Tielinkit.Tielinkit_4    Yksiajoratainen tie            6707962, 256496
    PO_Tielinkit.Tielinkit_4    Moniajoratainen tie            6709971, 242075
    PO_Tielinkit.Tielinkit_4    Kiertoliittymä                 6711679, 239817
    PO_Tielinkit.Tielinkit_4    Ramppi                         6708746, 257816
    PO_Tielinkit.Tielinkit_4    Jalankulkualue                 6764922, 362677
    PO_Tielinkit.Tielinkit_4    Kevyen liikenteen väylä        6679499, 388913
    PO_Tielinkit.Tielinkit_4    Levähdysalue                   6709147, 256454
    PO_Tielinkit.Tielinkit_4    Ajopolku                       6707938, 256842
    PO_Tielinkit.Tielinkit_4    Huoltoaukko moottoritiellä     6707468, 247022
    PO_Tielinkit.Tielinkit_4    Lautta/lossi                   6709978, 238631

Tielinkit 5
    [Tags]              Roadlinks  Optional  Functionality  Sikuli
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Tielinkkien hallinnolliset luokat vastaa kartan aineiston visualisointia ja formilla näytettävää luokkaa.
    PO_Tielinkit.Tielinkit_5   Kunnan omistama                 6676125, 373042
    PO_Tielinkit.Tielinkit_5   Valtion omistama                6676026, 372929
    PO_Tielinkit.Tielinkit_5   Yksityisen omistama             6676188, 372978
    PO_Tielinkit.Tielinkit_5   Tuntematon                      6676135, 372839

Tielinkit 6
    [Tags]              Roadlinks  Optional  Functionality  Sikuli
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Tielinkkien silta luokat vastaa kartan aineiston visualisointia ja formilla näytettävää luokkaa.
    PO_Tielinkit.Tielinkit_6   Silta, Taso 1   6675257, 385417
    PO_Tielinkit.Tielinkit_6   Tunneli         6675627, 385374
    PO_Tielinkit.Tielinkit_6   Alikulku        6675539, 385549
    PO_Tielinkit.Tielinkit_6   Maan pinnalla   6675510, 385480

Tielinkit 7
    [Tags]              Roadlinks  Optional  Functionality  Sikuli
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Yksisuuntaiset tielinkit on visualisoitu suuntanuolella. Tarkistetaan myös liikennevirta molempiin suuntiin
    PO_Tielinkit.Tielinkit_7   6710973, 238687  ${Digitointisuuntaa vastaan}
    PO_Tielinkit.Tielinkit_7   6711042, 238819  ${Digitointisuuntaan}
    PO_Tielinkit.Tielinkit_7   6711090, 239950  ${Molempiin suuntiin}

Tielinkit 8
    [Tags]              Roadlinks  Optional  Layout
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Radionappien järjestys on: toiminnallinen luokka, tielinkin tyyppi, hallinnollinen luokka, silta, alikulku tai tunneli.
    PO_Tielinkit.Tielinkit_8

Tielinkit 9
    [Tags]              Roadlinks  Optional  Layout
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Tielinkin ominaisuustiedoissa näkyy Link ID, MML ID, viimeisin muokkaus, linkkien lukumäärä, hallinnollinen luokka,
    ...  toiminnallinen luokka, liikennevirran suunta, tielinkin tyyppi, silta/alikulku/tunneli, kuntanumero, tien nimi suomeksi,
    ...  ruotsiksi ja saameksi sekä osoitenumerot oikealla ja vasemmalla (osoitenumerot vain, kun on yksi linkki valittuna) ja tiennumero
    PO_Tielinkit.Tielinkit_9

Tielinkit 10
    [Tags]              Roadlinks  Optional  Layout
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Jos toiminnallinen luokka tai linkkityyppi ei ole tiedossa, linkki on visualisoitu mustalla.
    PO_Tielinkit.Tielinkit_10

#Tielinkit 11
    #[Tags]              Roadlinks  Optional  Functionality  Edit
    #[Documentation]     Tielinkit, selain: ${BROWSER}
    #...  - Useita tielinkkejä voi muokata kerralla piirtämällä laatikon ctrl-nappi pohjassa (toiminnallinen luokka ja linkkityyppi)
    #...  Jos testi epäonnistuu pitää testi ajaa uudelleen onnistuneesti läpi tai käydä kyseiset tilinkit muuttamassa käsin.
    #PO_Tielinkit.Tielinkit_11

Tielinkit 12
    [Tags]              Roadlinks  Optional  Functionality  Edit  Sikuli
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Tielinkin muokkaus ketjuna. Toiminnallista luokkaa, liikennevirran suuntaa ja tielinkin tyyppiä voi muokata.
    ...  Liikennevirran suuntaa ja muita ominaisuuksia muokatessa myös visualisointi muuttuu vastaavasti.
    ...  Muokattu viimeksi- tieto päivittyy tallennettaessa.
    ...  Jos testi epäonnistuu pitää käydä kyseiset tilinkit muuttamassa käsin.
    # Annetaan link id:t argumentteina jolloin niitä ei tarvitse muokata testistä jos haluaa vaihtaa testauspaikan.
    PO_Tielinkit.Tielinkit_12   6711434, 240090  Linkin ID: 5790802   Linkin ID: 5790806
    # wanha 6711445, 240108

# Ainakin toistaiseksi jätetty pois, koska osa linkeistä ei toimi testin edellyttämällä tavalla. Bugi luotu, mutta minor ja ollut tiedossa pitkään.
Tielinkit 13
    [Tags]              Roadlinks  Optional  Functionality  Edit
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Korjattavien linkkien lista, tarkistettaan että kyseisestä linkistä aukeaa lista ja sivun ryhmittely on ok.
    ...  Tarkistetaan, että listan linkeistä aukeaa kyseinen paikka
    PO_Tielinkit.Tielinkit_13
