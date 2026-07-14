function tests = test_stage4_attenuation
%TEST_STAGE4_ATTENUATION Unit tests for power-law and Kelvin-Voigt mapping.
tests = functiontests(localfunctions);
end

function setupOnce(~)
root = fileparts(fileparts(fileparts(mfilename('fullpath'))));
addpath(fullfile(root, 'src'));
end

function testPowerLawEvaluation(testCase)
alpha = kwsim.common.evaluatePowerLawAttenuation(1, 500, 1.2, 250);
verifyEqual(testCase, alpha, 0.5^1.2, 'AbsTol', 1e-14);
end

function testReferenceConversionAndTruthMaps(testCase)
cfg = kwsim.two_d.stage4Config();
[resolved, preflight] = kwsim.two_d.validateConfig(cfg);
[medium, truth] = kwsim.two_d.buildMedium(resolved);
verifyTrue(testCase, preflight.valid);
verifyEqual(testCase, resolved.source.layout, "single_contact");
verifyEqual(testCase, resolved.source.contact_model, "point");
verifyEqual(testCase, unique(medium.alpha_coeff_shear), 4e6, ...
    'RelTol', 1e-14);
verifyEqual(testCase, unique(truth.attenuation_db_cm_xz), 1, ...
    'AbsTol', 1e-14);
verifyGreaterThanOrEqual(testCase, min(truth.attenuation.chi_pa_s_xz, [], 'all'), 0);
end

function testLosslessModeOmitsSolverCoefficients(testCase)
cfg = kwsim.two_d.defaultConfig();
[resolved, ~] = kwsim.two_d.validateConfig(cfg);
[medium, truth] = kwsim.two_d.buildMedium(resolved);
verifyFalse(testCase, isfield(medium, 'alpha_coeff_shear'));
verifyFalse(testCase, truth.attenuation.enabled);
verifyEqual(testCase, truth.attenuation_db_cm_xz, ...
    zeros(cfg.grid.Nx, cfg.grid.Nz));
end

function testHeterogeneousMaterialsMapExactly(testCase)
cfg = kwsim.two_d.circularInclusionConfig();
cfg.stage = 4;
cfg.grid.cfl = 0.025;
% This unit test validates material rasterization only; the 96-by-95 Stage 2
% sensor is intentionally not executed at the viscous time step.
cfg.diagnostics.maximum_sensor_memory_bytes = Inf;
cfg.attenuation.enabled = true;
cfg.attenuation.materials = [ ...
    kwsim.two_d.makeAttenuationMaterial(1), ...
    kwsim.two_d.makeAttenuationMaterial(2, ShearAlphaRefDbCm=2, ...
        CompressionAlphaRefDbCm=2)];
[resolved, ~] = kwsim.two_d.validateConfig(cfg);
[~, truth] = kwsim.two_d.buildMedium(resolved);
background = truth.material_id_xz == 1;
inclusion = truth.material_id_xz == 2;
verifyEqual(testCase, unique( ...
    truth.attenuation.shear_alpha_at_f0_db_cm_xz(background)), 1);
verifyEqual(testCase, unique( ...
    truth.attenuation.shear_alpha_at_f0_db_cm_xz(inclusion)), 2);
end

function testRejectsMissingMaterialLaw(testCase)
cfg = kwsim.two_d.circularInclusionConfig();
cfg.stage = 4;
cfg.grid.cfl = 0.05;
cfg.attenuation.enabled = true;
verifyError(testCase, @() kwsim.two_d.validateConfig(cfg), ...
    'kwsim:InvalidConfiguration');
end

function testRejectsLosslessCflForKelvinVoigt(testCase)
cfg = kwsim.two_d.stage4Config();
cfg.grid.cfl = 0.2;
verifyError(testCase, @() kwsim.two_d.validateConfig(cfg), ...
    'kwsim:InvalidConfiguration');
end

function testRejectsNegativeVolumetricViscosity(testCase)
cfg = kwsim.two_d.stage4Config();
cfg.attenuation.materials = kwsim.two_d.makeAttenuationMaterial(1, ...
    ShearAlphaRefDbCm=1, CompressionAlphaRefDbCm=1e-5);
verifyError(testCase, @() kwsim.two_d.validateConfig(cfg), ...
    'kwsim:InvalidConfiguration');
end
