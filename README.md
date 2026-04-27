🚗 Car Service Database
🏢 Enterprise Database System

A scalable and well-structured relational database system designed to support enterprise-level car service management operations.
The system ensures high data integrity, normalization, and efficient handling of customers, vehicles, services, and financial transactions.

📌 Executive Summary

This project models a real-world car service management platform used in workshops and service centers.
It is designed following relational database best practices to ensure:

Data consistency
Scalability
Maintainability
Extensibility for future system integrations
🧩 System Architecture

The database is built using a fully relational structure, supporting core operational workflows:

Customer lifecycle management
Vehicle ownership tracking
Service appointment scheduling
Service execution tracking
Payment processing and history
🗺️ Entity Relationship Diagram (ERD)

This diagram represents the complete relational structure of the system.


✨ Core Features
👤 Customer relationship management (CRM)
🚘 Multi-vehicle support per customer
📅 Appointment scheduling and tracking
🔧 Service catalog with pricing structure
🧾 Order processing and service execution tracking
💳 Payment management and transaction history
📊 Fully normalized relational schema
🗂️ Database Schema

Main entities:

Customers
Cars
Appointments
Services
Service Orders
Payments
Order Services (junction table)
🛠️ Technology Stack
MySQL 8+
SQL (DDL, DML, Constraints)
Relational Database Design Principles
ER Modeling
🎯 Business Purpose

This system is designed to simulate a production-ready backend database for:

Automotive service centers
Workshop management systems
ERP-like service modules

It can be integrated into backend applications (Node.js, Laravel, Spring Boot, or Flutter apps).

🚀 Future Enhancements
Stored Procedures for automation workflows
Role-based access control (RBAC)
Reporting & analytics dashboard
REST API integration

## 📊 Dashboard Queries

This project provides **10 business intelligence SQL queries** designed to simulate a real-world analytics dashboard for a car service management system.

These queries cover:

- Key Performance Indicators (KPIs)
- Revenue analysis
- Operational performance metrics
- Customer behavior insights
- Branch-level analytics
- Service demand tracking
- Payment method distribution
- Vehicle service frequency analysis

## 📊 Views

- v_customer_cars → Shows customers with their cars (JOINed data)

## 🗺️ ERD Diagram

![ERD Diagram](docs/ERD.png)
Mobile application support
Audit logging system

🏁 Status
✔ Stable database schema
✔ Normalized design (3NF)
✔ Ready for backend integration
