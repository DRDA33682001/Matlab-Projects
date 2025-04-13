# Droplet Terminal Velocity Simulation and Force Balance Analysis

## 📌 Objective

The objective of this project is to simulate and visualize the motion of a water droplet falling through air under the influence of gravity and drag. The focus is on understanding how drag force and gravity interact dynamically to establish terminal velocity. We analyze the transient motion of the droplet, force evolution over time, and compare results to theoretical models. A parametric study is also conducted to see how terminal velocity varies with droplet size and air density.

---

## 🧪 Physics and Modeling Background

When a droplet is released in a fluid like air, it initially accelerates under gravity. As velocity increases, so does the drag force acting upward. Eventually, the drag force balances the net gravitational force, and the droplet reaches a constant velocity — the terminal velocity.

Key forces involved:
- **Gravitational force (Fg)**: Acts downward due to the droplet's mass.
- **Buoyant force**: Air exerts an upward force due to displacement, reducing the net weight.
- **Drag force (Fd)**: Resists motion and depends on the droplet's velocity and size.

The net force is given by:

    Net force = Fg - Fd

The drag coefficient is not constant but depends on the Reynolds number (Re), which itself depends on velocity:

    Re = (rho_air * velocity * diameter) / viscosity

We use a Reynolds-number-dependent drag model, switching between Stokes drag and Schiller-Naumann correlation. For high Re, we fix Cd = 0.44.

---

## ⚙️ Code Overview

The simulation:
- Uses Euler integration to compute velocity over time.
- Adds buoyancy correction to gravity.
- Tracks forces and velocity at each step.
- Stops when net force converges to zero over time.
- Normalizes the results by characteristic time and velocity scales.

We also include a 3D parametric analysis to study how terminal velocity varies with droplet radius and air density.

---

## 📊 Results and Plot Analysis

### 1. Non-Dimensional Velocity vs Time

![Non-Dimensional Velocity](images/non-dimensional-velocity.png)

This plot shows how the droplet accelerates from rest and approaches a steady velocity. The velocity is normalized by the terminal velocity, and time is scaled by the characteristic time (radius / terminal velocity). The droplet reaches terminal velocity smoothly as the net force drops to zero.

**Insight**: Terminal velocity is achieved within a few non-dimensional time units. This plot confirms the expected asymptotic behavior of velocity in drag-dominated motion.

---

### 2. Gravitational vs Drag Force

![Gravitational vs Drag](images/Gravitational-vs-Drag-Force.png)

This plot shows the gravitational force (constant) and drag force (increases with velocity). Initially, gravity dominates. As velocity increases, drag grows until it equals gravity, indicating terminal velocity.

**Insight**: Force balance is visually clear. This confirms that drag force dynamically responds to the droplet's velocity and establishes terminal motion.

---

### 3. Net Force Driving Acceleration

![Net Force Driving Acceleration](images/Net-Force-Driving-Acceleration.png)

This plot shows the difference between gravity and drag as the net force responsible for acceleration. Initially large, the net force gradually drops to zero.

**Insight**: This visualization confirms that the droplet decelerates in its acceleration due to increasing drag until a steady state is reached.

---

### 4. Net Force Magnitude (Log Scale)

![Net Force Log Scale](images/Net-Force-Magnitude-Log-Scale.png)

This log-scale plot of net force magnitude shows an exponential decay in the force difference.

**Insight**: The decay is exponential, which aligns with theoretical expectations of viscous damping systems. This confirms the convergence toward terminal velocity in a physically realistic way.

---

### 5. Terminal Velocity vs Radius and Air Density

![3D Surface Plot](images/Terminal-Velocity-vs-Radius-and-Air-Density.png)

This 3D surface shows how terminal velocity depends on droplet size and air density. Larger droplets fall faster, while denser air slows them down.

**Insight**: This parametric sweep provides a comprehensive overview. It reveals the expected square-root dependence on radius and inverse dependence on air density.

---

## ✅ Outcome

- We successfully simulated the full transient evolution of a droplet falling in air.
- Terminal velocity was accurately identified using a force convergence criterion.
- Non-dimensional analysis helped generalize the behavior and enabled meaningful comparisons.
- The 3D plot provided insight into environmental and geometric effects on terminal velocity.
- Our simulation matched theoretical expectations, including validation against the Stokes flow formula for small Reynolds numbers.

---

## 🗂️ Files Included

- `droplet_terminal_velocity_nd.m`: MATLAB code implementing the simulation
- `report.md`: This report
- `/images/`: Folder with all plots

---

## 📌 Conclusion

This project combines theoretical modeling, numerical simulation, and visual analysis to explore the fluid dynamics of falling droplets. It reinforces core fluid mechanics concepts like drag, buoyancy, and terminal velocity and demonstrates practical skills in MATLAB programming and scientific visualization.
