## General Input Parameters
magnet_Q_max = 350000 # INPUT HEAT FLUX [W/m^3]
magnet_num_coils = 18 # NUMBER OF COILS

## Parameters - Shape and TF Coils
magnet_Sy = 1050e6 # Maximum Allowable Stress TF
magnet_l0=0.722      # Length factor
magnet_straight_factor=0.75        # Fraction of straight magnet

magnet_hts_fraction = 0.15 # Estimated HTS fraction in PF & CS

## Solenoid input parameters
magnet_Jmax = (75) * 1e6 # INPUT MAXIMUM ALLOWABLE CURRENT DENSITY PF
magnet_Jsol = 75e6 # LOWER LIMIT SET BY B_1 - for 12.9 limit is 51
magnet_Sysol = 660e6  # INPUT MAXIMUM ALLOWABLE STRESS
magnet_B_1 = 12.9   # INPUTE SOLENOID FIELD

Price_HTS = 36 # Estimated cost of HTS per meter
Price_St = 9.6 # Estimated cost of steel per kg
Price_Cu = 8.3 # Estimated cost of copper per kg

Tape_w = 0.012 # tape width [m]
Tape_t = 0.0000446 # tape thickness [m]
FOS = 0.6 # Stability margin

magnet_PF_coil_length=0.3

WP_AR = 2 # Winding pack aspect ratio

magnet_max_neutron_fluence = 1e23 * 1u"m^-2"

magnet_standard_cold_mass = 10135

St_Rho = 8000 # Density of steel

Cu_Rho = 8950 # Density of copper

magnet_Tcs = 60 # lowest current sharing temperature

magnet_Cp_H2 = 10000 # Average specific heat of supercritical hydrogen @ 30bar from 20-55K
magnet_dT_H2 = 10 # Allowable temperature rise in the fluid
magnet_friction_factor=0.015 # Cooling channel friction factor
magnet_dP_max = 0.01e6 # Allowable pressure drop in the cable
