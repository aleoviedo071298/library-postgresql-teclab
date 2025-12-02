# 📚 Library Database – Final Project
### Teclab – Programming Degree  
**Author:** Alejandro Oviedo  
**Year:** 2025  

This repository contains the **Final Project for the Database assignature**, built entirely in **PostgreSQL 18**.  
It implements a complete library management database with tables, relationships, functions, triggers, views, and real sample data according to the academic requirements.

---

# 🚀 Project Contents

The file **`biblioteca_completa.sql`** includes:

### ✔️ Full database structure
- **lectores** (readers)
- **libros** (books)
- **alquileres** (rentals)
- **logs_devoluciones** (return logs – Activity 4 requirement)
- Primary and foreign keys
- Sequences and auto-increment settings
- View: **libros_prestados**

### ✔️ Data included
- 10 readers  
- 10 books  
- Rental records  
- Automatic logs generated through triggers during book returns  

### ✔️ PL/pgSQL Functions
- `devolver_libro(p_lector, p_libro)`  
  Updates the real return date for a book rental.

- `libros_prestados()`  
  Returns the total number of books currently rented out.

- `log_devolucion()`  
  Trigger function that logs every book return.

### ✔️ Trigger
- `trg_log_devolucion`  
  Executes **AFTER UPDATE** on `alquileres`, detecting when a real return date is entered and creating a log entry automatically.

---

# 🛠️ How to Restore the Database

## Option 1 — Using pgAdmin
1. Create a new database named **biblioteca**  
2. Right-click → **Restore**  
3. Select the file `biblioteca_completa.sql`  
4. Restore

## Option 2 — Using terminal
```bash
psql -U postgres -d biblioteca -f biblioteca_completa.sql
