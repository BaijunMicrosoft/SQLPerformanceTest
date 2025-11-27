import pyodbc
import argparse
import threading
from concurrent.futures import ThreadPoolExecutor
import time

def connect_db(servername, dbname, username, password):
    """Create and return a new database connection."""
    connection_str = (
        f"DRIVER={{ODBC Driver 18 for SQL Server}};"
        f"SERVER={servername};"
        f"DATABASE={dbname};"
        f"UID={username};"
        f"PWD={password};"
        f"Encrypt=yes;"
        f"TrustServerCertificate=no;"
        f"Connection Timeout=30;"
    )
    return pyodbc.connect(connection_str)

def read_sql_file(filepath):
    """Read SQL from file."""
    with open(filepath, 'r') as f:
        return f.read()

def execute_sql_task(servername, dbname, username, password, sql_statement, exec_count):
    """Execute SQL multiple times in a single thread."""
    try:
        conn = connect_db(servername, dbname, username, password)
        cursor = conn.cursor()

        for i in range(exec_count):
            cursor.execute(sql_statement)
            try:
                rows = cursor.fetchall()
                print(f"[Thread {threading.current_thread().name}] Execution {i+1} returned {len(rows)} rows.")
            except pyodbc.ProgrammingError:
                # No results to fetch
                print(f"[Thread {threading.current_thread().name}] Execution {i+1} completed (no results).")
            
            conn.commit()

        cursor.close()
        conn.close()
    except Exception as e:
        print(f"[Thread {threading.current_thread().name}] Error: {e}")

def main():
    parser = argparse.ArgumentParser(description="Azure SQL concurrent execution script")
    parser.add_argument('--servername', required=True, help='Azure SQL Server name or hostname')
    parser.add_argument('--dbname', required=True, help='Database name')
    parser.add_argument('--username', required=True, help='Username for Azure SQL')
    parser.add_argument('--password', required=True, help='Password for Azure SQL')
    parser.add_argument('--sqlfile', required=True, help='Path to the SQL file to read')
    parser.add_argument('--threads', type=int, default=1, help='Number of concurrent threads')
    parser.add_argument('--exec_per_thread', type=int, default=1, help='Number of executions per thread')

    args = parser.parse_args()

    sql_statement = read_sql_file(args.sqlfile)

    start_time = time.time()
    with ThreadPoolExecutor(max_workers=args.threads) as executor:
        futures = [
            executor.submit(
                execute_sql_task,
                args.servername,
                args.dbname,
                args.username,
                args.password,
                sql_statement,
                args.exec_per_thread
            )
            for _ in range(args.threads)
        ]

        for f in futures:
            f.result()  # Wait for completion

    end_time = time.time()
    print(f"All threads completed in {end_time - start_time:.2f} seconds.")

if __name__ == "__main__":
    main()

