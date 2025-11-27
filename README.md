1. In TestPerfinAzureStorage.txt, we have a sample database which we can deploy it to an Azure SQL DB. You can directly download it via browser.
2. deploy-sqltest-vm.ps1 will deploy a client for testing purpose. (Needs Powershell and Azure cli ready)
3. Needs to run install-packages.sh via ssh to the VM deployed in step 2. And run checkinstallation.sh to verify the installtion.
4. Also upload select1.sql and select2.sql to the client.

We are ready to run the pressure test and please find out the solution

Calling example

root@sqltest-client:/home/baijun# python3 azure_sql_concurrent.py --servername bjnrth2.database.chinacloudapi.cn --dbname testperf --username CloudSA8cbd2350 --password 1qaz@WSX3edc --sqlfile 2.sql --threads 1 --exec_per_thread 20
[Thread ThreadPoolExecutor-0_0] Execution 1 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 2 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 3 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 4 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 5 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 6 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 7 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 8 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 9 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 10 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 11 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 12 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 13 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 14 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 15 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 16 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 17 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 18 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 19 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 20 returned 32048 rows.
All threads completed in 103.46 seconds.
root@sqltest-client:/home/baijun# python3 azure_sql_concurrent.py --servername bjnrth2.database.chinacloudapi.cn --dbname testperf --username CloudSA8cbd2350 --password 1qaz@WSX3edc --sqlfile 2.sql --threads 1 --exec_per_thread 20
[Thread ThreadPoolExecutor-0_0] Execution 1 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 2 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 3 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 4 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 5 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 6 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 7 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 8 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 9 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 10 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 11 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 12 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 13 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 14 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 15 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 16 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 17 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 18 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 19 returned 32048 rows.
[Thread ThreadPoolExecutor-0_0] Execution 20 returned 32048 rows.
All threads completed in 155.80 seconds.
root@sqltest-client:/home/baijun# python3 azure_sql_concurrent.py --servername bjnrth2.database.chinacloudapi.cn --dbname testperf --username CloudSA8cbd2350 --password 1qaz@WSX3edc --sqlfile 1.sql --threads 1 --exec_per_thread 20
[Thread ThreadPoolExecutor-0_0] Execution 1 returned 2259 rows.
[Thread ThreadPoolExecutor-0_0] Execution 2 returned 2259 rows.
[Thread ThreadPoolExecutor-0_0] Execution 3 returned 2259 rows.
[Thread ThreadPoolExecutor-0_0] Execution 4 returned 2259 rows.
[Thread ThreadPoolExecutor-0_0] Execution 5 returned 2259 rows.
[Thread ThreadPoolExecutor-0_0] Execution 6 returned 2259 rows.
[Thread ThreadPoolExecutor-0_0] Execution 7 returned 2259 rows.
[Thread ThreadPoolExecutor-0_0] Execution 8 returned 2259 rows.
[Thread ThreadPoolExecutor-0_0] Execution 9 returned 2259 rows.
[Thread ThreadPoolExecutor-0_0] Execution 10 returned 2259 rows.
[Thread ThreadPoolExecutor-0_0] Execution 11 returned 2259 rows.
[Thread ThreadPoolExecutor-0_0] Execution 12 returned 2259 rows.
[Thread ThreadPoolExecutor-0_0] Execution 13 returned 2259 rows.
[Thread ThreadPoolExecutor-0_0] Execution 14 returned 2259 rows.
[Thread ThreadPoolExecutor-0_0] Execution 15 returned 2259 rows.
[Thread ThreadPoolExecutor-0_0] Execution 16 returned 2259 rows.
[Thread ThreadPoolExecutor-0_0] Execution 17 returned 2259 rows.
[Thread ThreadPoolExecutor-0_0] Execution 18 returned 2259 rows.
[Thread ThreadPoolExecutor-0_0] Execution 19 returned 2259 rows.
[Thread ThreadPoolExecutor-0_0] Execution 20 returned 2259 rows.
All threads completed in 51.44 seconds.
