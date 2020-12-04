*** Settings ***
Library  SeleniumLibrary
#Library  selenium_extensions.py

*** Test Cases ***

Testi
    Log To Console  Hello Test
    Open Browser  https://www.google.com  Headless Chrome
    Title Should Be  Google
    Close Browser