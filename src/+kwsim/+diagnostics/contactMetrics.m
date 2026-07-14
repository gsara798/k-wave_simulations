function varargout = contactMetrics(varargin)
%contactMetrics Compatibility wrapper for kwsim.analysis.contactMetrics.
%
% This wrapper preserves the original API during the v2 architecture
% migration. New code should call kwsim.analysis.contactMetrics directly.

if nargout == 0
    kwsim.analysis.contactMetrics(varargin{:});
else
    [varargout{1:nargout}] = kwsim.analysis.contactMetrics(varargin{:});
end

end
