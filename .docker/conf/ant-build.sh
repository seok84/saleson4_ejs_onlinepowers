/usr/local/ant/exec/ant -Dtomcat.home=/usr/local/tomcat -Dwebapp.path=/usr/local/tomcat/webapps/ROOT -buildfile /usr/local/tomcat/conf/build.xml

#cp -r /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/org /usr/local/tomcat/work/Catalina/localhost/ROOT/org

find /usr/local/tomcat/webapps/ROOT/WEB-INF/views -exec touch -t $(date '+%Y%m%d')0000 {} \;
#find /usr/local/tomcat/work/Catalina/localhost/ROOT/org -exec touch -t $(date '+%Y%m%d')0000 {} \;

