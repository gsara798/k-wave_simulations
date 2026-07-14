function varargout = plotContactSizeSweep(varargin)
%plotContactSizeSweep Compatibility wrapper for kwsim.viz.plotContactSizeSweep.
%
% This wrapper preserves the original API during the v2 architecture
% migration. New code should call kwsim.viz.plotContactSizeSweep directly.

if nargout == 0
    kwsim.viz.plotContactSizeSweep(varargin{:});
else
    [varargout{1:nargout}] = kwsim.viz.plotContactSizeSweep(varargin{:});
end

end
