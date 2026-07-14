function sweep = runFrequencySweep(base_cfg, frequencies_hz, ...
        output_directory, options)
%RUNFREQUENCYSWEEP Run independent attenuated/lossless Stage 4 simulations.
%
% sweep = kwsim.two_d.runFrequencySweep(cfg, frequencies_hz, output_directory)
%
% No field contains more than one frequency. For each f0 this function
% clones the requested configuration, runs a matched lossless reference,
% runs the calibrated Kelvin-Voigt case, evaluates attenuation, and then
% fits the requested power law across the independent results.

arguments
    base_cfg struct = kwsim.two_d.stage4Config()
    frequencies_hz (1,:) double = [300, 400, 500]
    output_directory {mustBeTextScalar} = ""
    options.Overwrite (1,1) logical = false
end

if numel(frequencies_hz) < 3 || any(~isfinite(frequencies_hz)) || ...
        any(frequencies_hz <= 0) || numel(unique(frequencies_hz)) ~= ...
        numel(frequencies_hz)
    error('kwsim:InvalidFrequencySweep', ...
        'Use at least three unique, finite, positive frequencies.');
end
if ~base_cfg.attenuation.enabled
    error('kwsim:AttenuationDisabled', ...
        'The Stage 4 base configuration must enable attenuation.');
end

strict = logical(base_cfg.diagnostics.fail_on_invalid);
frequencies_hz = sort(frequencies_hz);
pair_cells = cell(numel(frequencies_hz), 1);
for index = 1:numel(frequencies_hz)
    f0_hz = frequencies_hz(index);
    attenuated_cfg = base_cfg;
    attenuated_cfg.stage = 4;
    attenuated_cfg.source.f0_hz = f0_hz;
    attenuated_cfg.scenario = base_cfg.scenario + sprintf('_%g_hz', f0_hz);
    attenuated_cfg.output.directory = "";
    attenuated_cfg.output.save_time_series = false;
    attenuated_cfg.diagnostics.fail_on_invalid = false;

    lossless_cfg = attenuated_cfg;
    lossless_cfg.attenuation.enabled = false;
    lossless_cfg.scenario = attenuated_cfg.scenario + "_lossless";

    [lossless, lossless_report] = kwsim.two_d.run(lossless_cfg);
    [attenuated, attenuated_report] = kwsim.two_d.run(attenuated_cfg);
    pair_cells{index} = kwsim.diagnostics.evaluateStage4Pair( ...
        attenuated, attenuated_report, lossless, lossless_report);

    if strlength(string(output_directory)) > 0
        frequency_directory = fullfile(string(output_directory), ...
            sprintf('f_%06g_hz', f0_hz));
        kwsim.common.saveRun(lossless, lossless_report, ...
            fullfile(frequency_directory, "lossless"), ...
            Overwrite=options.Overwrite);
        kwsim.common.saveRun(attenuated, attenuated_report, ...
            fullfile(frequency_directory, "attenuated"), ...
            Overwrite=options.Overwrite);
    end
end

pairs = vertcat(pair_cells{:});
sweep = kwsim.diagnostics.evaluateStage4Sweep(pairs, base_cfg);
if strlength(string(output_directory)) > 0
    kwsim.diagnostics.saveStage4Sweep(sweep, output_directory, ...
        Overwrite=options.Overwrite);
end
if strict && ~sweep.valid
    failed_names = strjoin([sweep.checks(~[sweep.checks.pass]).name], ', ');
    error('kwsim:Stage4ValidationFailed', ...
        'Stage 4 sweep was saved but failed diagnostics: %s', failed_names);
end

end
