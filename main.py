import psycopg2

conn = psycopg2.connect(
    dbname='questiondb', 
    user='postgres', 
    password='Soma@14002',       
    host='localhost',
    port='5432'
)
cur = conn.cursor()

#create-
def create_student(name, email, age):
    cur.execute("INSERT INTO students (name, email, age) VALUES (%s, %s, %s)", (name, email, age))
    conn.commit()
    print("Student created successfully.")

#Read--
def read_students():
    cur.execute("SELECT * FROM students")
    rows = cur.fetchall()
    if rows:
        print("\n--- Student List ---")
        for row in rows:
            print(f"ID: {row[0]}, Name: {row[1]}, Email: {row[2]}, Age: {row[3]}")
    else:
        print("No students found.")

#Update--
def update_student(student_id, name, email, age):
    cur.execute("UPDATE students SET name = %s, email = %s, age = %s WHERE id = %s", (name, email, age, student_id))
    conn.commit()
    if cur.rowcount > 0:
        print("Student updated successfully.")
    else:
        print("Student not found.")

#Delete--
def delete_student(student_id):
    cur.execute("DELETE FROM students WHERE id = %s", (student_id,))
    conn.commit()
    if cur.rowcount > 0:
        print("Student deleted successfully.")
    else:
        print("Student not found.")        


#Menu--
def menu():
    while True:
        print("\n--- Student CRUD Menu ---")
        print("1. Add Student")
        print("2. Veiw Student")
        print("3. Update Student")
        print("4. Delete Student")
        print("5. Exit")
        choice = input("Enter your choice: ")

        if choice == '1':
            name = input("Enter student name: ")
            email = input("Enter student email: ")
            age = int(input("Enter student age: "))
            create_student(name, email, age)
        elif choice == '2':
            read_students()
        elif choice == '3':
            student_id = int(input("Enter student ID to update: "))
            name = input("Enter new student name: ")
            email = input("Enter new student email: ")
            age = int(input("Enter new student age: "))
            update_student(student_id, name, email, age)
        elif choice == '4':
            student_id = int(input("Enter student ID to delete: "))
            delete_student(student_id)
        elif choice == '5': 
            print("Exiting the program.")
            break    
        else:
            print("Invalid choice. Please try again.")    

menu()

# Close the cursor and connection
cur.close() 
conn.close()
print("Database connection closed.")
