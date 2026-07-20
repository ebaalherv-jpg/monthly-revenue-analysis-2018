# 📊 2018 E-Commerce Monthly Revenue Analysis (SQLite)

## 📝 Project Overview
This project analyzes e-commerce order data from 2018 to evaluate monthly category performance, clean inconsistent raw data, and classify high-performing sales channels using SQL in **SQLite**.

## 🔍 Business Problem & Data Challenges
The finance team required a monthly breakdown of category performance to identify top-tier product lines. The raw dataset presented several data quality challenges:
- Inconsistent category naming conventions (mixed casing).
- Missing values (`NULL`) in shipping costs (`freight_value`).
- Timestamps requiring date extraction for monthly aggregation.

## 🛠️ Key SQL Concepts Applied
- **Multi-Table Joins:** Integrated `orders`, `order_items`, and `products` tables.
- **Data Cleaning & NULL Handling:** Used `COALESCE()` to ensure accurate arithmetic without `NULL` propagation.
- **Date Transformation (SQLite):** Leveraged `STRFTIME()` combined with `CAST()` to extract numerical month and year fields.
- **Conditional Logic:** Evaluated tier status with `CASE WHEN` (`Top Performer` vs `Standard`).
- **Group Aggregation & Filtering:** Grouped metrics by month/category and filtered grouped aggregates using `HAVING`.

## 🚀 Output Structure
| Field | Type | Description |
|---|---|---|
| `total_revenue` | Numeric | Net revenue (`price - freight_value`) |
| `category` | Text | Standardized uppercase category name |
| `sales_month` | Integer | Month of delivery (1-12) |
| `sales_classification` | Text | Performance tier (`Top Performer` / `Standard`) |
