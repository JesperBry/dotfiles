:: Install choco .exe and add choco to PATH
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"


echo "Install packages!"

:: Install all the packages
choco install make -y
choco install nodejs -y
choco install quicklook -y
choco install docker-desktop -y
choco install git -y
choco install yarn -y
choco install vscode -y
choco install googlechrome -y
choco install python -y
choco install mongodb -y
choco install mysql -y
choco install slack -y
choco install spotify -y
choco install vlc -y
choco install postman -y
choco install 7zip -y
choco install powertoys -y

echo "Windows setup completed!"
pause