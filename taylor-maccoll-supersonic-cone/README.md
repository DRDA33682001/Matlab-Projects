# Taylor-Maccoll Supersonic Cone Flow Simulation

This MATLAB project solves the Taylor-Maccoll equation to model compressible supersonic flow over a sharp cone. It includes a numerical solver, CSV export, and post-processing visualizations — suitable for academic research or CFD educational purposes.

---

## 🎯 Objective

- Numerically solve the Taylor-Maccoll ODEs using 4th-order Runge-Kutta (RK4) integration.
- Compute flow properties (Mach, pressure, temperature, density) behind a conical shock.
- Perform a grid convergence study using different angular step sizes.
- Export flow field data to a CSV file.
- Generate insightful plots from both computed data and CSV.

---

## 📁 Project Structure

TaylorMaccoll/ ├── code/ │ ├── taylor_maccoll_analysis.m # Main solver with RK4 integration │ └── plot_taylor_maccoll_results.m # Plots flow properties from CSV ├── data/ │ └── flow_data_dpsi_0_2.csv # Exported flow variable data ├── plots/ │ ├── assignment5plot.png # Mach number vs ψ │ ├── assignment5plot2.png # Pressure ratio vs ψ │ └── flow_distribution_plots.png # Multiple flow quantities vs ψ ├── report/ │ ├── report.tex # LaTeX source of final report │ └── report.pdf # Compiled version of the report └── README.md # Project summary and guide


---

## 📊 Sample Output

<p align="center">
  <img src="plots/flow_distribution_plots.png" width="75%">
</p>

This combined figure shows how key flow variables vary with angle \(\psi\), based on the exported data from `flow_data_dpsi_0_2.csv`.

---

## ⚙️ How to Run

1. Open `taylor_maccoll_analysis.m` in MATLAB.
2. Run the script to perform the simulation and export CSV results.
3. Open `visualize_flow_csv.m` to generate the post-processing visualizations.

---

## 📄 Report

For full background, equations, numerical method, and analysis:

---

## 👤 Author

**Dron Das Purkayastha**  
📧 Email: drda3368@colorado.edu  


