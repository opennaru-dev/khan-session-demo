# Create WLS 12.1.2 Domain
# Read Template
WLS_HOME=os.environ["WLS_HOME"];
DOMAIN_NAME=os.environ["DOMAIN_NAME"];
BIND_IP=os.environ["BIND_IP"];
JAVA_HOME=os.environ["JAVA_HOME"];
WLS_PW=os.environ["WLS_PW"];


print('Read Template')
readTemplate(WLS_HOME + '/wlserver/common/templates/wls/wls.jar');
# Configure Administrative Username and Password
print('Configure Administrative Username and Password');
cd('Security/base_domain/User/weblogic');
set('Name','weblogic');
cmo.setPassword(WLS_PW);
# Domain Mode Configuration
print('Domain Mode Configuration');
cd('/');
set('ProductionModeEnabled','false');
# Set JDK
print('Set JDK');
setOption('JavaHome',JAVA_HOME);
# Configure the Administration Server
print('Configure the Administration Server');
cd('Servers/AdminServer');
set('Name','Weblogic_Test_Server');
set('ListenAddress',BIND_IP);
set('ListenPort',7001);
# Create Domain
print('Create Domain');
cd('/');
writeDomain(WLS_HOME + '/domains/'+ DOMAIN_NAME);
closeTemplate();
exit();

