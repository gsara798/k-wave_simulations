function cfg = compactConfig()
%COMPACTCONFIG Small circular-inclusion case for automated validation.
%
% Material contrasts, frequency, grid spacing, PPW, source physics, and
% diagnostic thresholds match the full 96-by-96 circular-inclusion benchmark reference. The
% circle radius is reduced to 3 mm so it remains fully inside the compact
% sensor ROI.

cfg = kwsim.diagnostics.compactValidationConfig();
cfg.stage = 2;
cfg.scenario = "compact_circular_inclusion";
center_x_m = 0.5 * (cfg.grid.Nx - 1) * cfg.grid.dx_m;
center_z_m = 0.5 * (cfg.grid.Nz - 1) * cfg.grid.dz_m;
cfg.geometry.objects = kwsim.two_d.makeCircleObject( ...
    [center_x_m, center_z_m], 3e-3, 2, 3.0, 1020, ...
    "compact_central_inclusion");

end
