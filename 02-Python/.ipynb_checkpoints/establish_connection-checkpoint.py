import pymysql

host_name = "127.0.0.1"
host_ip = "127.0.0.1"
port = "22"

user_id = "root"
pwd = "Sadwilcha1712!"
db_name = "northwind"

conn = pymysql.connect(host=host_name, user=user_id, passwd=pwd, db=db_name, port=3306)
cursor = conn.cursor()

try:
    cursor.execute('SELECT * FROM products;')
    
    for row in cursor.fetchmany(size=5):
        print(row)
        
    cursor.close()
    
except:
    print ("Error: unable to fetch data")
    
conn.close()