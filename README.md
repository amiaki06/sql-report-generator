# UserForm SQL Report Generator

A powerful SQL query designed to extract, transform, and format data from a multi-table UserForm system into a clean, report-ready output.

![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

---

## 📚 Table of Contents
- [Project Goals](#-project-goals)
- [Database Schema](#-database-schema-overview)
- [Key Features](#-key-query-features)
- [Performance Notes](#-performance-notes)
- [Usage](#-usage)
- [Project Structure](#-project-structure)
- [Author](#-author)
- [License](#-license)

---

## 📌 Project Goals

- Join multiple related tables by their numeric IDs
- Resolve form relationships (e.g. contracts, customers, logistics)
- Translate boolean flags and format dates for readability
- Perform on-the-fly calculations (aggregates, totals)
- Output one row per `LOT` with combined info

---

## 🗄️ Database Schema Overview

The UserForm system stores data across multiple linked tables. The query:

- Traverses ID relationships to fetch associated records
- Joins lookup tables to retrieve readable labels
- Aggregates multi-value fields (e.g. products, LOTs) into single columns

For more details, see 📄 [docs/explanation.md](./docs/explanation.md)

---

## 🔍 Key Query Features

- **Date Formatting:** `GETDATE()` + `CONVERT` → `YYYY/MM/DD`
- **Boolean Translation:**  
  ```sql
  CASE WHEN [field] IN ('1','True') THEN 'true' ELSE 'false' END
  ```
- **Conditional Logic:** Show fields only if relevant flags are `true`
- **Aggregation:**
  - `STRING_AGG` for multi-row values like LOTs or products
  - `SUM(...) OVER ()` for totals without using `GROUP BY`
- **Type Coercion:** `TRY_CAST` handles inconsistent input types

---

## ⚠️ Performance Notes

- **LEFT JOINs:** May slow down queries on large datasets; ensure indexes exist.
- **COALESCE/NULLIF in JOINs:** May prevent index use; optimize if needed.
- **TRY_CAST to NULL:** Invalid conversions return `NULL` silently—consider data validation.
- **STRING_SPLIT issues:** Watch for empty/null inputs when splitting strings.

---

## 🚀 Usage

1. Clone this repository:
   ```bash
   git clone https://github.com/amiaki06/sql-report-generator.git
   ```
2. Open the query file in SQL Server Management Studio:
   📄 [queries/userform_report.sql](./queries/userform_report.sql)

3. Open the database structure script:
   📄 [database/report_lot_info_database.sql](./database/report_lot_info_database.sql)

4. Set the `@LotNumber` parameter (or use a `WHERE` clause) to filter the target LOT.
5. Run the script and export the result (e.g. CSV, Excel).

---

## 📁 Project Structure

```
sql-report-generator/
├── queries/
│   └── userform_report.sql
├── database/
│   └── report_lot_info_database.sql
├── docs/
│   └── explanation.md
├── LICENSE.txt
└── README.md
```

---

## 👤 Author

**Amirhossein Aghakasiri**  
📧 kasiriami06@gmail.com  
🌐 [GitHub: amiaki06](https://github.com/amiaki06)  
🔗 [LinkedIn](https://www.linkedin.com/in/amirhossein-aghakasiri)

---

## 📄 License

This project is licensed under the [MIT License](./LICENSE.txt).
