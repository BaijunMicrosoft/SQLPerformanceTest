1. In TestPerfinAzureStorage.txt, we have a sample database which we can deploy it to an Azure SQL DB. You can directly download it via browser.
2. deploy-sqltest-vm.ps1 will deploy a client for testing purpose. (Needs Powershell and Azure cli ready)
3. Needs to run install-packages.sh via ssh to the VM deployed in step 2. And run checkinstallation.sh to verify the installtion.
4. Also upload .sql files such as: select1.sql , select2.sql and selectintodelete1.sql to the client. (SQL files will be updated from time to time)
5. Download all .sql files, .py files and .sh files. You can directly call Allperftest.sh script


Calling examples for python and bash

Python
root@sqltest-client:/home/baijun# python3 azure_sql_concurrent.py --servername bjnrth2.database.chinacloudapi.cn --dbname testperf --username CloudSA8cbd2350 --password XXXXXXXX --sqlfile 2.sql --threads 1 --exec_per_thread 20

Bash
用法: ./Allperftest.sh <SERVERNAME> <DBNAME> <USERNAME> <PASSWORD> <workload_level>
示例: ./Allperftest.sh myserver.database.chinacloudapi.cn testdb myuser mypass high|medium|low

