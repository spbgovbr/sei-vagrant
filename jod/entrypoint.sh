#!/usr/bin/env bash 

SOFFICE_PATH=/usr/bin/soffice
TOMCAT6_PATH=/opt/jodconverter-tomcat-2.2.2/bin/catalina.sh

echo "Iniciando o serviço LibreOffice headless ..."
$SOFFICE_PATH --headless --nologo --nofirststartwizard --accept="socket,host=127.0.0.1,port=8100;urp" & > /dev/null 2>&1

echo "Iniciando o serviço Tomcat 6 ..."
$TOMCAT6_PATH run
