function tests = test_stage4_run
%TEST_STAGE4_RUN Integration test for independent attenuation frequency pairs.
tests = functiontests(localfunctions);
end

function setupOnce(~)
root = fileparts(fileparts(fileparts(mfilename('fullpath'))));
addpath(fullfile(root, 'src'));
end

function testCompactPowerLawSweepPasses(testCase)
cfg = kwsim.diagnostics.compactStage4Config();
sweep = kwsim.two_d.runFrequencySweep(cfg, [300, 400, 500]);
verifyTrue(testCase, sweep.valid, sweep.summary);
verifyLessThanOrEqual(testCase, max(sweep.relative_errors), 0.05);
verifyLessThanOrEqual(testCase, sweep.power_y_absolute_error, 0.05);
verifyTrue(testCase, all(arrayfun(@(p) ...
    p.estimate.vector_shear.r_squared >= 0.98, sweep.pairs)));
end
