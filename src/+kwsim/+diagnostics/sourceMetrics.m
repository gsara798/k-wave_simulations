function varargout = sourceMetrics(varargin)
%sourceMetrics Compatibility wrapper for kwsim.analysis.sourceMetrics.
%
% This wrapper preserves the original API during the v2 architecture
% migration. New code should call kwsim.analysis.sourceMetrics directly.

if nargout == 0
    kwsim.analysis.sourceMetrics(varargin{:});
else
    [varargout{1:nargout}] = kwsim.analysis.sourceMetrics(varargin{:});
end

end
