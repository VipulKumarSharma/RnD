@echo off
echo This will re-direct the application into Maintenance Mode
echo If you want to continue press any key otherwise press Ctrl+c
Pause

rename index.jsp index_Main.jsp
rename index_Maintenance.jsp index.jsp

cd..
cd.. 
del work\Catalina\star\org\apache\jsp\index_jsp.java
del work\Catalina\star\org\apache\jsp\index_jsp.class