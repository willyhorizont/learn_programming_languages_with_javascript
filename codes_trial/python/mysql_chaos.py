import mysql.connector

# mysql -u root -p

# Establish the connection
connection = mysql.connector.connect(host="localhost", user="root", password="root", database="chaos")

# Create a cursor object
cursor = connection.cursor()

# Example: Create a table
cursor.execute("CREATE TABLE IF NOT EXISTS users (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), age INT)")

# Example: Insert data
cursor.execute("INSERT INTO users (name, age) VALUES (%s, %s)", ("Alice", 30))
cursor.execute("INSERT INTO users (name, age) VALUES (%s, %s)", ("Bob", 25))

# Commit the changes
connection.commit()

# Example: Query data
cursor.execute("SELECT * FROM users")
for row in cursor.fetchall():
    print(row)  # Print each row

# Close the cursor and connection
cursor.close()
connection.close()
