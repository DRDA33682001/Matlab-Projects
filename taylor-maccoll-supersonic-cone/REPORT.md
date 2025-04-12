# 📘 Report: Supersonic Flow Over a Cone Using the Taylor-Maccoll Equation

**Author:** Dron Das Purkayastha  
**Project Type:** MATLAB-based Simulation and Visualization  
**Domain:** Gas Dynamics / Compressible Flow  

---

## 🧠 Objective

This project implements a numerical solution for **supersonic inviscid compressible flow over a sharp cone** using the **Taylor-Maccoll equation**. The goal is to compute the flow field between a conical shock and the cone surface for a given freestream Mach number and shock angle. It aims to extract key flow quantities such as Mach number, pressure coefficient, cone angle, and thermodynamic state ratios. The output is validated through visual plots and convergence checks.

---

## 🧮 Mathematical Background

### 📏 Oblique Shock Relations

Given:
- \( M_1 \): Freestream Mach number
- \( \theta_s \): Shock wave angle

The **normal Mach number** before the shock is:

\[
M_{n1} = M_1 \sin(\theta_s)
\]

The **normal Mach number after the shock** is:

\[
M_{n2}^2 = \frac{1 + \frac{\gamma - 1}{2} M_{n1}^2}{\gamma M_{n1}^2 - \frac{\gamma - 1}{2}}
\]

The **Mach number after the shock**:

\[
M_2 = \frac{M_{n2}}{\sin(\theta_s)}
\]

The **pressure and stagnation pressure ratios**:

\[
\frac{p_2}{p_1} = 1 + \frac{2 \gamma}{\gamma + 1} (M_{n1}^2 - 1)
\]

\[
\frac{p_{02}}{p_{01}} = \left( \frac{1 + \frac{\gamma - 1}{2} M_1^2}{1 + \frac{\gamma - 1}{2} M_2^2} \right)^{\frac{\gamma}{\gamma - 1}} \left( \frac{p_2}{p_1} \right)^{-1}
\]

---

### 📘 Taylor-Maccoll Equation

Describes axisymmetric supersonic flow over a cone. The governing ODEs in terms of radial and angular velocity components:

\[
\frac{dV_r}{d\psi} = V_\psi
\]

\[
\frac{dV_\psi}{d\psi} = -\left( \frac{V_r^2 - V_\psi^2}{V_r} + \frac{\gamma - 1}{2}(V_r^2 + V_\psi^2 - 1)\frac{V_\psi}{V_r} \right)
\]

Where:
- \( V_r \): Radial velocity component
- \( V_\psi \): Angular velocity component
- \( \psi \): Angle from axis (shock to cone surface)

---

## 💻 Code Overview

### 1. `taylor_maccoll_analysis.m`
- Computes shock properties
- Integrates Taylor-Maccoll ODEs via 4th-order Runge-Kutta
- Exports CSV for ∆ψ = 0.2° case
- Performs convergence study over ∆ψ = 0.1°, 0.2°, 0.4°
- Outputs plots of Mach number and pressure ratio

### 2. `flow_data_dpsi_0_2.csv`
- Angularly distributed flow field data
- Columns: \( \psi \), \( V_r \), \( V_\psi \), \( M \), \( \frac{p}{p_1} \), \( \frac{T}{T_1} \), \( \frac{\rho}{\rho_1} \)

### 3. `visualize_flow_csv.m`
- Reads the CSV data
- Generates a 2×2 grid of plots:
  - \( V_r \), \( V_\psi \), Mach number
  - Pressure, temperature, density ratios

---

## 📊 Visual Results

### Mach Number Distribution
<img src="machnumber-plot.png" width="600">

- Demonstrates deceleration of flow as it approaches the cone.
- Smooth trend confirms numerical stability.

---

### Static Pressure Ratio Distribution
<img src="staticpressure-plot.png" width="600">

- Pressure increases due to compression behind the shock.
- Useful to extract surface values.

---

### Full Variable Flow Field (CSV Output)
<img src="flow_distribution_plots.png" width="600">

- Shows full behavior of flow variables across the domain.
- Confirms physical accuracy of model.

---

## 🧠 Analysis and Observations

- The **cone surface Mach number** and **pressure coefficient** align with theoretical expectations.
- **Grid convergence** confirms robustness of the numerical integration.
- Output data is suitable for post-processing, visualization, and engineering analysis.

---

## ✅ How to Run the Project

1. Open `taylor_maccoll_analysis.m` in MATLAB and run.
2. It will generate:
   - Console outputs
   - `flow_data_dpsi_0_2.csv`
   - Convergence plots
3. Run `visualize_flow_csv.m` to view flow variable plots from the CSV.

---


---

## 📌 Conclusion

This project effectively implements a Taylor-Maccoll flow solver in MATLAB. It provides insights into axisymmetric supersonic cone flow and generates accurate outputs useful for validation, visualization, and further academic study. The exported CSV and clean plots make the results reproducible and explainable.

---

## 👤 Author Info

**Dron Das Purkayastha**  
_This project was developed as part of gas dynamics coursework and serves as a demonstration of numerical simulation and visualization using MATLAB._



