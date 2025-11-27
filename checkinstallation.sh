#!/bin/bash

echo "===== Checking system packages ====="

# Array of required apt packages
APT_PACKAGES=("python3" "python3-pip" "unixodbc-dev" "curl" "msodbcsql18")
for pkg in "${APT_PACKAGES[@]}"; do
    if dpkg -s "$pkg" &>/dev/null; then
        echo "[OK] $pkg is installed."
    else
        echo "[MISSING] $pkg is NOT installed."
    fi
done

echo
echo "===== Checking Python packages ====="

# Array of required python3 packages
PYTHON_PACKAGES=("pyodbc" "pandas")
for pkg in "${PYTHON_PACKAGES[@]}"; do
    if python3 -c "import $pkg" &>/dev/null; then
        echo "[OK] Python package '$pkg' is installed."
    else
        echo "[MISSING] Python package '$pkg' is NOT installed."
    fi
done

echo
echo "===== Checking ODBC driver ====="
if command -v odbcinst &>/dev/null; then
    echo "[INFO] odbcinst command found."
    echo "Installed ODBC drivers:"
    odbcinst -q -d
else
    echo "[MISSING] odbcinst command not found — unixodbc may not be installed."
fi

echo
echo "===== Installation check completed ====="

