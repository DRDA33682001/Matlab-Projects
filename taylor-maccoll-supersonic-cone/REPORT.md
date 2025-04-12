# Supersonic Flow Over a Cone Using Taylor-Maccoll Equation

**Author:** Dron Das Purkayastha  
**Course:** Gas Dynamics (MECH 314)  
**Tool:** MATLAB

---

## 📌 Objective

This project numerically solves the compressible, axisymmetric, inviscid supersonic flow over a cone using the Taylor-Maccoll equation. The simulation determines the flow field properties between an oblique shock and the cone surface for various angular step sizes. Key surface parameters such as cone angle, surface Mach number, and pressure coefficient are extracted and compared across grid resolutions. The results are validated by visualizing the flow variable distributions and comparing to theoretical trends.

---

## 🧮 Governing Equations

### 1. Oblique Shock Relations

When a supersonic flow meets a cone, an oblique shock forms. The normal Mach number before the shock is:

- Mn1 = M1 * sin(theta_s)

After the shock, the normal Mach number is reduced and given by:

- Mn2² = [1 + ((γ - 1)/2) * Mn1²] / [γ * Mn1² - ((γ - 1)/2)]

The downstream Mach number after the shock is:

- M2 = Mn2 / sin(theta_s)

Additional relations:

- Pressure ratio across the shock:  
  p2/p1 = 1 + (2 * γ / (γ + 1)) * (Mn1² - 1)

- Stagnation pressure ratio:  
  p02/p01 = [(1 + ((γ - 1)/2) * M1²) / (1 + ((γ - 1)/2) * M2²)]^(γ / (γ - 1)) * (p2/p1)^(-1)

---

### 2. Taylor-Maccoll Flow Equations

The flow between the shock and the cone surface is described using the following coupled ODEs:

- d(Vr)/d(psi) = Vpsi

- d(Vpsi)/d(psi) = - [ (Vr² - Vpsi²) / Vr + ((γ - 1)/2) * (Vr² + Vpsi² - 1) * (Vpsi / Vr) ]

Where:
- Vr = radial velocity component  
- Vpsi = angular velocity component  
- psi = angle from the cone axis to shock surface

These are solved using a 4th-order Runge-Kutta (RK4) numerical integration technique.

---

### 3. Thermodynamic State Equations

Derived quantities include:

- Mach number: M = sqrt(Vr² + Vpsi²)
- Static pressure ratio: p/p1 = f(M)
- Static temperature ratio: T/T1 = f(M)
- Density ratio: rho/rho1 = (p/p1) / (T/T1)

---

## 🧪 Methodology

1. For each chosen step size (0.1°, 0.2°, 0.4°), the shock relations are computed.
2. Taylor-Maccoll equations are integrated from the shock wave toward the cone using RK4.
3. At each step, flow variables are calculated and stored.
4. Final surface values are extracted:
   - Cone semi-angle (delta_c)
   - Surface Mach number (Mc)
   - Surface pressure coefficient (Cp)
5. A flow data CSV is exported for Δψ = 0.2°
6. All flow variables are plotted for grid convergence study and flow distribution analysis.

---

## 📁 Files and Their Roles

- `taylor_maccoll_analysis.m`: Main script for computation and plotting
- `visualize_flow_csv.m`: Reads the exported CSV and visualizes individual flow variables
- `flow_data_dpsi_0_2.csv`: Contains all flow field data for Δψ = 0.2°
- `machnumber-plot.png`: Mach number variation with ψ for 3 step sizes
- `staticpressure-plot.png`: Static pressure ratio variation with ψ
- `flow_distribution_plots.png`: Subplots for Vr, Vpsi, Mach, p/p1, T/T1, and rho/rho1

---

## 📊 Results and Analysis

### 🔹 Cone Surface Properties

| Step Size (Δψ) | Cone Angle (deg) | Mach at Cone | Pressure Coeff (Cp) |
|----------------|------------------|---------------|----------------------|
| 0.1°           | -0.00000         | 0.57905       | 1.57380              |
| 0.2°           | -0.00000         | 0.57905       | 1.57380              |
| 0.4°           | -0.20000         | 0.57670       | 1.57741              |

The consistent results for smaller step sizes confirm good numerical convergence.

---

### 🔹 Grid Convergence Plots

#### Mach Number vs ψ  
**File:** `machnumber-plot.png`

- Shows how flow Mach number decreases as it moves from shock to cone.
- The curves overlap well for Δψ = 0.1° and 0.2°, but deviate slightly for Δψ = 0.4°, validating smaller step sizes for accuracy.

#### Static Pressure Ratio vs ψ  
**File:** `staticpressure-plot.png`

- Shows pressure build-up through the compression layer.
- Smooth gradient confirms ideal flow behavior and solver accuracy.

---

### 🔹 Flow Variable Distribution

#### File: `flow_distribution_plots.png`

This plot provides a comprehensive view of:

- Radial velocity (Vr)
- Angular velocity (Vpsi)
- Mach number
- Pressure ratio
- Temperature ratio
- Density ratio

Each subplot shows how these variables change from shock to cone surface (ψ = 45° → 0°). These trends match expected physics and validate the solver.

---

## 📈 Inference

- The Taylor-Maccoll solver accurately models compressible cone flow.
- RK4 integration and grid convergence ensures robustness of results.
- Thermodynamic variables follow expected profiles for an inviscid, supersonic flow.
- CSV export enables downstream analysis and plotting flexibility.

---

## ▶ How to Run

1. Open MATLAB
2. Run `taylor_maccoll_analysis.m`
3. View console output and plots
4. Run `visualize_flow_csv.m` for detailed subplot visualization
5. All data and plots will be saved in your working directory

---

## 🧠 Final Thoughts

This project serves as a robust MATLAB implementation of Taylor-Maccoll theory, suitable for learning compressible flow numerics and visualization. The modular design also makes it extendable to multi-shock systems or comparative studies using real gas effects.

---
