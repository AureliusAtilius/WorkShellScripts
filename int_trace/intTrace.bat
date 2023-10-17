:: This script allows you to trace a network cable to the IDF by
:: enabling and disabling  a local ethernet interface
:: in order to cause a slow blink on an access layer switch interface.
:begin
netsh interface set interface "ethernet 4" admin=disable

netsh interface set interface "ethernet 4" admin=enable

PING 1.1.1.1 

Goto Begin