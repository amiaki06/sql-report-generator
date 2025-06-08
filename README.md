# UserForm SQL Report Generator

A complex SQL query designed to extract, transform, and format data from a multi-table UserForm system into a clean, report-ready format.

---

## 📌 Project Goals

- Join multiple related tables by their numeric IDs  
- Resolve intermediate form IDs to full details (contracts, customers, logistics, etc.)  
- Translate boolean flags and format dates for readability  
- Perform on-the-fly calculations (sums, aggregates)  
- Produce a single row report per LOT number  

---

## 🗄️ Database Schema Overview

The application stores form data across many tables, linking them by numeric IDs. In the main form only the IDs of related “sub-forms” are saved. To build a comprehensive report, this query:

1. **Follows** those ID relationships back into each referenced table  
2. **Joins** with look-up tables to retrieve human-readable labels  
3. **Aggregates** multi-value fields (e.g. multiple LOT numbers, product details) into single columns  

---

## 🔍 Key Features of the Query

- **Date formatting**: `GETDATE()` and `CONVERT` → `YYYY/MM/DD`  
- **Boolean translation**: `CASE WHEN … IN ('1','True') THEN 'true' ELSE 'false' END`  
- **Conditional fields**: Only show formatted date if the corresponding flag is true  
- **Aggregations**:  
  - `STRING_AGG` to combine related rows (e.g. LOTNumbers, ProductDetails)  
  - `SUM(... ) OVER ()` to compute totals without `GROUP BY`  
- **Type coercion**: `TRY_CAST` to handle inconsistent source types  

---

## ⚠️ Performance & Maintenance Notes

- **Many `LEFT JOIN`s** may slow queries on large tables—ensure key columns are indexed.  
- **`COALESCE(NULLIF(...))` in JOINs** can prevent index usage; consider restructuring if performance suffers.  
- **`TRY_CAST` nulls**: invalid casts become `NULL`; add data-quality checks if needed.  
- **`STRING_SPLIT` pitfalls**: splitting on empty or `NULL` strings may produce unexpected results.  

---

## 🚀 Usage

1. Clone this repository  
   ```bash
   git clone https://github.com/amiaki06/sql-report-generator.git
   
2. Open queries/userform_report.sql in SQL Server Management Studio (or your preferred client).

3. Set the @LotNumber parameter (or add a WHERE clause) to target a specific LOT.

4. Execute and export the result (CSV, Excel, etc.) for reporting.

