setlocal 

FOR /F "tokens=4 delims=/ " %%i IN ('wsl ip -4 -o addr show eth0') DO set wsl2_eth0=%%i
FOR /F "tokens=4 delims=/ " %%i IN ('wsl ip -4 -o addr show docker0') DO set wsl2_docker0=%%i

netsh interface portproxy delete v4tov4 8000 0.0.0.0
netsh interface portproxy delete v4tov4 8080 0.0.0.0
netsh interface portproxy delete v4tov4 8211 0.0.0.0
netsh interface portproxy delete v4tov4 5000 0.0.0.0
netsh interface portproxy delete v4tov4 25565 0.0.0.0
REM netsh interface portproxy delete v4tov4 25575 0.0.0.0
netsh interface portproxy delete v4tov4 1935 0.0.0.0
netsh interface portproxy delete v4tov4 2222 0.0.0.0
netsh interface portproxy delete v4tov4 6379 0.0.0.0

netsh interface portproxy add v4tov4 8000 %wsl2_eth0% 8000 0.0.0.0
netsh interface portproxy add v4tov4 5000 %wsl2_eth0% 5000 0.0.0.0
netsh interface portproxy add v4tov4 8211 %wsl2_eth0% 8211 0.0.0.0
netsh interface portproxy add v4tov4 8080 %wsl2_eth0% 8080 0.0.0.0
netsh interface portproxy add v4tov4 1935 %wsl2_eth0% 1935 0.0.0.0
netsh interface portproxy add v4tov4 2222 %wsl2_eth0% 22 0.0.0.0
netsh interface portproxy add v4tov4 6379 %wsl2_eth0% 6379 0.0.0.0

netsh interface portproxy add v4tov4 25565 %wsl2_eth0% 25565 0.0.0.0
REM netsh interface portproxy add v4tov4 25575 %wsl2_eth0% 25575 0.0.0.0

endlocal