# MBIST Controller: March Y Algorithm (RTL to GDSII)

![Status](https://img.shields.io/badge/Status-Routed-success)
![Technology](https://img.shields.io/badge/Tech-ASIC%2090nm-blue)
![Area](https://img.shields.io/badge/Area-1127.78%20um%C2%B2-green)
![Density](https://img.shields.io/badge/Core%20Density-69.9%25-orange)

> **A complete RTL-to-GDSII implementation of a Memory Built-In Self-Test (MBIST) controller. This project implements the March Y algorithm to test a 16x8 SRAM array, featuring a verified ASIC flow using Cadence Genus and Innovus.**

---

## 📖 Table of Contents
- [Overview](#-overview)
- [Repository Structure](#-repository-structure)
- [Design Flow](#-design-flow)
- [Physical Implementation Stats](#-physical-implementation-stats)
- [Visuals: Layout & Reports](#-visuals-layout--reports)
- [Future Scope](#-future-scope)

---

## 🔍 Overview
This project targets the testing of embedded memories using a dedicated hardware controller. The **March Y algorithm** was chosen for its ability to detect Stuck-at, Transition, and Coupling faults. The design is implemented for a **16-word x 8-bit (16:8) SRAM** and has passed Logic Synthesis, Placement, Routing, and Design Rule Checks (DRC).

---

## 📂 Repository Structure
The project is organized as follows:

| Folder | Description |
| :--- | :--- |
| **`Verilog/`** | RTL source code (`controller1.v`) and Testbench files. |
| **`Scripts/`** | TCL scripts for Synthesis (Genus) and PnR (Innovus). |
| **`Reports/`** | Generated reports for Area, Power, Timing, and DRC. |
| **`Timing/`** | Static Timing Analysis (STA) results and SDC constraints. |
| **`Images/`** | Screenshots of Layouts, Waveforms, and Physical Reports. |
| **`Results/`** | Final output files (Netlists, GDSII). |

---

## ⚙️ Design Flow
The project follows a standard ASIC flow using **Cadence** tools:

1.  **RTL Design:** Verilog HDL.
2.  **Logic Synthesis:** Cadence Genus (Mapped to standard cells).
3.  **Physical Design:** Cadence Innovus.
    * **Floorplanning:** Utilization set to ~70%.
    * **Power Planning:** Power ring and stripe creation.
    * **Placement:** Standard cell placement.
    * **CTS:** Clock Tree Synthesis.
    * **Routing:** 9-layer metal stack routing.
4.  **Sign-off:**
    * **DRC:** Verified Clean (PVS).

---

## 📊 Physical Implementation Stats
*Data extracted from Innovus Design Summary (`controller1.main.htm`).*

| Metric | Value |
| :--- | :--- |
| **Total Standard Cells** | 305 |
| **Physical Core Density** | 69.95% |
| **Total Wire Length** | 2174.84 µm |
| **Routing Layers Used** | 9 Layers |
| **Pins** | 523 |
| **Net Count** | 165 |

---

## 📸 Visuals: Layout & Reports

### 1. Final Layout (Innovus)
![Final Layout](Images/Final_layout.png)
*Snapshot of the fully routed controller block.*

### 2. Standard Cell Placement
![Standard Cell](Images/Standard_cell.png)
*Zoomed-in view of the standard cell placement.*

### 3. Floorplan View
![Floorplan](Images/Floorplan.png)
*Initial floorplanning showing core boundaries and IO ports.*

### 4. DRC Report (Clean)
![DRC Report](Images/DRC_report.png)
*PVS Report showing 0 Design Rule Violations.*

---

## 🚀 Future Scope
* Integration with larger SoC designs as a BIST wrapper.
* Optimization for lower power consumption in the controller logic.
* Resolving LVS extraction warnings for final sign-off.

---

### 👤 Author
**Ajay H R** **Sanjeev Padmanabha**
* [LinkedIn](https://linkedin.com/in/ajayhr19082003) | [GitHub](https://github.com/Ajaya325986)
