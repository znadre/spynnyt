// Runge-Kutta 4th Order Method

float dt;

void omegaRungeKuttaStep() { // One integration step, changing the omega values
  dt = speed/frameRate;
  double[] k1 = omegaComputeDerivatives(omega.x, omega.y, omega.z);

  double[] k2 = omegaComputeDerivatives(
    omega.x + 0.5 * dt * k1[0],
    omega.y + 0.5 * dt * k1[1],
    omega.z + 0.5 * dt * k1[2]
    );

  double[] k3 = omegaComputeDerivatives(
    omega.x + 0.5 * dt * k2[0],
    omega.y + 0.5 * dt * k2[1],
    omega.z + 0.5 * dt * k2[2]
    );

  double[] k4 = omegaComputeDerivatives(
    omega.x + dt * k3[0],
    omega.y + dt * k3[1],
    omega.z + dt * k3[2]
    );

  omega.x += (dt / 6.0) * (k1[0] + 2 * k2[0] + 2 * k3[0] + k4[0]);
  omega.y += (dt / 6.0) * (k1[1] + 2 * k2[1] + 2 * k3[1] + k4[1]);
  omega.z += (dt / 6.0) * (k1[2] + 2 * k2[2] + 2 * k3[2] + k4[2]);
}

void eRungeKuttaStep() { // One integration step, changing e1, e2, and e3
  dt = speed/frameRate;
  Omega = e1.copy().mult(omega.x).add(e2.copy().mult(omega.y).add(e3.copy().mult(omega.z)));

  PVector[] k1 = eComputeDerivatives(e1, e2, e3);

  PVector[] k2 = eComputeDerivatives(
    e1.copy().add(k1[0].copy().mult(0.5 * dt)),
    e2.copy().add(k1[1].copy().mult(0.5 * dt)),
    e3.copy().add(k1[2].copy().mult(0.5 * dt))
  );

  PVector[] k3 = eComputeDerivatives(
    e1.copy().add(k2[0].copy().mult(0.5 * dt)),
    e2.copy().add(k2[1].copy().mult(0.5 * dt)),
    e3.copy().add(k2[2].copy().mult(0.5 * dt))
  );

  PVector[] k4 = eComputeDerivatives(
    e1.copy().add(k3[0].copy().mult(dt)),
    e2.copy().add(k3[1].copy().mult(dt)),
    e3.copy().add(k3[2].copy().mult(dt))
  );

  e1.add((k1[0].add(k2[0].copy().mult(2)).add(k3[0].copy().mult(2)).add(k4[0])).mult(dt / 6.0));
  e2.add((k1[1].add(k2[1].copy().mult(2)).add(k3[1].copy().mult(2)).add(k4[1])).mult(dt / 6.0));
  e3.add((k1[2].add(k2[2].copy().mult(2)).add(k3[2].copy().mult(2)).add(k4[2])).mult(dt / 6.0));

  e1.normalize();
  e2.normalize();
  e3.normalize();
}

// Function to compute derivatives based on Euler equations (of a rotating object)

double[] omegaComputeDerivatives(double omega_x, double omega_y, double omega_z) {
  double d_omega_x = ((MOI.y - MOI.z) / MOI.x) * omega_y * omega_z;
  double d_omega_y = ((MOI.z - MOI.x) / MOI.y) * omega_z * omega_x;
  double d_omega_z = ((MOI.x - MOI.y) / MOI.z) * omega_x * omega_y;
  return new double[]{d_omega_x, d_omega_y, d_omega_z};
}

PVector[] eComputeDerivatives(PVector E1, PVector E2, PVector E3) {
  PVector d_E1 = Omega.copy().cross(E1);
  PVector d_E2 = Omega.copy().cross(E2);
  PVector d_E3 = Omega.copy().cross(E3);
  return new PVector[]{d_E1, d_E2, d_E3};
}
