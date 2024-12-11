dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

useradd roboshop

rm -rf /app
mkdir /app

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app
unzip /tmp/catalogue.zip

cd /app
npm install

CP catalogue.service /etc/systemd/system/catalogue.service
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue

cp mongodb.service /etc/yum.repos.d/mongodb.repo

dnf install mongodb-mongosh -y

mongosh --host MONGODB-SERVER-IPADDRESS </app/db/master-data.js