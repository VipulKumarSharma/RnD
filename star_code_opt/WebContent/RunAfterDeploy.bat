@echo off
echo This will change from Maintenance Mode to Application Mode
echo If you want to continue press any key otherwise press Ctrl+c
Pause

rename index.jsp index_Maintenance.jsp 
rename index_Main.jsp index.jsp

cd..
cd.. 
del work\Catalina\star\org\apache\jsp\index_jsp.java
del work\Catalina\star\org\apache\jsp\index_jsp.class