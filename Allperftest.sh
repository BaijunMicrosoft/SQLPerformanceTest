#!/bin/bash

# ==== 参数检查 ====
if [ "$#" -lt 5 ]; then
    echo "用法: $0 <SERVERNAME> <DBNAME> <USERNAME> <PASSWORD> <workload_level>"
    echo "示例: $0 myserver.database.chinacloudapi.cn testdb myuser mypass high|medium|low"
    exit 1
fi

SERVERNAME="$1"
DBNAME="$2"
USERNAME="$3"
PASSWORD="$4"
WORKLOAD="$5"  # high | medium | low

PY_SCRIPT="azure_sql_concurrent.py"

# 检查 Python 脚本
if [ ! -f "$PY_SCRIPT" ]; then
    echo "错误: 找不到 Python 脚本 $PY_SCRIPT"
    exit 1
fi

# 执行函数
run_sql_test() {
    local sqlfile="$1"
    local threads="$2"
    local execs="$3"

    echo
    echo "==== 开始执行 $sqlfile (threads=$threads, exec_per_thread=$execs) ===="
    if [ ! -f "$sqlfile" ]; then
        echo "错误: SQL文件 '$sqlfile' 不存在！"
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

# 档次参数映射
case "$WORKLOAD" in
    high)
        THREADS=(8 4 4 2 1 8)
        EXECS=(50 30 30 15 5 30)
        ;;
    medium)
        THREADS=(4 2 2 2 1 4)
        EXECS=(30 20 15 12 3 20)
        ;;
    low)
        THREADS=(4 2 2 1 1 4)
        EXECS=(15 10 15 10 2 5)
        ;;
    *)
        echo "错误: 未知 workload 档次 '$WORKLOAD'，请使用 high|medium|low"
        exit 1
        ;;
esac

# ==== 基础阶段（通用部分） ====
BASE_SQL=(
    "select1.sql"
    "select2.sql"
    "selectio1.sql"
    "selectio2.sql"
    "selectintodelete1.sql"
)

for i in "${!BASE_SQL[@]}"; do
    run_sql_test "${BASE_SQL[$i]}" "${THREADS[$i]}" "${EXECS[$i]}"
    sleep 30
done

# ==== 预处理阶段（在性能测试前执行） ====
echo
echo "=== 开始预处理阶段 ==="
run_sql_test "createidx.sql" 1 1
run_sql_test "createsp.sql" 1 1
run_sql_test "callsp1.sql" 1 1
echo "=== 预处理完成 ==="

# ==== 性能测试阶段 ====
# callspperf1.sql 的线程/执行次数来自档次数组第 6 个元素
echo
echo "=== 开始性能测试阶段 ==="
run_sql_test "callspperf1.sql" "${THREADS[5]}" "${EXECS[5]}"

# 收尾阶段
run_sql_test "dropidx.sql" 1 1

echo
echo "=== 所有测试执行完成！==="

