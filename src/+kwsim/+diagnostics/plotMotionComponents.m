function varargout = plotMotionComponents(varargin)
%plotMotionComponents Compatibility wrapper for kwsim.viz.plotMotionComponents.
%
% This wrapper preserves the original API during the v2 architecture
% migration. New code should call kwsim.viz.plotMotionComponents directly.

if nargout == 0
    kwsim.viz.plotMotionComponents(varargin{:});
else
    [varargout{1:nargout}] = kwsim.viz.plotMotionComponents(varargin{:});
end

end
