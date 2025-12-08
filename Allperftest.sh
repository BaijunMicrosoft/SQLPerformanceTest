#!/bin/bash

# ==== 参数检查 ====
if [ "$#" -ne 4 ]; then
    echo "用法: $0 <SERVERNAME> <DBNAME> <USERNAME> <PASSWORD>"
    echo "示例: $0 myserver.database.chinacloudapi.cn testdb myuser mypass"
    exit 1
fi

SERVERNAME="$1"
DBNAME="$2"
USERNAME="$3"
PASSWORD="$4"

# Python 脚本位置
PY_SCRIPT="azure_sql_concurrent.py"

# 检查 Python 脚本是否存在
if [ ! -f "$PY_SCRIPT" ]; then
    echo "错误: 找不到 Python 脚本 $PY_SCRIPT"
    exit 1
fi

# ==== 执行函数 ====
run_sql_test() {
    local sqlfile="$1"
    local threads="$2"
    local execs="$3"

    echo
    echo "==== 开始执行 $sqlfile (threads=$threads, exec_per_thread=$execs) ===="
    # 检查 sql 文件是否存在
    if [ ! -f "$sqlfile" ]; then
        echo "错误: SQL文件 '$sqlfile' 不存在，请检查路径！"
        exit 1
    fi

    python3 "$PY_SCRIPT" \
        --servername "$SERVERNAME" \
        --dbname "$DBNAME" \
        --username "$USERNAME" \
        --password "$PASSWORD" \
        --sqlfile "$sqlfile" \
        --threads "$threads" \
        --exec_per_thread "$execs"
}

# ==== 测试顺序 ====
run_sql_test "select1.sql" 4 15
sleep 30

run_sql_test "select2.sql" 2 10
sleep 30

run_sql_test "selectio1.sql" 2 15
sleep 30

run_sql_test "selectio2.sql" 1 10
sleep 30

run_sql_test "selectintodelete1.sql" 1 10
sleep 30

# ==== 预热阶段（无间隔直连性能测试）====
run_sql_test "createidx.sql" 1 1
run_sql_test "createsp.sql" 1 1
run_sql_test "callsp1.sql" 1 1

# ==== 性能测试阶段 ====
run_sql_test "callspperf1.sql" 2 15
run_sql_test "dropidx.sql" 1 1

echo
echo "=== 所有测试执行完成！==="

