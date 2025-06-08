# 📘 Database Schema Explanation

This document explains the structure and relationships in the `FormDesign` database used for generating the LOT-based reports.

## 🧱 Schema: `UserForm`

The `UserForm` schema includes more than 30 tables which represent different sections of a dynamic form system. Each table corresponds to a specific sub-form or reference table in the UI.

### 🔑 Main Tables

- **tbl_UserCreatedForm_28**: Stores the main LOT entries. Contains base details like product, weight, contract numbers.
- **tbl_UserCreatedForm_29**: Stores contract-related details such as payment, incoterms, documents.
- **tbl_SubUserCreatedForm_29**: Holds subcontract data (unit price, number of packages, etc.)

### 📎 Relation Tables

- **tbl_UserCreatedForm_32**: Used to map LOT numbers and product details together for related contracts.
- **tbl_UserCreatedForm_1**, **27**, etc.: Provide lookup info (contract terms, requirement documents).
- **tbl_UserCreatedForm_15**: Product list with grades and packaging mappings.
- **tbl_UserCreatedForm_5**, **6**, **14**, etc.: Lookup tables for incoterms, payment terms, destination ports.

### 🧮 Functions and Helpers

- `dbo.PersianDate(@date)` — A SQL Server user-defined function that converts Gregorian dates to Persian (Jalali) format.

### 🔄 Relationships

All forms are connected by:
- `fldColumn_X`: usually stores foreign keys as numeric or text IDs.
- `fldSubkeyGroupReletionID`: common join field across most tables.
- `fldID`: primary keys (mostly GUIDs).

### ⚙️ Data Challenges

- Many columns have inconsistent types — numeric values stored as text.
- Dates, flags, and foreign keys often need conversion and joining for meaningful reporting.
- Some values are stored as pipe-separated strings (`|`), requiring `STRING_SPLIT` and `JOIN`.

---

## 📑 Usage Recommendation

Ensure:
- All reference tables are populated before executing the report.
- Proper indexing on `fldID`, `fldColumn_X`, and `fldSubkeyGroupReletionID` for performance.

