# SQL Data Validation for VentureInsight Analytics

Data quality validation project for VentureInsight, a venture capital analytics platform. This repository contains SQL queries designed to verify data integrity following a database upgrade, ensuring accurate insights for investment decisions.

## 📹 Video Walkthrough

[![Watch the Demo](https://img.shields.io/badge/Watch%20Demo-Loom-625DF5?style=for-the-badge&logo=loom)](https://www.loom.com/share/521041dc268645ebb8d9b58542046631)

[▶ Watch the full project walkthrough on Loom](https://www.loom.com/share/521041dc268645ebb8d9b58542046631)

## 🖥️ Interactive Demo

Click the links below to open live in your browser — no setup or installation required:

| Demo | Link | Description |
|------|------|-------------|
| Project Intro | [▶ Open Cover Page](https://dgsalsbury1-hub.github.io/SQL-Data-Validation-Project/ventureinsight-cover.html) | Animated project intro page |
| SQL Explorer | [▶ Open SQL Explorer](https://dgsalsbury1-hub.github.io/SQL-Data-Validation-Project/ventureinsight-db.html) | Live SQL explorer — run all 9 queries in your browser |
| Project Summary | [▶ Open Conclusion](https://dgsalsbury1-hub.github.io/SQL-Data-Validation-Project/ventureinsight-conclusion-final.html) | Project summary and contact links |

## Overview

As part of VentureInsight's quality assurance process, this project validates that data from the web application correctly populates the backend database. SQL queries extract and verify critical business datasets including company funding, acquisition trends, investor activity, and geographic investment patterns.

## Key Features

- Data validation queries for startup funding analysis
- Geographic and sector-based investment trend verification
- Fund activity classification and analysis
- Acquisition timeline validation
- Influencer identification queries for marketing outreach

## Database Schema

| Table | Records | Description |
|-------|---------|-------------|
| `company` | 60 | Core company data across multiple sectors |
| `acquisition` | 30 | Merger and acquisition records |
| `funding_round` | 80 | Investment round history |
| `fund` | 25 | Venture firm data |
| `people` | 35 | Founders, investors, and influencers |

## Validation Queries

| Query | Business Purpose | SQL Concepts |
|-------|-----------------|--------------|
| Q1 | Verify closed startup status | SELECT, WHERE |
| Q2 | Validate USA news sector funding | SELECT, WHERE, AND |
| Q3 | Cash acquisition totals 2011–2013 | WHERE, LIKE, strftime |
| Q4 | Silver Twitter influencer identification | LIKE with wildcard |
| Q5 | Finance Twitter influencer identification | LIKE with wildcard |
| Q6 | Geographic funding aggregation by country | GROUP BY, SUM, ORDER BY |
| Q7 | Daily funding volatility check | GROUP BY, HAVING, MIN, MAX |
| Q8 | Fund activity classification | CASE WHEN, GROUP BY |
| Q9 | Average investment rounds by activity tier | CASE WHEN, AVG, GROUP BY |

## Technologies

- **PostgreSQL** — production database environment
- **SQLite** — browser-based interactive demo
- **SQL** — data validation and analysis
- **HTML/JavaScript** — interactive demo interface
- **GitLab & GitHub** — version control

## Development Notes

This project was developed with AI-assisted learning. SQL queries were written with guidance from Claude AI for syntax understanding, optimization, and best practices. All queries were tested and validated independently.
