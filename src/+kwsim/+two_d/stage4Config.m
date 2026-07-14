function cfg = stage4Config()
%STAGE4CONFIG Reference homogeneous power-law attenuation configuration.
%
% cfg = kwsim.two_d.stage4Config()
%
% This configuration validates shear attenuation with the stable left-side
% single contact. A lossless counterpart with identical source, grid, and
% seed is created automatically by runFrequencySweep. The default material
% shear target is 1 dB/cm at 500 Hz with exponent 1.2. The compression law
% uses 0.1 dB/cm at 500 Hz to damp weak P-wave contamination without the
% excessive volumetric stiffness of a 1 dB/cm P law. Only the shear law is
% recovered by this benchmark.

cfg = kwsim.two_d.defaultConfig();
cfg.stage = 4;
cfg.scenario = "stage4_homogeneous_power_law";
% Eight recorded cycles at the viscous time step would make the 96-by-96
% Stage 1 sensor exceed the 2 GiB preflight limit. This dedicated homogeneous
% benchmark retains a 32-by-24 mm propagation region and stays below that
% limit at the lowest validated frequency.
cfg.grid.Nx = 64;
cfg.grid.Nz = 48;
cfg.source.layout = "single_contact";
cfg.source.regime = "single";
cfg.source.contact_model = "point";
cfg.source.contact_sampling = "point";
% The explicit Kelvin-Voigt update has a stricter viscous stability limit
% than the lossless wave CFL. The reference value follows the stable
% pstdElastic2D absorption regime and is enforced during preflight.
cfg.grid.cfl = 0.025;
cfg.attenuation.enabled = true;
cfg.attenuation.materials = kwsim.two_d.makeAttenuationMaterial(1, ...
    ShearAlphaRefDbCm=1.0, ShearReferenceFrequencyHz=500, ...
    ShearPowerY=1.2, CompressionAlphaRefDbCm=0.1, ...
    CompressionReferenceFrequencyHz=500, CompressionPowerY=1.2);

end
