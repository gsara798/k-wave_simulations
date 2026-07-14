function [medium, truth] = buildMedium(cfg)
%BUILDMEDIUM Build material and optional Kelvin-Voigt maps for pstdElastic2D.
%
% Outputs use k-Wave's internal [Nx,Nz] orientation. Public result maps are
% transposed to [Nz,Nx] by the run adapter. When attenuation is disabled,
% no alpha fields are added and pstdElastic2D uses its lossless equations.

arguments
    cfg struct
end

[geometry_maps, geometry_metadata] = kwsim.two_d.buildGeometry(cfg);
grid_size = [cfg.grid.Nx, cfg.grid.Nz];
medium = struct();
medium.sound_speed_compression = cfg.medium.cp_m_s * ones(grid_size);
medium.sound_speed_shear = geometry_maps.cs_m_s_xz;
medium.density = geometry_maps.rho_kg_m3_xz;
[attenuation_maps, attenuation_metadata] = ...
    kwsim.two_d.resolveAttenuation(cfg, geometry_maps);
if attenuation_metadata.enabled
    medium.alpha_coeff_shear = attenuation_maps.shear_kv_db_mhz2_cm_xz;
    medium.alpha_coeff_compression = ...
        attenuation_maps.compression_kv_db_mhz2_cm_xz;
end

truth = struct();
truth.cp_m_s_xz = medium.sound_speed_compression;
truth.cs_m_s_xz = medium.sound_speed_shear;
truth.rho_kg_m3_xz = medium.density;
truth.material_id_xz = geometry_maps.material_id_xz;
truth.attenuation_db_cm_xz = ...
    attenuation_maps.shear_alpha_at_f0_db_cm_xz;
truth.attenuation = attenuation_metadata;
truth.attenuation.shear_alpha_at_f0_db_cm_xz = ...
    attenuation_maps.shear_alpha_at_f0_db_cm_xz;
truth.attenuation.compression_alpha_at_f0_db_cm_xz = ...
    attenuation_maps.compression_alpha_at_f0_db_cm_xz;
truth.attenuation.shear_kv_db_mhz2_cm_xz = ...
    attenuation_maps.shear_kv_db_mhz2_cm_xz;
truth.attenuation.compression_kv_db_mhz2_cm_xz = ...
    attenuation_maps.compression_kv_db_mhz2_cm_xz;
truth.attenuation.eta_pa_s_xz = attenuation_maps.eta_pa_s_xz;
truth.attenuation.chi_pa_s_xz = attenuation_maps.chi_pa_s_xz;
truth.geometry = geometry_metadata;

end
