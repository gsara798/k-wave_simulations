function varargout = plotRun(varargin)
%plotRun Compatibility wrapper for kwsim.viz.plotRun.
%
% This wrapper preserves the original API during the v2 architecture
% migration. New code should call kwsim.viz.plotRun directly.

if nargout == 0
    kwsim.viz.plotRun(varargin{:});
else
    [varargout{1:nargout}] = kwsim.viz.plotRun(varargin{:});
end

end
