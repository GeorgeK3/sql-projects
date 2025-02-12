# Data Management Project

This project focuses on **performance optimization and data analysis** using SQL. It includes **indexing strategies, query execution performance testing, and user data analysis**.

---

## 📌 Project Overview

### **1️⃣ Performance Optimization**
- **Uses `CHECKPOINT` and `DBCC DROPCLEANBUFFERS`** to clear memory buffers for accurate query performance testing.
- **Enables `SET STATISTICS IO ON` and `SET STATISTICS TIME ON`** to measure execution time and I/O statistics.
- **Creates and drops indexes dynamically** to compare query execution speeds.

### **2️⃣ Data Analysis Queries**
- **User Profile Views Analysis**:
  - Retrieves users **created in 2010** and sorts by `profileViews` in ascending order.
  - Implements **indexing on `CreationDate`** to speed up queries.
- **User Activity Analysis**:
  - Finds users **who have posted answers but never asked a question** using `EXCEPT` queries.

---
