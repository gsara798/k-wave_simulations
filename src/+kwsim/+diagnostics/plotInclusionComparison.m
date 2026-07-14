function varargout = plotInclusionComparison(varargin)
%plotInclusionComparison Compatibility wrapper for kwsim.viz.plotInclusionComparison.
%
% This wrapper preserves the original API during the v2 architecture
% migration. New code should call kwsim.viz.plotInclusionComparison directly.

if nargout == 0
    kwsim.viz.plotInclusionComparison(varargin{:});
else
    [varargout{1:nargout}] = kwsim.viz.plotInclusionComparison(varargin{:});
end

end
