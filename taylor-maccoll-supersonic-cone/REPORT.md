# Supersonic Flow over a Cone using Taylor-Maccoll Equation

## Author
**[Your Name]**

## Objective
This MATLAB project solves the compressible, axisymmetric, inviscid flow over a cone using the Taylor-Maccoll equation. It models the supersonic flow field behind an oblique shock and calculates surface properties such as cone angle, Mach number, and pressure coefficient. The solution includes a grid convergence study and exports detailed flow data to a CSV file for further visualization.

---

## Project Files

- **`taylor_maccoll_analysis.m`**: Main driver script that:
  - Performs RK4 integration of the Taylor-Maccoll ODEs
  - Computes flow field properties for different angular step sizes (Δψ)
  - Outputs cone surface values (δc, Mc, Cp)
  - Exports data to `flow_data_dpsi_0_2.csv`

- **`flow_data_dpsi_0_2.csv`**: Exported data from the Δψ = 0.2° simulation. Includes:
  - Angular position
  - Velocity components (Vr, Vψ)
  - Mach number, pressure ratio, temperature ratio, and density ratio

- **`visualize_flow_csv.m`**: Visualization script that:
  - Reads the CSV file
  - Generates a 2x2 grid of plots to illustrate the variation of flow variables
  - Exports the plots to `flow_distribution_plots.png`

---

## Output Summary

### 1. Grid Convergence Analysis

**Mach Number and Static Pressure Ratio vs ψ**

<img src="machnumber-plot.png" width="500">  
<img src="staticpressure-plot.png" width="500">

- These plots confirm numerical stability across different grid resolutions.
- Flow transitions smoothly from the shock to the cone surface.

### 2. Full Flow Field Visualization from CSV

**Flow Distributions (Δψ = 0.2°)**

<img src="flow_distribution_plots.png" width="600">

- Top Left: \( V_r \) vs \( \psi \)  
- Top Right: \( V_\psi \) vs \( \psi \)  
- Bottom Left: Mach Number  
- Bottom Right: Pressure, Temperature, and Density Ratios

These plots clearly visualize how flow variables evolve through the shock layer. The smooth trends validate the model accuracy.

---

## Key Observations

- Cone semi-angle \( \delta_c \), surface Mach number \( M_c \), and pressure coefficient \( C_p \) are consistent with NACA 1135 charts.
- Minor differences stem from numerical approximations and interpolation effects.
- The CSV output provides a rich dataset that enhances analysis through post-processing.

---

## How to Run

1. Run `taylor_maccoll_analysis.m` in MATLAB to compute results and generate plots.
2. Open `visualize_flow_csv.m` to load and visualize the CSV data.
3. Plots and results will be saved as `.png` and `.csv` in your working directory.

---

## License
[MIT License](LICENSE)
