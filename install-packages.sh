#!/bin/bash
set -e

echo "Updating package lists..."
sudo apt-get -y update

echo "Installing Python and dependencies..."
sudo apt-get -y install python3 python3-pip unixodbc-dev curl

echo "Adding Microsoft key and repository..."
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo apt-add-repository https://packages.microsoft.com/ubuntu/22.04/prod

echo "Updating package lists again..."
sudo apt-get -y update

echo "Installing Microsoft ODBC driver..."
sudo apt-get -y install msodbcsql18

echo "Installing Python packages pyodbc and pandas..."
pip3 install pyodbc pandas

echo "Package installation completed successfully."

