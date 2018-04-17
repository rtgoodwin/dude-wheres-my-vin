*** Settings ***
Documentation     A resource file for checking on a Tesla Account.
Library           Selenium2Library

*** Variables ***
${USERNAME}             user@example.com
${PASSWORD}             thisisnotagoodpassword
${RESERVATION NUMBER}   123456789
${BROWSER}              Chrome
${DELAY}                0
${LOGIN URL}            https://auth.tesla.com/login
${ACCOUNT URL}          https://www.tesla.com/teslaaccount
${RESERVATION URL}      ${ACCOUNT URL}/profile?rn=RN${RESERVATION NUMBER}

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Title Should Be    Tesla SSO – Login

Input Username
    [Arguments]    ${username}
    Input Text    email    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    password    ${password}

Submit Credentials
    Click Button    Sign In

Authenticate
    Open Browser To Login Page
    Input Username    ${USERNAME}
    Input Password    ${PASSWORD}
    Submit Credentials
    Title Should Be    Tesla Account | Tesla
    Go To    ${RESERVATION URL}

Notify
    [Arguments]    ${message}
    Run Keyword If    '${TEST STATUS}' == 'PASS'    Run    pb push "${message}"

Cleanup
    Close Browser