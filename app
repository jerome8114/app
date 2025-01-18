from tkinter import*
from tkinter import messagebox
import sqlite3

a = Tk()
a.geometry("800x210")
a.title("App")
a.configure(bg="#024950")  

def database(): 
    con = sqlite3.connect('app.db')
    cursor_obj =con.cursor()
    tbl = """ CREATE TABLE IF NOT EXISTS Data(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            Name VARCHAR(255) NOT NULL,
            Age VARCHAR(255) NOT NULL,
            Phone VARCHAR(255) NOT NULL            
        ); """
    cursor_obj.execute(tbl)
    con.commit()
    con.close()

def insertadd():
    name = name_entry.get()
    age = age_entry.get()
    phone = phone_entry.get()
    print(name)
    print(age)
    print(phone)
    con = sqlite3.connect('app.db')
    cursor_obj =con.cursor()
    cursor_obj.execute(" INSERT INTO Data(Name, Age, Phone) VALUES(?, ?, ?); ",(name, age, phone))
    con.commit()
    con.close()
    loadrecord()
    messagebox.showinfo("Success", "Record added successfully")

def loadrecord():
    record_list.delete(0, END)
    con = sqlite3.connect('app.db')
    cursor_obj =con.cursor()
    cursor_obj.execute(" SELECT * FROM Data ")
    output = cursor_obj.fetchall()
    for row in output:
        record_list.insert(END, row)
    con.commit()
    con.close()

def delete():    
    record = record_list.get(record_list.curselection()) 
    record_id = record[0]
    con = sqlite3.connect('app.db')
    cursor_obj =con.cursor()
    cursor_obj.execute(" DELETE FROM Data WHERE id = ? ",(record_id,))
    con.commit()
    con.close() 
    loadrecord()
    cleandata()
    messagebox.showinfo("Success", "Delete successfully")

def cleandata():
    name_entry.delete(0, END)
    age_entry.delete(0, END)
    phone_entry.delete(0, END) 

def updatedata():
    name = name_entry.get()
    age = age_entry.get()
    phone = phone_entry.get()
    record = record_list.get(record_list.curselection()) 
    record_id = record[0]
    con = sqlite3.connect('app.db')
    cursor_obj =con.cursor()
    cursor_obj.execute(" UPDATE Data SET id = ?,Name = ?, age = ?, phone = ? ",(record_id,name,age,phone,))
    con.commit()
    con.close()
    loadrecord()
    cleandata()
    messagebox.showinfo("Success", "Updated successfully") 

database()
Label(a, text="Enter your name", bg="#024950", fg="#003135").place(x= 20, y= 20)
name_entry =  Entry(a, bg="#afdde5")
name_entry.place(x= 20, y= 50)

Label(a, text="Enter your age", bg="#024950", fg="#003135").place(x= 20, y= 80)
age_entry =  Entry(a, bg="#afdde5")
age_entry.place(x= 20, y= 110)

Label(a, text="Enter your phone", bg="#024950", fg="#003135").place(x= 20, y= 140)
phone_entry =  Entry(a, bg="#afdde5")
phone_entry.place(x= 20, y= 170)

add_btn = Button(a, text="Add Record", command=insertadd, width= 20, bg="#afdde5", fg="#003135")
add_btn.place(x=600, y=30)

update_btn = Button(a, text="Update Record", command=updatedata, width= 20, bg="#afdde5", fg="#003135")
update_btn.place(x=600, y=90)

delete_btn = Button(a, text="Delete Record", command=delete, width= 20, bg="#afdde5", fg="#003135")
delete_btn.place(x=600, y=150)

record_list = Listbox(a, height=11, width=60, bg="black", fg="#024950")
record_list.place(x= 200, y= 20)


# Define column widths and formatting


# Insert headers with simulated column separation

loadrecord()


a.mainloop()
