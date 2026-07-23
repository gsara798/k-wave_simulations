# Campaign configuration contract v1

A simulation campaign defines a deterministic Cartesian expansion of one
existing, validated simulation configuration.

Campaigns orchestrate `kwsim.cli.runConfig`. They do not implement solver,
source, material, geometry, validation, or single-run output logic.

## Required fields

```json
{
  "schema_version": "1.0",
  "campaign_name": "example_campaign",
  "base_config": "configs/two_d/example.json",
  "sweep": [
    {
      "path": "medium.cs_m_s",
      "values": [2.0, 2.5]
    }
  ]
}
```

### `schema_version`

Must be the string `"1.0"`.

### `campaign_name`

Non-empty identifier used as the campaign directory name. It must contain only
letters, numbers, underscores, and hyphens.

### `base_config`

Path to an existing single-run JSON configuration accepted by
`kwsim.io.loadConfigJson` and `kwsim.cli.runConfig`.

Repository-relative paths are resolved from the repository root. The base
configuration fixes the simulation dimension; `dimension` cannot be swept in
contract v1.

### `sweep`

Non-empty ordered array of sweep definitions.

Each definition contains:

- `path`: dot-separated path to an existing field in the resolved base
  configuration.
- `values`: non-empty JSON array of replacement values.

The Cartesian expansion follows the declared parameter order. The last
parameter varies fastest.

Unknown paths are errors. Duplicate paths are errors. Structural values,
including geometry object arrays, replace the addressed value as a complete
unit.

Paths under `output` cannot be swept. Campaign execution owns the output
directory, run name, timestamp policy, and overwrite policy.

## Optional fields

### `output.directory`

Root directory for campaign outputs. The default is:

```text
outputs/campaigns
```

The campaign runner creates:

```text
<output.directory>/<campaign_name>/
```

## Expansion and identity

The example

```text
3 SWS values × 2 frequencies × 2 seeds
```

expands to 12 runs.

Each run receives a deterministic ordinal and hash:

```text
run_000001_<hash>
```

The hash is calculated from the canonical single-run definition after applying
the sweep overrides and before injecting campaign-controlled output paths.
Therefore, relocating a campaign does not change run identity.

## Validation

Campaign dry-run must:

1. load and validate the campaign configuration;
2. load the base configuration;
3. expand every Cartesian combination;
4. apply each override;
5. validate every expanded configuration through
   `kwsim.cli.runConfig(..., DryRun=true)`;
6. create no campaign or simulation outputs.

A campaign is not executable if any expanded configuration fails dry-run
validation.

## Scope exclusions in v1

Contract v1 does not include:

- sweeping between 2D and 3D;
- calculated parameter expressions;
- parallel or cluster execution;
- adaptive or optimization-driven sampling;
- changes to solver or physical validation behavior.
