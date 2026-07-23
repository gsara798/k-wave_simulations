function tests = test_campaign_configuration
%TEST_CAMPAIGN_CONFIGURATION Test campaign contract v1 loading.

tests = functiontests(localfunctions);

end


function setupOnce(testCase)

repository_root = fileparts(fileparts(fileparts( ...
    mfilename("fullpath"))));

addpath(fullfile(repository_root, "src"));

testCase.TestData.repository_root = ...
    string(repository_root);

testCase.TestData.base_config = ...
    "configs/two_d/homogeneous_directional_cli.json";

end


function testLoadsExampleCampaign(testCase)

campaign_file = fullfile( ...
    testCase.TestData.repository_root, ...
    "configs", ...
    "campaigns", ...
    "homogeneous_directional_2d_sweep.json");

[campaign, metadata] = ...
    kwsim.campaigns.loadCampaignJson(campaign_file);

verifyEqual(testCase, ...
    campaign.schema_version, ...
    "1.0");

verifyEqual(testCase, ...
    campaign.campaign_name, ...
    "homogeneous_directional_2d_sweep");

verifyEqual(testCase, ...
    campaign.output.directory, ...
    "outputs/campaigns");

verifyTrue(testCase, ...
    isfile(campaign.base_config));

verifyEqual(testCase, ...
    metadata.base_config.dimension, ...
    2);

verifyEqual(testCase, ...
    metadata.parameter_count, ...
    3);

verifyEqual(testCase, ...
    metadata.value_counts, ...
    [3; 2; 2]);

verifyEqual(testCase, ...
    metadata.expanded_run_count, ...
    12);

end


function testUsesDefaultOutputDirectory(testCase)

campaign = makeValidCampaign(testCase);
campaign = rmfield(campaign, "output");

campaign_file = writeTemporaryJson(campaign);
cleanup = onCleanup(@() deleteIfPresent(campaign_file));

[loaded, ~] = ...
    kwsim.campaigns.loadCampaignJson(campaign_file);

verifyEqual(testCase, ...
    loaded.output.directory, ...
    "outputs/campaigns");

clear cleanup

end


function testRejectsUnknownTopLevelField(testCase)

campaign = makeValidCampaign(testCase);
campaign.unexpected = true;

campaign_file = writeTemporaryJson(campaign);
cleanup = onCleanup(@() deleteIfPresent(campaign_file));

verifyError(testCase, ...
    @() kwsim.campaigns.loadCampaignJson(campaign_file), ...
    "kwsim:UnknownCampaignField");

clear cleanup

end


function testRejectsMissingRequiredField(testCase)

campaign = makeValidCampaign(testCase);
campaign = rmfield(campaign, "campaign_name");

campaign_file = writeTemporaryJson(campaign);
cleanup = onCleanup(@() deleteIfPresent(campaign_file));

verifyError(testCase, ...
    @() kwsim.campaigns.loadCampaignJson(campaign_file), ...
    "kwsim:MissingCampaignField");

clear cleanup

end


function testRejectsUnsupportedSchema(testCase)

campaign = makeValidCampaign(testCase);
campaign.schema_version = "2.0";

campaign_file = writeTemporaryJson(campaign);
cleanup = onCleanup(@() deleteIfPresent(campaign_file));

verifyError(testCase, ...
    @() kwsim.campaigns.loadCampaignJson(campaign_file), ...
    "kwsim:UnsupportedCampaignSchema");

clear cleanup

end


function testRejectsUnknownSweepPath(testCase)

campaign = makeValidCampaign(testCase);
campaign.sweep.path = "medium.css_m_s";

campaign_file = writeTemporaryJson(campaign);
cleanup = onCleanup(@() deleteIfPresent(campaign_file));

verifyError(testCase, ...
    @() kwsim.campaigns.loadCampaignJson(campaign_file), ...
    "kwsim:UnknownCampaignSweepPath");

clear cleanup

end


function testRejectsDuplicateSweepPath(testCase)

campaign = makeValidCampaign(testCase);

campaign.sweep(2) = struct( ...
    "path", "medium.cs_m_s", ...
    "values", [3.0, 3.5]);

campaign_file = writeTemporaryJson(campaign);
cleanup = onCleanup(@() deleteIfPresent(campaign_file));

verifyError(testCase, ...
    @() kwsim.campaigns.loadCampaignJson(campaign_file), ...
    "kwsim:DuplicateCampaignSweepPath");

clear cleanup

end


function testRejectsOutputSweepPath(testCase)

campaign = makeValidCampaign(testCase);
campaign.sweep.path = "output.run_name";

campaign_file = writeTemporaryJson(campaign);
cleanup = onCleanup(@() deleteIfPresent(campaign_file));

verifyError(testCase, ...
    @() kwsim.campaigns.loadCampaignJson(campaign_file), ...
    "kwsim:ForbiddenCampaignSweepPath");

clear cleanup

end


function testRejectsDimensionSweepPath(testCase)

campaign = makeValidCampaign(testCase);
campaign.sweep.path = "dimension";

campaign_file = writeTemporaryJson(campaign);
cleanup = onCleanup(@() deleteIfPresent(campaign_file));

verifyError(testCase, ...
    @() kwsim.campaigns.loadCampaignJson(campaign_file), ...
    "kwsim:ForbiddenCampaignSweepPath");

clear cleanup

end


function campaign = makeValidCampaign(testCase)

campaign = struct();
campaign.schema_version = "1.0";
campaign.campaign_name = "unit_test_campaign";
campaign.base_config = testCase.TestData.base_config;
campaign.output = struct( ...
    "directory", "outputs/campaigns");
campaign.sweep = struct( ...
    "path", "medium.cs_m_s", ...
    "values", [2.0, 2.5]);

end


function campaign_file = writeTemporaryJson(campaign)

campaign_file = string(tempname) + ".json";

file_id = fopen(campaign_file, "w");

if file_id < 0
    error("Could not create temporary campaign JSON file.");
end

cleanup = onCleanup(@() fclose(file_id));

fprintf(file_id, "%s", ...
    jsonencode(campaign, PrettyPrint=true));

clear cleanup

end


function deleteIfPresent(path)

if isfile(path)
    delete(path);
end

end
