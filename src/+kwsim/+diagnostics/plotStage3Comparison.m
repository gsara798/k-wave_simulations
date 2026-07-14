function varargout = plotStage3Comparison(varargin)
%plotStage3Comparison Compatibility wrapper for kwsim.viz.plotStage3Comparison.
%
% This wrapper preserves the original API during the v2 architecture
% migration. New code should call kwsim.viz.plotStage3Comparison directly.

if nargout == 0
    kwsim.viz.plotStage3Comparison(varargin{:});
else
    [varargout{1:nargout}] = kwsim.viz.plotStage3Comparison(varargin{:});
end

end
