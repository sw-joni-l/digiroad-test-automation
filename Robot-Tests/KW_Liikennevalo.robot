*** Settings ***
Documentation  Testit ajetaan suoraan api:n kautta. 


*** Keywords ***
Valo 1
    #testipaikan koordinaatit 6881312, 290858
    ${json}=  Muunna Json  ${Liikennevalo_json}
    #Init Session
    Log  Talletetaan uusi liikennevalo
    ${response}=  POST On Session  Digiroad  ${API_URI_TL}  json=${json}
    Log  Etsitään talletettu liikennevalo bbox haulla
    ${hakutulos}=  Suorita BB Haku  ${API_URI_TL}  ${Likennevalo_bbox}
    ${n}=  Get Length  ${hakutulos}[propertyData]
    Log  Tarkisetaan että talletetut arvot ovat oikein
    FOR  ${i}  IN RANGE  ${n}
        ${status}=  Run Keyword And Return Status  Dictionary Should Contain Key  ${Tiedot}  ${hakutulos}[propertyData][${i}][publicId]
        Run Keyword If  ${status}  Should Be Equal As Strings  ${hakutulos}[propertyData][${i}][values][0][propertyDisplayValue]  ${tiedot}[${hakutulos}[propertyData][${i}][publicId]]
    END
    [Teardown]  Poista Kohde Apin Kautta  ${API_URI_TL}  ${response.content}



Tarkista Liikennevalon Tiedot  
    [Arguments]  ${data}
    ${data}=  Convert To String  ${data}
    FOR  ${line}  IN  @{Tiedot}
        Should Contain  ${data}  ${line}
    END


*** Variables ***
${API_URI_TL}      api/trafficLights
${Liikennevalo_json}  {"asset":{"propertyData": [
...     {"groupedId":1,"name":"Tyyppi","propertyType":"single_choice","publicId":"trafficLight_type","values":[{"propertyValue":1}],"localizedName":"Tyyppi"},
...     {"groupedId":1,"name":"Opastimen suhteellinen sijainti","propertyType":"single_choice","publicId":"trafficLight_relative_position","values":[{"propertyValue":"2","propertyDisplayValue":""}],"localizedName":"Opastimen suhteellinen sijainti"},
...     {"groupedId":1,"name":"Opastimen rakennelma","propertyType":"single_choice","publicId":"trafficLight_structure","values":[{"propertyValue":"1","propertyDisplayValue":""}],"localizedName":"Opastimen rakennelma"},
...     {"groupedId":1,"name":"Alituskorkeus","propertyType":"number","publicId":"trafficLight_height","values":[{"propertyValue":"500","propertyDisplayValue":""}],"localizedName":"Alituskorkeus"},
...     {"groupedId":1,"name":"Äänimerkki","propertyType":"single_choice","publicId":"trafficLight_sound_signal","values":[{"propertyValue":"2","propertyDisplayValue":""}],"localizedName":"Äänimerkki"},
...     {"groupedId":1,"name":"Ajoneuvon tunnistus","propertyType":"single_choice","publicId":"trafficLight_vehicle_detection","values":[{"propertyValue":"2","propertyDisplayValue":""}],"localizedName":"Ajoneuvon tunnistus"},
...     {"groupedId":1,"name":"Painonappi","propertyType":"single_choice","publicId":"trafficLight_push_button","values":[{"propertyValue":"2","propertyDisplayValue":""}],"localizedName":"Painonappi"},
...     {"groupedId":1,"name":"Lisätieto","propertyType":"text","publicId":"trafficLight_info","values":[{"propertyValue":"abcd","propertyDisplayValue":""}],"localizedName":"Lisätieto"},
...     {"groupedId":1,"name":"Kaistan tyyppi","propertyType":"single_choice","publicId":"trafficLight_lane_type","values":[{"propertyValue":"1","propertyDisplayValue":""}],"localizedName":"Kaistan tyyppi"},
...     {"groupedId":1,"name":"Kaista","propertyType":"number","publicId":"trafficLight_lane","values":[{"propertyValue":"11","propertyDisplayValue":""}],"localizedName":"Kaista"},
...     {"groupedId":1,"name":"Maastosijainti X","propertyType":"number","publicId":"location_coordinates_x","values":[],"localizedName":"Maastosijainti X"},
...     {"groupedId":1,"name":"Maastosijainti Y","propertyType":"number","publicId":"location_coordinates_y","values":[],"localizedName":"Maastosijainti Y"},
...     {"groupedId":1,"name":"Kunta ID","propertyType":"text","publicId":"trafficLight_municipality_id","values":[{"propertyValue":"12345","propertyDisplayValue":""}],"localizedName":"Kunta ID"},
...     {"groupedId":1,"name":"Tila","propertyType":"single_choice","publicId":"trafficLight_state","values":[{"propertyValue":3}],"localizedName":"Tila"},
...     {"groupedId":1,"name":"Vihjetieto","propertyType":"checkbox","publicId":"suggest_box","values":[{"propertyValue":0}],"localizedName":"Vihjetieto"},
...     {"groupedId":1,"name":"Suunta","propertyType":"hidden","publicId":"bearing","values":[{"propertyValue":275.6615917376728,"propertyDisplayValue":""}]},
...     {"groupedId":1,"name":"Sidecode","propertyType":"hidden","publicId":"sidecode","values":[{"propertyValue":2}]}],"lon":290835.3524533717,"lat":6881313.210069366,"floating":false,"linkId":3881933,"id":0,"bearing":275.6615917376728,"administrativeClass":"Municipality"}}

&{Tiedot}       trafficLight_type=Valo-opastin  trafficLight_info=abcd  trafficLight_municipality_id=12345
...             trafficLight_structure=Pylväs  trafficLight_lane_type=Pääkaista  trafficLight_state=Käytössä pysyvästi  
...             trafficLight_height=500  trafficLight_lane=11  trafficLight_vehicle_detection=Infrapunailmaisin
...             trafficLight_relative_position=Kaistojen yläpuolella

${Likennevalo_bbox}  bbox=290810.6542203504,6881244.247584128,290900.2792203504,6881380.372584128