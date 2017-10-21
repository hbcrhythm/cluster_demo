@echo off
taskkill /f /im werl.exe
start start_gate.bat
start start_auth.bat
start start_center.bat
start start_connector_1.bat
start start_connector_2.bat
start start_logic_1.bat
start start_logic_2.bat