function varargout = symmetryMetrics(varargin)
%symmetryMetrics Compatibility wrapper for kwsim.analysis.symmetryMetrics.
%
% This wrapper preserves the original API during the v2 architecture
% migration. New code should call kwsim.analysis.symmetryMetrics directly.

if nargout == 0
    kwsim.analysis.symmetryMetrics(varargin{:});
else
    [varargout{1:nargout}] = kwsim.analysis.symmetryMetrics(varargin{:});
end

end
