function cfg = compactConfig(regime)
%COMPACTCONFIG Fast finite-contact configuration for testing.

arguments
    regime (1,1) string {mustBeMember(regime, ...
        ["directional", "partially_diffuse", "diffuse"])} = "directional"
end

cfg = kwsim_benchmarks.field_regimes_2d.compactConfig(regime);
cfg.scenario = "compact_finite_contacts_" + regime;
cfg.source.contact_model = "finite_segment";
cfg.source.contact_sampling = "sparse_patch";
cfg.source.contact_profile = "raised_cosine";
cfg.source.contact_node_spacing_points = 4;
cfg.source.contact_radius_m = 2e-3;

switch regime
    case "directional"
        cfg.source.vibrator_count = 4;
    case "partially_diffuse"
        cfg.source.vibrator_count = 8;
    case "diffuse"
        cfg.source.vibrator_count = 8;
end

end
