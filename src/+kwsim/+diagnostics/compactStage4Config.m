function cfg = compactStage4Config()
%COMPACTSTAGE4CONFIG Fast attenuation configuration for integration tests.
%
% The 64-by-48 domain retains 0.5 mm spacing and a long lateral fitting
% interval while reducing the axial sensor count. It is a regression test,
% not the final 96-by-96 Stage 4 acceptance benchmark.

cfg = kwsim.two_d.stage4Config();
cfg.grid.Nx = 64;
cfg.grid.Nz = 48;
cfg.solver.pml_size_points = 8;
cfg.sensor.source_buffer_m = 2e-3;
cfg.sensor.boundary_margin_m = 2e-3;
cfg.time.settling_cycles = 1;
cfg.output.directory = "";

end
