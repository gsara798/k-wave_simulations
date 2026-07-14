function [figure_handle, output_file] = plotResults(validation, output_file)
%PLOTRESULTS Plot finite-contact source banks, fields, and angular spectra.

arguments
    validation struct
    output_file {mustBeTextScalar} = ""
end

[figure_handle, output_file] = ...
    kwsim_benchmarks.field_regimes_2d.plotResults( ...
        validation, output_file);

end
