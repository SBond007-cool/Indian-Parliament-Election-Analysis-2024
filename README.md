# 🗳️ Indian Parliament Election Analysis 2024 – SQL Project

This project is a hands-on **SQL-based data analysis** of the **2024 Indian Parliament (Lok Sabha) Election**, 
demonstrating end-to-end skills from data import to insight generation. It uses publicly available CSV data,
transformed and queried using **Microsoft SQL Server (MSSQL)**.

---

## 📦 Project Overview

This project simulates a real-world data analytics task:
- Importing and cleaning election-related CSV files
- Structuring normalized SQL tables
- Writing analytical queries using **Joins**, **CTEs**, **Aggregates**, and **Subqueries**
- Extracting state-wise, party-wise, and candidate-level insights

---

## 🧰 Tools & Technologies

- 🛠 **SQL Server Management Studio (SSMS)**
- 📂 CSV file ingestion
- 🧹 Data cleaning and transformation in SQL

---

## 🧠 Skills Covered

- SQL Joins (INNER JOIN, LEFT JOIN)
- Aggregations: `SUM()`, `COUNT()`, `AVG()`
- Common Table Expressions (CTEs)
- Subqueries & Window Functions
- GROUP BY, ORDER BY
- Date/time filters & Data formatting
- Relational schema design

---

## 🗃️ Data Overview

The project uses **5 CSV files**:
- Constituency-wise candidate results
- Party-wise performance
- State-wise results
- Voter and EVM data
- General state metadata

These were imported into SQL Server and normalized using `CREATE TABLE` and `BULK INSERT`.

---

## 🔍 Sample Insights

- 🪪 **Total Parliament Seats**: `543`
- 🟠 **NDA Alliance Wins**: `292`
- 🔵 **I.N.D.I.A Alliance Wins**: `234`

### 🗺️ State-Wise Party Results
> Example: **Andhra Pradesh**  
> TDP: `16`, YSRCP: `4`  
> BJP: `4`, Janseva Party: `2`

### 🏆 Top EVM Vote-Winning Candidates
1. **Rakibul Hussian** – Dhubri, Assam: `1,468,549` votes  
2. **Shankar Lalwani** – Indore, MP: `1,223,746` votes

### 📈 States with Most Contesting Candidates
1. **Maharashtra** – `1,169` candidates  
2. **Tamil Nadu** – `989` candidates

---

## 📐 Project Structure
